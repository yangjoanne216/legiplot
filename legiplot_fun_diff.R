
library(tidyverse)
library(ggthemes)

legiplot_load_diff <- function() {
  
  lp_modifs <<- read.csv("diff_shortlist_t.csv",encoding = "UTF-8", stringsAsFactors = TRUE) %>%
    mutate(code = factor(code, labels=str_replace_all(levels(code),'_',' '))) %>%
    mutate(date = as.Date(date))
  
  lp_modifs_articles <<- lp_modifs %>%
    filter(type == "Modification") %>%
    group_by(code,partie,sous_partie,livre,titre,chapitre,article) %>%
    summarise(nb_modifications=n())
  
  lp_modifs_articles_sum <<- lp_modifs_articles %>%
    mutate(nb_modifications = factor(
      ifelse(nb_modifications<9,as.character(nb_modifications),"9+")
    )) %>%
    group_by(code,nb_modifications) %>%
    summarise(nb_articles = n())
    

  lp_modifs_codes <<- lp_modifs %>%
    arrange(date) %>%
    mutate(type = fct_recode(type, Ajout = "Préexistence")) %>%
    group_by(code,partie,sous_partie,livre,titre,chapitre,article,type) %>%
    summarise(date=first(date)) %>%
    group_by(code,date,type) %>%
    summarise(nb = n()) %>%
    ungroup() %>%
    complete(nesting(code,date),type, fill = list(nb=0)) %>%
    group_by(code,type) %>%
    mutate(nb = cumsum(nb)) %>%
    ungroup() %>%
    pivot_wider(names_from = type, values_from = nb) %>%
    mutate(Ajout = Ajout - Suppression - Modification) %>%
    pivot_longer(c(Ajout,Suppression,Modification), names_to = "type", values_to = "nb_articles") %>%
    mutate(type = factor(type,levels = c("Suppression","Modification","Ajout"), labels=c("Supprimés","Modififés","Conservés")))
}


legiplot_modifs_articles_plot <- function(uncode=FALSE) {
  lp_modifs_articles_sum %>%
    { if(uncode != FALSE) filter(.,code == uncode) else . } %>%
    ggplot(aes(x=nb_modifications,y=nb_articles,fill=nb_modifications)) +
    geom_col(color="white") +
    { if(uncode == FALSE) 
      facet_wrap(code~., labeller = label_wrap_gen(width=25), scales = "free_y") } +
    xlab("Nombre de modifications") +
    ylab("Nombre d'articles") +
    scale_fill_brewer(palette = "Reds") +
    guides(fill=FALSE) +
    theme_hc() + theme(legend.position = "top")
}


legiplot_modifs_codes_plot <- function(pos="stack",uncode=FALSE,start="2000-01-01") {
  lp_modifs_codes %>%
    filter(date >= as.Date(start)) %>%
    { if(uncode != FALSE) filter(.,code == uncode) else . } %>%
    ggplot(aes(x=date,y=nb_articles,color=type,fill=type)) +
    geom_area(aes(group=type),position=pos) +
    expand_limits(x=as.Date("2000-01-01")) +
    { if(uncode == FALSE) 
      facet_wrap(code~., labeller = label_wrap_gen(width=25), scales = "free_x") } +
    { if(pos == "fill") 
      scale_y_continuous(labels = scales::percent)  } +
    ylab("Nombre d'articles") +
    theme_hc() + theme(legend.position = "top")
}


# legiplot_load_diff()
# 
# legiplot_modifs_articles_plot()
# 
# legiplot_modifs_articles_plot("code de l'éducation")
# 
# legiplot_modifs_codes_plot()
# 
# legiplot_modifs_codes_plot(pos="fill")
