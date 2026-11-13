### Zadanie 8 — ocena teraźniejszości a oczekiwania

#Zrób tabelę liczności odpowiedzi na `prognoza`. Następnie ogranicz dane do osób oceniających sytuację w kraju jako `"W złym"` i sprawdź, jak odpowiadały na pytanie o przyszłość. Która odpowiedź była najczęstsza w tej grupie? Czy na podstawie tej tabeli można wyciągać wnioski przyczynowe?

# WASZE ROZWIĄZANIE
# filter(kierunek == "W złym"), count(prognoza, sort = TRUE)

##**Uwaga do interpretacji.** Dane pochodzą z roku 2017. Obliczenia na surowych rekordach są ćwiczeniem analitycznym. Nie przedstawiajcie ich jako współczesnych opinii Polaków ani jako reprezentatywnych oszacowań bez sprawdzenia dokumentacji i ewentualnego ważenia próby.

#Źródło: [plik CBOS w formacie SPSS](https://github.com/kflisikowsky/sad/blob/main/data/CBOS_201733_331_SPSS.sav) i [dokumentacja badania](https://github.com/kflisikowsky/sad/blob/main/data/CBOS_201733_331_DOK.pdf) w repozytorium prowadzącego. W pliku znajduje się **925 respondentów i 189 zmiennych**. Do dzisiejszych ćwiczeń wykorzystamy tylko kilka pytań.


###Code start

library(dplyr)
library(tidyr)

library(haven)
library(cowsay)
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
dim(cbos)
head(cbos)

cbos
wszystkie_odp <- count(cbos)
kier_zly <- count(filter(cbos,kierunek == "W złym"))

v <- cbos %>%
filter(kierunek == "W złym") %>%
count(prognoza, sort = TRUE) %>%
slice_max(n, n = 1)

odp <- as.character(v$prognoza[1])
c_odp <- as.numeric(v$n[1])

as.character(odp)

prc_zle = (kier_zly/wszystkie_odp)*100
proc_reszta = (c_odp/kier_zly)*100


tekst <- paste0(round(prc_zle,0),"% Polaków uwarza że kierunek w którym idzie nasz kraj jest zły, a najwięcej bo ",round(proc_reszta,0),"% uważa że w przyszłości ",odp)
say(tekst)