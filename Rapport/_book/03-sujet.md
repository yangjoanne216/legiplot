
# Le sujet du stage {#Sujet}

Le sujet de mon stage est quantification les évolutions législatives, en particulière pour les évolutions de la propriété intellectuelle. Les données pertinentes seront utilisées dans les recherches du CEIPI.

## D'où viennent les données

Il existe trois dépôts git présentent les données législatives françaises :
**Legifrance** : https://github.com/legifrance

**Etalab** : https://github.com/etalab/codes-juridiques-francais

**Archeo Lex**: https://archeo-lex.fr/

Nous avons finalement choisi Archeo Lex. Bien que ses données ne soient pas aussi précises qu'EtabLab, mais il régulièrement mis à jour les données. En plus, ses données sont organisées bien, chaque code est placé dans un fichier séparé et nous pouvons trouver toutes les versions dans l’ordre.

\begin{figure}

{\centering \includegraphics[width=27.28in]{images/archeoLex_Structure} 

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




