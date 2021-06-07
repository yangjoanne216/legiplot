
library(tidyverse)
library(ggraph)
library(igraph)

# Fonctions de chargement
legiplot_load <- function(csvfile) {
  read.csv(csvfile,encoding = "UTF-8", stringsAsFactors = TRUE) %>%
    mutate(code = factor(code, labels=str_replace_all(levels(code),'_',' ')))
}

legiplot_loadall_short <- function() {
  lp_stats_lts1 <<- legiplot_load("stats_shortlist_lts1.csv")
}

# Arbres
legiplot_tree <- function(lecode) {
  
  data <- lp_stats_lts1 %>%
    filter(code==lecode) %>%
    filter(partie != "Partie réglementaire") %>%
    mutate(across(where(is.factor), as.character)) %>%
    mutate(sous_partie = ifelse(sous_partie=="", partie,sous_partie)) 
    
  edges <- bind_rows(
    data %>% group_by(from=code, to=sous_partie) %>% summarise(niveau = 5, groupe="code"),
    data %>% group_by(from=sous_partie, to=livre) %>% summarise(niveau = 4, groupe=unique(sous_partie)),
    data %>% group_by(from=livre, to=paste(livre,titre)) %>% summarise(niveau = 3, groupe=unique(sous_partie))
  )
  
  vertices <- bind_rows(
    data %>% group_by(name = code) %>% summarise(label = unique(code), groupe = "code", niveau = 10, nb_articles = sum(nb_articles)),
    #data %>% group_by(name = partie) %>% summarise(label = partie, groupe = partie, niveau = 5, nb_articles = sum(nb_articles)),
    data %>% group_by(name = sous_partie) %>% summarise(label = unique(sous_partie), groupe = unique(sous_partie), niveau = 4, nb_articles = sum(nb_articles)),
    data %>% group_by(name = livre) %>% summarise(label = unique(livre), groupe = unique(sous_partie), niveau = 3, nb_articles = sum(nb_articles)),
    data %>% group_by(name = paste(livre,titre)) %>% summarise(label = unique(titre), groupe = unique(sous_partie), niveau = 2, nb_articles = sum(nb_articles))
  )
  
  #vertices %>% group_by(name) %>% summarise(n = n()) %>% arrange(desc(n))
  
  labeller = label_wrap_gen(width = 15)
  
  mygraph<- graph_from_data_frame(edges,vertices=vertices) 
  ggraph(mygraph, layout = 'dendrogram', circular =TRUE)+
    geom_edge_diagonal(aes(colour=groupe))+
    #scale_edge_colour_distiller(palette = "RdPu")+
    geom_node_point(aes(size=nb_articles,colour=groupe))+
    geom_node_text(aes(label=labeller(label)),colour="white",size=vertices$niveau)+
    scale_size_continuous(range=c(10,80)) +
    theme_void()+
    theme(legend.position="none",plot.margin=unit(c(0,0,0,0),"cm"))
}

legiplot_loadall_short()
legiplot_tree("code de l'éducation")

