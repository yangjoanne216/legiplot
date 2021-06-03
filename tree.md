code de la propiérité intellectuelle
================

``` r
# create a data frame 
data <- read.csv("test.csv",encoding = "UTF-8")%>%filter(code=="code_du_cinéma_et_de_l'image_animée")
```

``` r
# transform it to a edge list!
edges_code_partie <- data %>% select(code,partie) %>% unique %>% rename(from=code, to=partie)

edges_partie_sousPartie <- data %>% select(partie,sous_partie) %>% unique %>% rename(from=partie, to=sous_partie)

edges_sousPartie_livre <- data %>% select(sous_partie, livre) %>% unique %>% rename(from=sous_partie,to=livre)

edges_livre_titre <- data %>% select(livre, titre) %>% unique %>% rename(from=livre,to=titre)

edges_titre_chapitre <- data %>% select(titre,chapitre) %>% unique %>% rename(from=titre,to=chapitre)

edges=rbind(edges_code_partie,edges_partie_sousPartie,edges_sousPartie_livre,edges_livre_titre,edges_titre_chapitre)
```

``` r
vertices = data.frame(
  name = unique(c(as.character(edges$from), as.character(edges$to)))
) 
vertices$group = edges$from[ match( vertices$name, edges$to ) ]
head(vertices)
```

    ##                                      name                               group
    ## 1     code_du_cinéma_et_de_l'image_animée                                <NA>
    ## 2                      Partie législative code_du_cinéma_et_de_l'image_animée
    ## 3                    Partie réglementaire code_du_cinéma_et_de_l'image_animée
    ## 4                                         code_du_cinéma_et_de_l'image_animée
    ## 5                                    <NA>                  Partie législative
    ## 6 Livre Ier : Organisation administrative                                <NA>

``` r
mygraph<- graph_from_data_frame(edges,vertices=vertices) 
```

    ## Warning in graph_from_data_frame(edges, vertices = vertices): In `d' `NA' elements
    ## were replaced with string "NA"

    ## Warning in graph_from_data_frame(edges, vertices = vertices): In `vertices[,1]'
    ## `NA' elements were replaced with string "NA"

``` r
ggraph(mygraph, layout = 'dendrogram', circular =TRUE)+geom_edge_diagonal(colour="grey")+scale_edge_colour_distiller(palette = "RdPu") +geom_node_point(aes(colour=group))+geom_node_text(aes(label=name,colour=group))+theme_void()+theme(legend.position="none",plot.margin=unit(c(0,0,0,0),"cm"))
```

    ## Multiple parents. Unfolding graph

![](tree_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->
