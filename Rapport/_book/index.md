--- 
title: "Rapport de stage"
author: "Yang YANG"
date: "2021-06-10"
output:
  pdf_document: default
  word_document: default
  html_document: default
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


```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
```

```
## v ggplot2 3.3.3     v purrr   0.3.4
## v tibble  3.1.2     v dplyr   1.0.6
## v tidyr   1.1.3     v stringr 1.4.0
## v readr   1.4.0     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
knitr::opts_chunk$set(cache=TRUE,include=FALSE)
options(dplyr.summarise.inform = FALSE)
```

# Introduction

Dans le cadre du dernier semestre de DUT Informatique, un stage de 10 semaines est demandé pour la validation du diplôme. CEIPI m’a donné l’opportunité de réaliser mon stage à Strasbourg. Monsieur Julien Gossa exerce la fonction de responsable pédagogique et Monsieur Franck Macrez est mon tuteur professionnel.  

Avant le stage, grâce aux explications de M. Gossa et un exemple préliminaire placé sur github, j'avais une compréhension globale pour ce stage. Le sujet est évalué le rythme des réformes par l’exploitation des dépôts git des codes. Et les résultats vont être visualisé pour les professionnels du droit.

Et le premier jour du stage, j'ai visité le bâtiment du CEIPI avec M. Gossa et rencontré M.  Macrez. Après deux heures de communication, j'ai compris mieux les attentes du CEIPI, cela nous aide à l’élaboration de plans et le choix des outils.

Après ce rencontre, M. Gossa a créé un calendrier et publié des tâches spécifiques sur github de temps en temps pour contrôler la progression du stage. En effet, à cause de la situation sanitaire je fais mon travail à distance et le discord est le media de communication, mais il y avait aussi des réunions physiques lorsque nécessaire.

Les 350 heures de travail, qui représentes donc les 35 heures hebdomadaires d’un stage de dix semaines ont été effectué sur deux mois. 

Ce rapport présentera la manière dont a été traité le sujet, les outils utilisés, les résultats que l’on a obtenus mais aussi comment surmonter certains problèmes techniques. En effet, pendant tout le processus de stage.
 
