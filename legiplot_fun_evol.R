library(tidyverse)
library(ggthemes)
library(cowplot)

legiplot_load_evol <- function(start="2000-01-01") {
  
  lp_stats <- read.csv("stats_shortlist_ts5.csv") %>%
    mutate(
      code = as.factor(str_replace_all(code,"_"," ")),
      partie = factor(case_when(
        str_detect(partie,"législative") ~ "Législative",
        str_detect(partie,"réglementaire") ~ "Réglementaire",
        TRUE ~ "Autre"),
        levels = c("Législative","Réglementaire","Autre")), 
      date = as.Date(date)) %>%
    filter(date >= as.Date(start))
  
  lp_stats_ind <<- lp_stats %>%
    group_by(code,date) %>%
    summarise(across(nb_articles:nb_mots,sum)) %>%
    mutate(
      alineas_par_article = nb_alineas / nb_articles,
      mots_par_article = nb_mots / nb_articles,
      mots_par_alinea = nb_mots / nb_alineas
    ) 
  
  lp_stats_vol <<- lp_stats %>%
    group_by(code,date,partie) %>%
    summarise(nb_articles = sum(nb_articles))
}

legiplot_load_evol()


# Etude des indicateurs

legiplot_ind_plot <- function(col,collab,norm=FALSE) {
  lp_stats_ind %>%
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



norm <- FALSE
plot_grid(
  legiplot_ind_plot("nb_mots","Nombre de mots par code",norm),
  legiplot_ind_plot("nb_alineas","Nombre d'alinéas par code",norm),
  legiplot_ind_plot("nb_articles","Nombre d'articles par code",norm),
  legiplot_ind_plot("alineas_par_article","Nombre d'alinéas par article",norm),
  legiplot_ind_plot("mots_par_article","Nombre de mots par article",norm),
  legiplot_ind_plot("mots_par_alinea","Nombre de mots par alinéas",norm)
)


norm <- TRUE
plot_grid(
  legiplot_ind_plot("nb_mots","Nombre de mots par code",norm),
  legiplot_ind_plot("nb_alineas","Nombre d'alinéas par code",norm),
  legiplot_ind_plot("nb_articles","Nombre d'articles par code",norm),
  legiplot_ind_plot("alineas_par_article","Nombre d'alinéas par article",norm),
  legiplot_ind_plot("mots_par_article","Nombre de mots par article",norm),
  legiplot_ind_plot("mots_par_alinea","Nombre de mots par alinéas",norm)
)

# Etude des volumes

legiplot_vol_plot <- function(pos="stack",uncode=FALSE) {
  lp_stats_vol %>%
  { if(uncode != FALSE) filter(.,code == uncode) else . } %>%
  mutate(code = fct_reorder(code,-nb_articles,.fun=first)) %>%
  ggplot(aes(x=date,y=nb_articles,color=partie,fill=partie)) +
    geom_area(aes(group=partie),position=pos) +
    expand_limits(x=as.Date("2000-01-01")) +
    { if(uncode == FALSE) 
      facet_wrap(code~., labeller = label_wrap_gen(width=20), scales = "free_x") } +
    { if(pos == "fill") 
      scale_y_continuous(labels = scales::percent)  } +
    ylab("Nombre d'articles") +
    theme_hc() + theme(legend.position = "top")
}

legiplot_vol_plot()

legiplot_vol_plot("fill")

legiplot_vol_plot(pos="fill",uncode="code de l'éducation")
