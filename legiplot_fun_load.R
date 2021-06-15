
legiplot_load_csv <- function(csvfile) {
  read.csv(csvfile,encoding = "UTF-8", stringsAsFactors = TRUE) %>%
  mutate(
    code = as.factor(str_replace_all(code,"_"," ")),
    partie = factor(case_when(
      str_detect(partie,"législative") ~ "Législative",
      str_detect(partie,"réglementaire") ~ "Réglementaire",
      TRUE ~ "Autre"),
      levels = c("Législative","Réglementaire","Autre")), 
    livre = as.factor(gsub("LIVRE","Livre",livre,ignore.case = TRUE)),
    date = as.Date(date),
    )
}

elections = as.Date(as.character(c(1959,1965,1969,1974,1981,1988,1995,2002,2007,2012,2017,2022)),"%Y")
