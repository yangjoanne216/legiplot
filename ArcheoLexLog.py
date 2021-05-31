from Article import Article
from datetime import datetime
import os
import re
import git
import dateparser
import csv
import sys
import shutil

class ArcheoLexLog:
    def __init__(self, code, verbose=False, PLTC_method="code"):
        self.code=code
        self.verbose=verbose
        self.PLTC_method=PLTC_method

    def createRepo(self):
        """Créer ou mettre à jour un dossier contenant les codes requises
        on clone les codes requis sur git et les place dqns les dossier
        correspondant de archeo_lex,Si un code existe déjà,exécute git pull
        Arg:
        returns: le dépôt GIT du code
        Raises：
        IOError:une erreur se produit lorsque on entre les mauvais noms
        GitCommandError:une erreur se produit lorsque il y a un merge
        """
        dir_path=sys.path[0]
        path=dir_path+'/archeo_lex/'+self.code

        try:
            repo = git.Repo.clone_from(url ='https://archeo-lex.fr/codes/'+self.code,to_path=path)
        except git.GitCommandError as gce:
            if "already exists and is not an empty directory" in gce.stderr:
                try:
                    repo = git.Repo(path)
                    repo.git.pull()
                except git.InvalidGitRepositoryError as gre:
                    sys.stderr.write("Problème avec le dossier "+path+"\n")
                    sys.exit(1)
            else:
                sys.stderr.write("Erreur avec "+self.code+" : "+gce.stderr+"\n")
                sys.exit(1)

        return repo


    def getVersion(self,commit):
        sha=commit.hexsha
        short_sha=self.repo.git.rev_parse(sha, short=7)
        version = short_sha
        return version

    def getDate(self,commit):
        date_fr=" ".join(re.findall('(?<=au).*$',commit.message))
        date=dateparser.parse(date_fr).date().strftime("%Y-%m-%d")
        return date

    def getDifflines(self,commit):
        """Obtenir les différences entre cette version et la version précédentes

            Arg:
                commit:Commit(type) numéro de version

            return:
                lines:list des informations différentes
        """
        diff = commit.parents[0].diff(commit, create_patch=True, unified=100000000).pop()
        cmp = diff.diff.decode('utf-8').splitlines()
        return list(cmp)

    def getLines(self,commit):
        """Obtenir les lignes de cette version

            Arg:
                commit:Commit(type) numéro de version

            return:
                lines:liste des lignes
        """
        lignes = commit.tree[0].data_stream.read().decode('utf-8').splitlines()
        return list(lignes)

    @staticmethod
    def _getTypeLine(line):
        if line.startswith('-'):             # -######Article est Supression
            type_line = "Suppression"
        elif line.startswith('+'):           # +######Article est Ajout
            type_line = "Ajout"
        else:
            type_line = None
        return type_line

    @staticmethod
    def outputHeader(csvwriter):
        """ Affiche l'entête
        """
        csvwriter.writerow(['code','version','date','partie','sous_partie','livre','titre','chapitre','article','type'])

    def outputInfo(self,mod,csvwriter):
        """ Affiche une ligne
        """
        csvwriter.writerow([self.code, mod.version, mod.date,
            mod.partie,mod.sous_partie,mod.livre,mod.titre,mod.chapitre,
            mod.article,mod.type])

    def getDiff(self,commit):
        """Obtenez toutes les modifications d'une version d'un code

            Parcourez les informations de différence, nous extrayons les informations
            correspondantes du nom de l'article

            Arg:
                number_commit: Commit(type) de version

            return:
                mods:dict qui répresente une modification(un dict)
        """
        #get la version et la date
        date = self.getDate(commit)
        version = self.getVersion(commit)
        #get lines in diff
        lines=self.getDifflines(commit)
        if self.verbose:
            with open(self.code+'-'+date+'.txt', 'w',encoding="utf-8") as verbfile:
                verbfile.write('\n'.join(str(line) for line in lines))

        curmod = None # modification courante
        cursec = [] # section courante
        mods = {}

        for num,line in enumerate(lines):
            # Détection du type de la ligne
            type_line = self._getTypeLine(line)

            # Si changement de section, enregistrer la nouvelle section
            if (len(line) > 2 and line[1] == '#'):
                level = line.count("#")
                cursec = cursec[:level-1]+[re.sub(".*# ","",line)]

                # Si changement d'article
                if line.find("Article") != -1:
                    # Si une modification a été détectée, l'enregistrer
                    if curmod is not None and curmod.type is not None:
                        if curmod.article in mods:
                            nbm = mods[curmod.article].nb_modifications + curmod.nb_modifications
                            if nbm == 0:
                                del mods[curmod.article]
                            else:
                                mods[curmod.article].type = "Modification"
                                mods[curmod.article].nb_modifications = nbm
                        else:
                            mods[curmod.article] = curmod

                    # Réinitialiser la modification courante
                    curmod = Article(self.code, date, version, type_line, cursec, self.PLTC_method)

            # Si pas de changement de section, on vérifie juste s'il n'y a pas de modifications,
            # dans une ligne non vide
            elif type_line is not None and len(line[1:].strip()) > 0 and curmod is not None:
                if curmod.type is None : curmod.type = "Modification"
                curmod.nb_modifications += 1
        return mods

    def getErrors(self,commit):
        """Obtenez toutes les erreurs d'une version d'un code
            Arg:
                number_commit: Commit(type) de version
        """
        #get la version et la date
        date = self.getDate(commit)
        version = self.getVersion(commit)
        cursec = [] # section courante
        errors = {}
        article_precedent = None

        #get lines du code
        lines=self.getLines(commit)
        if self.verbose:
            with open(self.code+'-'+date+'.txt', 'w',encoding="utf-8") as verbfile:
                verbfile.write('\n'.join(str(line) for line in lines))

        for num,line in enumerate(lines):
            # Si changement de section, enregistrer la nouvelle section
            if (len(line) > 2 and line[2] == '#'):
                level = line.count("#")
                cursec = cursec[:level-1]+[re.sub(".*# ","",line)]

                # Si changement d'article
                if line.find("Article") != -1:
                    article = Article(self.code, date, version, None, cursec, self.PLTC_method)
                    cmp = article.compareNum(article_precedent)

                    # Test doublon
                    if cmp == "eq":
                        article.type = "doublon"
                        errors[article.article] = article

                    # Test inversion
                    if cmp == "lt":
                        article.type = "inversion "+article_precedent.article
                        errors[article.article] = article

                    article_precedent = article
        return errors

    def processCode(self,datelimit,csvwriter,traitement="check",print_progression=False):
        """Obtenir tous les versions d'un et pour chaque version on fonction getDiff()
        """
        self.repo = self.createRepo()

        #obtenir tous les version
        commit_log = self.repo.git.log('--pretty={"%h"}')
        log_list = commit_log.split("\n")

        if traitement == "diff":
            log_list.pop()  #supprimer la version la plus ancienne

        if traitement == "check":
            log_list.reverse()  #ordre chronologique

        articles = []

        for log in log_list:
            commit_number ="".join(re.findall(r"{\"(.+?)\"}",log))
            commit=self.repo.commit(commit_number)
            date=self.getDate(commit)

            if datelimit != None:
                if traitement == "diff" and date < datelimit: return()
                if traitement == "check" and date > datelimit: return()

            if print_progression:
                sys.stderr.write("\r"+self.code+" "+date+" " * 50)

            if traitement == "check":
                errors = self.getErrors(commit)
                for e in errors:
                    if errors[e].article not in articles:
                        self.outputInfo(errors[e], csvwriter)
                        articles.append(errors[e].article)
            else:
                mods = self.getDiff(commit)
                for m in mods:
                    self.outputInfo(mods[m], csvwriter)
