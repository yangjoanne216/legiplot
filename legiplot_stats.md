Legiplot Stats
================

![](legiplot_stats_files/figure-gfm/nb_mots-1.png)<!-- -->

![](legiplot_stats_files/figure-gfm/nb_alineas-1.png)<!-- -->

![](legiplot_stats_files/figure-gfm/nb_articles-1.png)<!-- -->

![](legiplot_stats_files/figure-gfm/alineas_par_article-1.png)<!-- -->

![](legiplot_stats_files/figure-gfm/mots_par_article-1.png)<!-- -->

![](legiplot_stats_files/figure-gfm/mots_par_alinea-1.png)<!-- -->

## Législative vs. Réglementaire

![](legiplot_stats_files/figure-gfm/lr.all-1.png)<!-- -->

![](legiplot_stats_files/figure-gfm/lr.all.stack-1.png)<!-- -->

    ## `summarise()` has grouped output by 'date', 'code'. You can override using the `.groups` argument.

![](legiplot_stats_files/figure-gfm/lr.all.fill-1.png)<!-- -->

## Fouille de stats détaillées

``` r
stats.det <- read.csv("stats_shortlist_ts3.csv") %>%
  filter(code == "code_de_l'éducation") %>%
  mutate(date = as.Date(date)) 

stats.det %>%
  ggplot(aes(x=date,y=nb_mots,fill=livre)) +
  geom_area(aes(group=livre)) +
  facet_grid(.~partie)  +
  theme_hc() + 
  theme(legend.position = "right")
```

![](legiplot_stats_files/figure-gfm/det.1-1.png)<!-- -->

Premier problème : les livres ne sont pas dans l’ordre : Livre IX &lt;
Livre V

Pour traiter ce problème, on force l’ordre des livres avec l’ordre dans
le csv:

``` r
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

![](legiplot_stats_files/figure-gfm/det.2-1.png)<!-- -->

Deuxième problème : des titres changent au cours du temps.

Pour traiter ce problème, on va supprimer ces titres :

``` r
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

![](legiplot_stats_files/figure-gfm/det.3-1.png)<!-- -->

## Fouille du code PI

![](legiplot_stats_files/figure-gfm/pi.livres-1.png)<!-- -->
