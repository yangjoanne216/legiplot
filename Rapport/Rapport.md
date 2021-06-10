--- 
title: "Rapport de stage"
author: "Yang YANG"
date: "2021-06-10"
output: pdf_document
documentclass: book
classoption: oneside
bibliography:
- book.bib
- packages.bib
biblio-style: apalike
link-citations: yes
description: This is a minimal example of using the bookdown package to write a book.
  The output format for this example is bookdown::gitbook.
site: bookdown::bookdown_site
geometry: margin=1.5cm
header-includes:
- \usepackage{fancyhdr}
- \usepackage{lastpage}
---

# Introduction

Dans le cadre du dernier semestre de DUT Informatique, un stage de 10 semaines est demandé pour la validation du diplôme. CEIPI m’a donné l’opportunité de réaliser mon stage à Strasbourg. Monsieur Julien Gossa exerce la fonction de responsable pédagogique et Monsieur Franck Macrez est mon tuteur professionnel.  

Avant le stage, grâce aux explications de M. Gossa et un exemple préliminaire placé sur github, j'avais une compréhension globale pour ce stage. Le sujet est évalué le rythme des réformes par l’exploitation des dépôts git des codes. Et les résultats vont être visualisé pour les professionnels du droit.

Et le premier jour du stage, j'ai visité le bâtiment du CEIPI avec M. Gossa et rencontré M.  Macrez. Après deux heures de communication, j'ai compris mieux les attentes du CEIPI, cela nous aide à l’élaboration de plans et le choix des outils.

Après ce rencontre, M. Gossa a créé un calendrier et publié des tâches spécifiques sur github de temps en temps pour contrôler la progression du stage. En effet, à cause de la situation sanitaire je fais mon travail à distance et le discord est le media de communication, mais il y avait aussi des réunions physiques lorsque nécessaire.

Les 350 heures de travail, qui représentes donc les 35 heures hebdomadaires d’un stage de dix semaines ont été effectué sur deux mois. 

Ce rapport présentera la manière dont a été traité le sujet, les outils utilisés, les résultats que l’on a obtenus mais aussi comment surmonter certains problèmes techniques. En effet, pendant tout le processus de stage.
 

<!--chapter:end:index.Rmd-->

---
output:
  pdf_document: default
  html_document: default
---
# Remerciement {#Remerc}

Je remercie toutes les personnes qui m’ont soutenu personnellement ainsi que professionnellement avant et au cours de ce stage. 

Tout d’abord, je remercie mon tuteur à l’IUT, **M. Gossa**, qui était toujours enthousiasme et patient pour répondre mes questions et proposer des solutions pratiques et qui a pris beaucoup de temps pour me guider et m’aider à organiser mon stage.

Je remercie également mon tuteur professionnel,**M. Macrez**, qui m'a emmené visiter et a présenté le CEIPI, et a expliqué les attentes du CEIPI pour ce stage.

J’adresse mon remerciement à **Mme. Kloess** à l’IUT et **Mme. Laplanche** au CEIPI qui s’ont occupé tous mes documents administratifs.

Finalement, j’aimerais remercier le jury qui écoute ma soutenance et qui me laisse une chance d’obtenir mon diplôme.








<!--chapter:end:01-remercie.Rmd-->

# Présentation du CEIPI

