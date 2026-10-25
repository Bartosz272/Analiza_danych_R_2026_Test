### Zadanie 4 — wiek, odległość i sklepy

library(dplyr)
library(tidyr)

# Wczytanie danych
adres_nieruchomosci <- paste0(
  "https://raw.githubusercontent.com/kflisikowsky/pandas_exercises/",
  "62863036107888c0c7273c40e8d309a43f4da3a9/data/models/real_estate.csv"
)
raw_nier <- read.csv(adres_nieruchomosci, check.names = FALSE)
stopifnot(nrow(raw_nier) == 414, ncol(raw_nier) == 7)

nier <- raw_nier
names(nier) <- c("id", "wiek_lat", "metro_m", "sklepy", "lat", "lon",
                 "cena_10k_twd_ping")

# Zadanie 4: Podział na strefy odległości od metra
nier <- nier %>%
  mutate(
    strefa = cut(metro_m,
                 breaks = c(-Inf, 500, 1500, Inf),
                 labels = c("do 500 m", "500–1500 m", "ponad 1500 m"))
  )

# 1. Zestawienie dla wszystkich budynków
tabela_wszystkie <- nier %>%
  group_by(strefa) %>%
  summarise(
    liczba = n(),
    mediana_ceny = median(cena_10k_twd_ping, na.rm = TRUE),
    mediana_wieku = median(wiek_lat, na.rm = TRUE),
    srednia_sklepow = mean(sklepy, na.rm = TRUE)
  )

print(tabela_wszystkie)

# 2. Zestawienie dla budynków w wieku najwyżej 20 lat
tabela_mlode <- nier %>%
  filter(wiek_lat <= 20) %>%
  group_by(strefa) %>%
  summarise(
    liczba = n(),
    mediana_ceny = median(cena_10k_twd_ping, na.rm = TRUE),
    mediana_wieku = median(wiek_lat, na.rm = TRUE),
    srednia_sklepow = mean(sklepy, na.rm = TRUE)
  )

print(tabela_mlode)

