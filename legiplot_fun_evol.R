library(tidyverse)
library(ggthemes)
library(cowplot)

legiplot_load_evol <- function(start="2000-01-01") {
  lp_stats <<- read.csv("stats_shortlist_ts6.csv") %>%
    mutate(
      code = as.factor(code),
      date = as.Date(date),
      alineas_par_article = nb_alineas / nb_articles,
      mots_par_article = nb_mots / nb_articles,
      mots_par_alinea = nb_mots / nb_alineas
    ) %>%
    filter(date >= as.Date(start))
}


legiplot_evol_lines <- function(col,collab,norm=FALSE) {
  lp_stats %>%
    mutate(indicateur = !!sym(col)) %>%
    arrange(date) %>%
    group_by(code) %>%
    { if(norm) mutate(., indicateur = indicateur / first(indicateur) * 100) else . } %>%
    ungroup() %>%
    mutate(code = fct_reorder(code,-indicateur,.fun=first)) %>%
    ggplot(aes(x=date,y=indicateur,color=code)) +
    geom_line(aes(group=code)) +
    ylab(collab) +
    theme_hc() + theme(legend.position = "right")
}

legiplot_load_evol()

norm <- FALSE
plot_grid(
  legiplot_evol_lines("nb_mots","Nombre de mots par code",norm),
  legiplot_evol_lines("nb_alineas","Nombre d'alinéas par code",norm),
  legiplot_evol_lines("nb_articles","Nombre d'articles par code",norm),
  legiplot_evol_lines("alineas_par_article","Nombre d'alinéas par article",norm),
  legiplot_evol_lines("mots_par_article","Nombre de mots par article",norm),
  legiplot_evol_lines("mots_par_alinea","Nombre de mots par alinéas",norm)
)


norm <- TRUE
plot_grid(
  legiplot_evol_lines("nb_mots","Nombre de mots par code",norm),
  legiplot_evol_lines("nb_alineas","Nombre d'alinéas par code",norm),
  legiplot_evol_lines("nb_articles","Nombre d'articles par code",norm),
  legiplot_evol_lines("alineas_par_article","Nombre d'alinéas par article",norm),
  legiplot_evol_lines("mots_par_article","Nombre de mots par article",norm),
  legiplot_evol_lines("mots_par_alinea","Nombre de mots par alinéas",norm)
)