## Informations Générales
CEIPI (Centre d'études internationales de la propriété intellectuelle) est une composante sous forme d’institut de l’université de Strasbourg, créer en 1963, à l’initiative des professeurs Daniel Bastien et Hubert Forestier. Dès sa création, le CEIPI s’est donnée la mission de former des spécialistes du droit de la propriété intellectuelle qui seront chargés d’exercer les différentes professions dans le domaine de la propriété intellectuelle. 

CEIPI s’est installé le 2 mars 2020 dans un nouveau bâtiment situé dans l'enceinte de l'Hôpital civil à Strasbourg


\begin{figure}

{\centering \includegraphics[width=0.8\linewidth]{images/Location_du_CEIPI} 

}

\caption{Location du CEIPI}(\#fig:Location du CEIPI)
\end{figure}

## La structure
Le centre était composé de trois sections : 
La section française dispense aux spécialistes français un enseignement en matière de propriété intellectuelle à l'échelle nationale et internationale. 

La section internationale consacre son programme de formation au contrat de licence et s'adressait aux spécialistes français et étrangers, désirant acquérir des connaissances nécessaires de droit international. 

Le laboratoire de Recherche du CEIPI, créé en 2006, sa dénomination officielle est UR 4375-Laboratoire de recherche du CEIPI. Il coordonne des activités variées pour la mission de réflexion quant à l’évolution du droit de la propriété intellectuelle dans la société de la connaissance.

Plus des informations sur le site du CEIPI :https://www.ceipi.edu/


<!--chapter:end:02-Presentation.Rmd-->

---
output:
  word_document: default
  html_document: default
---
# Le sujet du stage {#Sujet}

Le sujet de mon stage est quantification les évolutions législatives, en particulière pour les évolutions de la propriété intellectuelle. Les données pertinentes seront utilisées dans les recherches du CEIPI.

## D'où viennent les données

Il existe trois dépôts git présentent les données législatives françaises :
**Legifrance** : https://github.com/legifrance

**Etalab** : https://github.com/etalab/codes-juridiques-francais

**Archeo Lex**: https://archeo-lex.fr/

Nous avons finalement choisi Archeo Lex. Bien que ses données ne soient pas aussi précises qu'EtabLab, mais il régulièrement mis à jour les données. En plus, ses données sont organisées bien, chaque code est placé dans un fichier séparé et nous pouvons trouver toutes les versions dans l’ordre.

\begin{figure}

{\centering \includegraphics{images/archeolex_structure} 

}

\caption{Les données dans Archeo Lex}(\#fig:ArcheoLex)
\end{figure}

## Traitement du sujet

Après discussion, le stage a été divisé en deux parties.
L’un est l’exploration de données, dont le but est de créer une application qui peuvent générer des documents csv différentes en modifiant la ligne de commande. 

L'autre est la visualisation des données.

## Choix des outils
### Langage
1.**Python** : nous avons choisi python comme langage d'exploration de données, car il contient de nombreux packages pouvant être appelés et il n'est pas difficile à apprendre.
Parmi eux, le package le plus important que nous utilisons est git-python*, qui peut être utilisé pour

2.**R et Rmd**: Nous avons choisi R comme langage de dessin. tidyverse, ggraphe et igraphe sont les plus fréquemment utilisés parmi les nombreux packages du langage R. La partie de code de R est stockée sous la forme d'un fichier Rmd, et le rapport que vous en train de lire et la diapositive de la soutenance sont tous générés par le fichier Rmd.

### IDE
1.**Vscode** : l'outil d'environnement de développement le plus populaire. Il est très flexible et il est aussi techniquement abouti et très stable, je l’ai utilisé pour développer l’application python. 

2.**Rstudio**: un environnement de développement gratuit, libre et multiplateforme pour R.il sert au traitement de données et à l’analyse statistique





<!--chapter:end:03-sujet.Rmd-->

---
output:
  pdf_document: default
  html_document: default
---
# Application archeolex_excavation.py {#Application}

## Présentation Générale

**Rôle** : archeolex_excavation.py est utilisée pour fouiller des dépôts git Archéo Lex et générer des fichiers csv. Nous pouvons générer différents fichiers csv en modifiant les paramètres dans la ligne de commande.

**Usage** : archeolex_excavation.py [-h] [-d YYYY-MM-DD] [-f fichier.csv] [-t] [-v] diff|check| |stats [code ...]

**Example**:

```r
archeolex_excavation.py stats code_civil -d last -t -s1 -f test.csv
```

### Les paramètres

#### Positional arguments

| nom de paramètre| signification |
| ------ | ------ | 
| **diff/check/status **|**Le traitement à effectuer**|            
| diff | obtenir les informations de modification par article|
| check | détecter des erreurs des codes|
| status |  Les informations de sous-section d'une section, ainsi que le nombre de lignes et de mots dans cette section.Les paramètres d'entrée -s1 à -s6 (voir ci-dessous) pour confirmer le niveau de cette section.|
| **codes **|**La liste des codes à fouiller**| 

##### Les niveaus généraux de la structure des codes

Partie

Sous_partie

Livre

Titre

Chapitre

#### Optional arguments
| nom de paramètre| signification | 
| ------ | ------ | 
|  -h, --help | montrer le message de help et quitter |
|  -d YYYY-MM-DD, --datelimit YYYY-MM-DD| définir une date maximum pour la fouille |
|  -f nom.csv, --file nom.csv| écrit les données dans ce fichier csv (sortie standard par défaut)|
|  -t, --fulltext | détecter les noms entiers des section|
|  -s1 | Obtenir les informations de chaque chapitre|
|  -s2 | Obtenir les informations de chaque livre|
|  -s3 | Obtenir les informations de chaque titre|
|  -s4 | Obtenir les informations de chaque sous partie|
|  -s5 | Obtenir les informations de chaque partie|
|  -s6 | Obtenir les informations de chaque code|

#### Quelques fichies csv générés

##### Example 1:
\begin{figure}

{\centering \includegraphics[width=0.8\linewidth]{images/diff} 

}

\caption{les informations de modification par article}(\#fig:diff)
\end{figure}
##### Example 2:
L’application permet de détecter des erreurs de deux types :

- doublon : articles apparaissant deux fois dans un code ;
- inversion : deux articles consécutifs dont la numérotation n’est pas croissante.
Cette détection d’erreur est imparfaite, et n’exclu ni faux-positifs ni faux-négatifs. La date correspond à la version la plus ancienne à laquelle l’erreur a été détectée.

Les erreurs détectées sur un échantillon de codes se trouvent dans le fichier errors.csv, au format suivant :
\begin{figure}

{\centering \includegraphics[width=0.8\linewidth]{images/check} 

}

\caption{détecter des erreurs des codes}(\#fig:check)
\end{figure}

##### Example 3
\begin{figure}

{\centering \includegraphics[width=0.8\linewidth]{images/stats3} 

}

\caption{Les informations de sous-section des livres, ainsi que le nombre de lignes et de mots pour chaque livres.}(\#fig:stats3)
\end{figure}

##### Example 4
\begin{figure}

{\centering \includegraphics[width=0.8\linewidth]{images/stats6} 

}

\caption{Les informations de sous-section des chapitres, ainsi que le nombre de lignes et de mots pour chaque chapitre.}(\#fig:stats6)
\end{figure}

## Présentation technique

### La structure des codes
L'idée de code python est **orientée objet**,il y a trois fichiers python：

1.**Article.py**: un article doit être considéré comme un objet, et les attributs liés à l'article peuvent être trouvés dans cette classe. Par exemple, le chapitre, le livre , le code où il se trouve, sa date, etc. (voir l'UML dans la figure ci-dessous pour plus de détails).
Les fonctions permettent de modifier ou d'obtenir la valeur des attributs d'article.
\begin{figure}

{\centering \includegraphics[width=0.25\linewidth]{images/Article_UML} 

}

\caption{le diagramme UML pour Article.py}(\#fig:Article)
\end{figure}

2.**ArcheoLexLog.py**:
Le rôle de cette classe est de stocker des fonctions d'exploration et d'analyse de données. Cette classe appelle la classe Article et appelle également un package très important GitPython* pour obtenir des informations de git diff.
\begin{figure}

{\centering \includegraphics[width=0.5\linewidth]{images/ArcheoLexLog_UML} 

}

\caption{le diagramme UML pour ArcheoLexLog.py}(\#fig:ArcheoLexLog)
\end{figure}

3.**archeolex_excavation.py**:Ce fichier appelle les deux classes Article et ArcheoLexLog, définit les paramètres et contient la fonction main.

### problèmes rencontrés et solution
-1.Au début,l'idée était d'obtenir les informations de la structure de l'article à partir du nom. Par exemple : Article L312 -> L'article se trouve dans la partie législative, le troisième livre, le premier titre, le deuxième chapitre.
Cependant, il existe huit lois et leurs noms d'articles ne sont pas liés à la structure : code_civil code_de_l'artisanat code_de_la_famille_et_de_l'aide_sociale code_de_procédure_civile code_de_procédure_pénale code_des_postes_et_des_communicet_pélectroniquedemaraire_demarale_demarique

**Solution**: parcourir le texte complet du diff pour obtenir les informations de structure correspondantes. Et le nom complet(fulltext) de la structure est directement écrit dans la table sans utiliser le nom numérique.

-2.Un changement structurel après un commit. Par exemple: une nouvelle sous_section est ajoutée

**Solution**: ajouter du code pour détecter et enregistrer ce changement.

-3.Les dépots git sur Archeo Lex ont des problème. Par exemple: il y a un problème avec l'ordre des articles, et le même article du même commit a été modifié plusieurs fois.

**Solution**: ajout d'un paramètre check pour détecter et afficher les erreurs, et envoyer les erreurs à Archeo Lex.



<!--chapter:end:04-application.Rmd-->

---
output:
  pdf_document: default
  html_document: default
---
# Les images générés {#Images}






## modification et des visualisations

### Liste des codes et modifications

\begin{tabular}{l|r|l|l|r|r|r|r|r}
\hline
code & nb\_modifs & début & fin & parties & sous\_parties & livres & titres & chapitres\\
\hline
code\_civil & 6248 & 1803-03-15 & 2021-01-01 & 1 & 1 & 7 & 70 & 214\\
\hline
code\_de\_commerce & 16455 & 2000-12-14 & 2021-05-23 & 4 & 1 & 11 & 80 & 254\\
\hline
code\_de\_l'action\_sociale\_et\_des\_familles & 8513 & 2001-07-18 & 2021-05-21 & 3 & 1 & 8 & 49 & 238\\
\hline
code\_de\_l'éducation & 10754 & 2000-12-14 & 2021-05-24 & 2 & 6 & 15 & 97 & 274\\
\hline
code\_de\_la\_consommation & 6235 & 1994-01-04 & 2021-04-16 & 4 & 1 & 16 & 63 & 227\\
\hline
code\_de\_la\_propriété\_intellectuelle & 3227 & 1993-01-01 & 2021-05-14 & 2 & 6 & 17 & 27 & 111\\
\hline
code\_de\_la\_recherche & 441 & 2004-08-11 & 2021-01-01 & 1 & 1 & 5 & 21 & 75\\
\hline
code\_de\_la\_santé\_publique & 51280 & 1953-10-27 & 2021-05-27 & 6 & 10 & 87 & 290 & 1138\\
\hline
code\_de\_la\_sécurité\_intérieure & 4700 & 2012-12-23 & 2021-05-27 & 2 & 1 & 9 & 59 & 165\\
\hline
code\_de\_la\_sécurité\_sociale & 40633 & 1961-01-12 & 2021-05-23 & 5 & 1 & 37 & 185 & 646\\
\hline
code\_du\_travail & 48381 & 1973-07-11 & 2021-05-27 & 6 & 9 & 76 & 342 & 1220\\
\hline
code\_pénal & 3235 & 1992-07-23 & 2021-05-27 & 2 & 1 & 11 & 31 & 87\\
\hline
\end{tabular}

### Pourcentage de différents types de modifications

#### Toutes les années

```
## `summarise()` has grouped output by 'année'. You can override using the `.groups` argument.
```

![](05-images_files/figure-latex/global-1.pdf)<!-- --> 

#### Depuis 1950

```
## `summarise()` has grouped output by 'année'. You can override using the `.groups` argument.
```

![](05-images_files/figure-latex/global.zoom-1.pdf)<!-- --> 

### Nombre de modifications de chaque année

#### Depuis 1950

```
## `summarise()` has grouped output by 'année'. You can override using the `.groups` argument.
```

![](05-images_files/figure-latex/unnamed-chunk-1-1.pdf)<!-- --> 

#### Depuis 1999

```
## `summarise()` has grouped output by 'année'. You can override using the `.groups` argument.
```

![](05-images_files/figure-latex/unnamed-chunk-2-1.pdf)<!-- --> 


```
## `summarise()` has grouped output by 'code', 'partie', 'article'. You can override using the `.groups` argument.
```

### Etat actuel

```
## `summarise()` has grouped output by 'code'. You can override using the `.groups` argument.
```

![](05-images_files/figure-latex/modif.glob.plot1-1.pdf)<!-- --> 

### Nombre modifications par articles

![](05-images_files/figure-latex/modif.glob.plot2-1.pdf)<!-- --> 



```
## Warning: Unknown levels in `f`: Pr閑xistence
```

```
## `summarise()` has grouped output by 'code', 'article'. You can override using the `.groups` argument.
```

```
## `summarise()` has grouped output by 'code', 'date'. You can override using the `.groups` argument.
```


### Evolution de nombre de modifications

![](05-images_files/figure-latex/modif.evol.plot-1.pdf)<!-- --> 

## Evolution des volumes de codes



### Nombre de mots 
![](05-images_files/figure-latex/nb_mots-1.pdf)<!-- --> 

### Nombre de lignes 
![](05-images_files/figure-latex/nb_alineas-1.pdf)<!-- --> 

### Nombre d'article 
![](05-images_files/figure-latex/nb_articles-1.pdf)<!-- --> 


### Nombre moyen de lignes d'un article
![](05-images_files/figure-latex/alineas_par_article-1.pdf)<!-- --> 


### Nombre moyen de mots d'un article
![](05-images_files/figure-latex/mots_par_article-1.pdf)<!-- --> 

### Nombre moyen de mots d'une ligne
![](05-images_files/figure-latex/mots_par_alinea-1.pdf)<!-- --> 

## Structure
### Législative vs. Réglementaire



#### Nombre de mots de chaque partie(séparées) 
![](05-images_files/figure-latex/lr.all-1.pdf)<!-- --> 

#### Nombre de mots de chaque partie(combinées) 
![](05-images_files/figure-latex/lr.all.stack-1.pdf)<!-- --> 

#### Pourcentage de chaque partie

```
## `summarise()` has grouped output by 'date', 'code'. You can override using the `.groups` argument.
```

![](05-images_files/figure-latex/lr.all.fill-1.pdf)<!-- --> 

### Arborescence


{r tree.edu, fig.width=15, fig.height=15, out.width=500, out.height=500, fig.align="center"}
legiplot_tree("code de l'éducation")


{r tree.pro, fig.width=15, fig.height=15, out.width=500, out.height=500, fig.align="center"}
legiplot_tree("Code de la propriété")


## Modification pour chaque livre 

### Code de l'éducation

```r
stats.det <- read.csv("../stats_shortlist_ts3.csv",encoding = 'UTF-8') %>%
  filter(code == "code_de_l'éducation") %>%
  mutate(date = as.Date(date)) 
stats.det %>%
  ggplot(aes(x=date,y=nb_mots,fill=livre)) +
  geom_area(aes(group=livre)) +
  facet_grid(.~partie)  +
  theme_hc() + 
  theme(legend.position = "right")
```

![](05-images_files/figure-latex/det.1-1.pdf)<!-- --> 

Premier problème : les livres ne sont pas dans l'ordre : Livre IX < Livre V

Pour traiter ce problème, on force l'ordre des livres avec l'ordre dans le csv:



```r
stats.det %>%
    mutate_at(
    c("partie","sous_partie","livre"),
    function(x) factor(x,unique(x))
    ) %>%
  ggplot(aes(x=date,y=nb_mots,fill=livre)) +
  geom_area(aes(group=livre)) +
  facet_grid(.~partie)  +
  theme_hc() + 
  theme(legend.position = "right")
```

![](05-images_files/figure-latex/det.2-1.pdf)<!-- --> 

Deuxième problème : des titres changent au cours du temps.

Pour traiter ce problème, on va supprimer ces titres :


```r
stats.det %>%
  mutate_at(
    c("sous_partie","livre"),
    function(x) gsub("(.*) :.*", "\\1",x)
    ) %>%
    mutate_at(
    c("partie","sous_partie","livre"),
    function(x) factor(x,unique(x))
    ) %>%
  ggplot(aes(x=date,y=nb_mots,fill=livre)) +
  geom_area(aes(group=livre)) +
  facet_grid(.~partie)  +
  theme_hc() + 
  theme(legend.position = "right")
```

![](05-images_files/figure-latex/det.3-1.pdf)<!-- --> 

### Code de la propriété intellectuelle



![](05-images_files/figure-latex/pi.livres-1.pdf)<!-- --> 

<!--chapter:end:05-images.Rmd-->



<!--chapter:end:06-references.Rmd-->

