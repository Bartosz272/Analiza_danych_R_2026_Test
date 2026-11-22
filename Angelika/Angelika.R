#zadanie 5
library(haven)
adres_cbos <- paste0("https://raw.githubusercontent.com/kflisikowsky/sad/",
                     "main/data/CBOS_201733_331_SPSS.sav")
plik_cbos <- tempfile(fileext = ".sav")
download.file(adres_cbos, plik_cbos, mode = "wb", quiet = TRUE)
cbos_raw <- read_sav(plik_cbos)
unlink(plik_cbos)

cbos <- cbos_raw %>% transmute(
  plec = as_factor(plec),
  miejscowosc = as_factor(klm6),
  kierunek = as_factor(q24),
  prognoza = as_factor(q25),
  wyksztalcenie = as_factor(q15)
)
  summary (cbos_raw)
  library(dplyr)
  
  # Tabela dla zmiennej płeć
  cbos %>%
    filter(!is.na(plec)) %>%
    count(plec) %>%
    mutate(procent = 100 * n / sum(n))
  
  # Tabela dla zmiennej miejscowość
  cbos %>%
    filter(!is.na(miejscowosc)) %>%
    count(miejscowosc) %>%
    mutate(procent = 100 * n / sum(n))