
# Les images générés {#Images}






## modification et des visualisations

### Liste des codes et modifications

\begin{tabular}{l|r|l|l|r|r|r|r|r}
\hline
code & nb\_modifs & début & fin & parties & sous\_parties & livres & titres & chapitres\\
\hline
code\_civil & 6259 & 1803-03-14 & 2021-01-01 & 1 & 1 & 7 & 70 & 214\\
\hline
code\_de\_commerce & 18373 & 2000-09-21 & 2021-05-23 & 4 & 1 & 11 & 81 & 258\\
\hline
code\_de\_l'action\_sociale\_et\_des\_familles & 9066 & 2000-12-23 & 2021-05-21 & 3 & 1 & 8 & 49 & 244\\
\hline
code\_de\_l'éducation & 11510 & 2000-06-22 & 2021-05-24 & 2 & 6 & 15 & 99 & 285\\
\hline
code\_de\_la\_consommation & 6531 & 1993-07-27 & 2021-04-16 & 4 & 1 & 16 & 63 & 228\\
\hline
code\_de\_la\_propriété\_intellectuelle & 3626 & 1992-07-03 & 2021-05-14 & 2 & 6 & 17 & 27 & 115\\
\hline
code\_de\_la\_recherche & 577 & 2004-06-16 & 2021-01-01 & 1 & 1 & 5 & 21 & 80\\
\hline
code\_de\_la\_santé\_publique & 51958 & 1953-10-07 & 2021-05-27 & 6 & 10 & 88 & 293 & 1142\\
\hline
code\_de\_la\_sécurité\_intérieure & 5253 & 2012-05-01 & 2021-05-27 & 2 & 1 & 9 & 61 & 179\\
\hline
code\_de\_la\_sécurité\_sociale & 40633 & 1961-01-12 & 2021-05-23 & 5 & 1 & 37 & 185 & 646\\
\hline
code\_du\_travail & 48427 & 1973-01-03 & 2021-05-27 & 6 & 9 & 76 & 342 & 1220\\
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



\begin{center}\includegraphics[width=1\linewidth]{05-images_files/figure-latex/tree.edu-1} \end{center}


\begin{center}\includegraphics[width=1\linewidth]{05-images_files/figure-latex/tree.pro-1} \end{center}

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
