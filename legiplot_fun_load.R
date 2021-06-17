
legiplot_load_csv <- function(csvfile) {
  read.csv(csvfile,encoding = "UTF-8", stringsAsFactors = TRUE) %>%
  mutate(
    code = as.factor(str_replace_all(code,"_"," ")),
    partie = factor(case_when(
      code == "code civil" | str_detect(partie,"législative") ~ "Législative",
      TRUE ~ "Réglementaire"),
      levels = c("Législative","Réglementaire")),
    livre.no = sapply(str_split(str_replace(livre,"  "," ")," "),"[",2),
    date = as.Date(date),
    ) %>%
    mutate(livre.num=as.character(as.roman(ifelse(str_detect(livre.no, "^[:digit:]+$"), livre.no, NA))))  %>%
    mutate(livre.no=ifelse(is.na(livre.num), livre.no, livre.num)) %>%
    mutate(livre.no=recode(livre.no, "I" = "Ier")) %>%
    mutate(livre.no=replace_na(livre.no,"hors livre")) %>%
    mutate(livre.no=factor(
      livre.no,
      levels = c("hors livre","préliminaire","Ier",as.character(as.roman(seq(2,20)))) )
      ) %>%
    select(-livre.num)
}

# raw <- legiplot_load_csv("diff_shortlist_t.csv")
# unique(raw$livre.no)
# raw %>% filter(is.na(livre.no)) 

elections = as.Date(as.character(c(1959,1965,1969,1974,1981,1988,1995,2002,2007,2012,2017,2022)),"%Y")

