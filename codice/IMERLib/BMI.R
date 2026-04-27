

#================ SCRIPT - LOGISTIC REGRESSION per identificare coppie non plausibili ================



#================ COMMENTO METODOLOGICO E RISULTATI ================

# Obiettivo:
# Identificare coppie Altezza-Peso potenzialmente errate o non plausibili.
# Metodo supervisionato: valori oltre il 1°-99° percentile = non plausibili (Y=1),
# valori nel range plausibili (Y=0). 
# Questi dati sono usati per addestrare una regressione logistica.
#
# La variabile target è binaria: 1 = outlier, 0 = plausibile.
# Variabili esplicative: altezza_m, peso_m, eta_classe, interazione altezza*peso.
# Modello logistica con polinomi di 2° grado.
#
# Risultati:
# - AUC sul test set ~0.995 → ottima discriminazione.
# - I rimossi dal modello mostrano BMI >50 o <15.
# - Logistica mantiene casi plausibili che il cutoff 99% eliminerebbe.

#================ FINE COMMENTO METODOLOGICO ================



rm(list = ls())


#================ LIBRERIE ================

library(dplyr)
library(ggplot2)
library(readr)
library(caret)
library(pROC)

set.seed(123)


#================ INPUT ================

path_base <- "/home/imer/works/BMI_check/"
Cedap2020 <- read_csv2(file.path(path_base, "Cedap2020.csv"))
coorte <- read_csv2(file.path(path_base, "coorte_cedap.csv"))
Elenco_codici_e_denominazioni_al_31_12_2021 <- read_csv2("/home/imer/works/BMI_check/Elenco-codici-e-denominazioni-al-31_12_2021.csv")


#================ PREPARAZIONE DATI COORTE ================

coorte <- coorte %>%
  mutate(
    altezza_m = as.numeric(altezza_m),
    peso_m    = as.numeric(peso_m),
    BMI       = peso_m / ((altezza_m/100)^2),
    eta_classe = case_when(
      eta_m < 14 ~ "NA",
      eta_m < 18 ~ "14-17",
      eta_m <= 24 ~ "18-24",
      eta_m <= 29 ~ "25-29",
      eta_m <= 34 ~ "30-34",
      eta_m <= 44 ~ "35-44",
      TRUE ~ "NA"
    )
  )


#================ ETICHETTA NON_PLAUSIBILE (percentili 1° e 99°) ================

lim_h <- quantile(coorte$altezza_m, probs = c(0.01, 0.99), na.rm = TRUE)
lim_w <- quantile(coorte$peso_m, probs = c(0.01, 0.99), na.rm = TRUE)

coorte <- coorte %>%
  mutate(
    non_plausibile = ifelse(
      altezza_m < lim_h[1] | altezza_m > lim_h[2] |
        peso_m < lim_w[1] | peso_m > lim_w[2], 1, 0
    ),
    non_plausibile = factor(non_plausibile)
  )

cat("\nDistribuzione Y (non_plausibile):\n")
print(table(coorte$non_plausibile))


#================ CHI-QUADRO PER ETA' E NAZIONALITA' ================

rimossi <- coorte %>% filter(non_plausibile == 1)
tab_eta_full <- table(coorte$eta_classe, coorte$non_plausibile)
chi_eta <- chisq.test(tab_eta_full)
cat("\nChi-quadro per classi età:\n")
print(chi_eta)

if("cittad_m_classi" %in% colnames(coorte)){
  tab_naz_full <- table(coorte$cittad_m_classi, coorte$non_plausibile)
  chi_naz <- chisq.test(tab_naz_full)
  cat("\nChi-quadro per nazionalità:\n")
  print(chi_naz)
}


#================ TRAIN / TEST SPLIT ================

train_idx <- createDataPartition(coorte$non_plausibile, p = 0.67, list = FALSE)
train_df <- coorte[train_idx, ]
test_df  <- coorte[-train_idx, ]

cat("\nDimensioni train/test:\nTrain:", nrow(train_df), "| Test:", nrow(test_df), "\n")


#================ REGRESSIONE LOGISTICA ================

model_log <- glm(
  non_plausibile ~ poly(altezza_m, 2) + poly(peso_m, 2) +
    eta_classe + cittad_m_classi + altezza_m:peso_m,
  data = train_df,
  family = binomial
)
summary(model_log)


#================ VALUTAZIONE SUL TEST ================

test_df <- test_df %>%
  mutate(
    prob_pred = predict(model_log, newdata = test_df, type = "response"),
    pred_flag = ifelse(prob_pred >= 0.5, 1, 0)
  )

roc_obj <- roc(as.numeric(as.character(test_df$non_plausibile)), test_df$prob_pred)
auc_val <- auc(roc_obj)
cat("\nAUC sul test set:", round(auc_val,3), "\n")

conf_mat <- table(Predetto = test_df$pred_flag, Reale = test_df$non_plausibile)
cat("\nMatrice di confusione:\n")
print(conf_mat)


#================ SUBSET NON PLAUSIBILI DAL MODELLO ================

subset_non_plausibili <- test_df %>%
  filter(pred_flag == 1) %>%
  select(altezza_m, peso_m, BMI, eta_classe,
         non_plausibile, pred_flag, prob_pred) %>%
  arrange(desc(prob_pred))

cat("\nPrime righe dei casi NON PLAUSIBILI previsti dal modello:\n")
print(head(subset_non_plausibili, 50))


#================ GRAFICO ================

plot(roc_obj, main = paste("ROC Curve - AUC =", round(auc_val, 3)))

ggplot(test_df, aes(x = altezza_m, y = peso_m)) +
  geom_point(alpha = 0.2, size = 0.8, color = "grey70") +
  geom_smooth(method = "loess", se = FALSE, color = "blue", size = 1.2) +
  labs(title = "Relazione Altezza-Peso nel test set",
       subtitle = "Linea blu = andamento medio stimato (LOESS)",
       x = "Altezza (cm)",
       y = "Peso (kg)") +
  theme_minimal()


#================ JOIN CON CODICI ISTAT E PREDIZIONE CEDAP2020 ================

Elenco_codici <- read_csv2(file.path(path_base, "Elenco-codici-e-denominazioni-al-31_12_2021.csv")) %>%
  mutate(codice_istat = as.character(`Codice ISTAT`))

if(!("codice_istat" %in% colnames(Elenco_codici))) {
  Elenco_codici <- Elenco_codici %>% rename(codice_istat = `Codice ISTAT`)
}
if(!("continent" %in% colnames(Elenco_codici))) {
  Elenco_codici <- Elenco_codici %>% rename(continent = `Denominazione Continente (IT)`)
}

Cedap2020_test <- Cedap2020 %>%
  mutate(
    CITTAD_M = as.character(CITTAD_M),
    altezza_m = as.numeric(ALTEZZA_M),
    peso_m = as.numeric(PESO_M),
    BMI = PESO_M / ((ALTEZZA_M/100)^2),
    eta_classe = case_when(
      ETA_M < 14 ~ "NA",
      ETA_M < 18 ~ "14-17",
      ETA_M <= 24 ~ "18-24",
      ETA_M <= 29 ~ "25-29",
      ETA_M <= 34 ~ "30-34",
      ETA_M <= 44 ~ "35-44",
      TRUE ~ "NA"
    )
  ) %>%
  filter(!is.na(altezza_m) & !is.na(peso_m)) %>%
  left_join(Elenco_codici %>% select(codice_istat, continent),
            by = c("CITTAD_M" = "codice_istat")) %>%
  mutate(cittad_m_classi = ifelse(CITTAD_M == "100", "Italia", continent),
         cittad_m_classi = factor(cittad_m_classi, levels = unique(coorte$cittad_m_classi))) %>%
  mutate(prob_pred = predict(model_log, newdata = ., type = "response"),
         pred_flag = ifelse(prob_pred >= 0.5, 1, 0),
         non_plausibile_99 = ifelse(altezza_m < lim_h[1] | altezza_m > lim_h[2] |
                                      peso_m < lim_w[1] | peso_m > lim_w[2], 1, 0))


#================ DIFFERENZE PERCENTILI vs LOGISTICA ================

solo_percentile <- Cedap2020_test %>%
  filter(non_plausibile_99 == 1 & pred_flag == 0)

solo_logistica <- Cedap2020_test %>%
  filter(non_plausibile_99 == 0 & pred_flag == 1)

intersezione <- Cedap2020_test %>%
  filter(non_plausibile_99 == 1 & pred_flag == 1)

cat("\nNumero rimossi solo dai percentile:", nrow(solo_percentile), "\n")
cat("Numero rimossi solo dalla logistica:", nrow(solo_logistica), "\n")
cat("Numero rimossi da entrambi:", nrow(intersezione), "\n")

# Salvataggi CSV
write_csv2(solo_percentile, file.path(path_base, "rimossi_solo_percentile.csv"))
write_csv2(solo_logistica, file.path(path_base, "rimossi_solo_logistica.csv"))
write_csv2(intersezione, file.path(path_base, "rimossi_entrambi.csv"))







#================ REGOLA RANGE PESO/ALTEZZA — ANALISI RIMOSSI ================




# Funzione: plausibilità basata su range di peso realistici per altezza

check_plausibilita_range <- function(df) {
  
  df %>%
    mutate(
      peso_min = case_when(
        altezza_m >= 145 & altezza_m <= 149 ~ 40,
        altezza_m >= 150 & altezza_m <= 154 ~ 42,
        altezza_m >= 155 & altezza_m <= 159 ~ 45,
        altezza_m >= 160 & altezza_m <= 164 ~ 48,
        altezza_m >= 165 & altezza_m <= 169 ~ 50,
        altezza_m >= 170 & altezza_m <= 174 ~ 53,
        altezza_m >= 175 & altezza_m <= 179 ~ 55,
        altezza_m >= 180 & altezza_m <= 184 ~ 60,
        altezza_m >= 185 & altezza_m <= 189 ~ 65,
        altezza_m >= 190 ~ 70,
        TRUE ~ 42  # default minimo plausibile
      ),
      peso_max = case_when(
        altezza_m >= 145 & altezza_m <= 149 ~ 90,
        altezza_m >= 150 & altezza_m <= 154 ~ 95,
        altezza_m >= 155 & altezza_m <= 159 ~ 100,
        altezza_m >= 160 & altezza_m <= 164 ~ 105,
        altezza_m >= 165 & altezza_m <= 169 ~ 110,
        altezza_m >= 170 & altezza_m <= 174 ~ 115,
        altezza_m >= 175 & altezza_m <= 179 ~ 120,
        altezza_m >= 180 & altezza_m <= 184 ~ 130,
        altezza_m >= 185 & altezza_m <= 189 ~ 140,
        altezza_m >= 190 ~ 150,
        TRUE ~ 100  # default massimo plausibile
      ),
      ELIMINARE = ifelse(peso_m < peso_min | peso_m > peso_max, 1, 0),
      TENERE = ifelse(ELIMINARE == 0, 1, 0)
    ) %>%
    select(altezza_m, peso_m, cittad_m_classi, BMI, TENERE, ELIMINARE)
}


#================ 1. Rimossi solo percentili ================

rimossi_solo_percentile <- Cedap2020_test %>%
  filter(non_plausibile_99 == 1 & pred_flag == 0) %>%
  check_plausibilita_range()


#================ 2. Rimossi solo logistica ================

rimossi_solo_logistica <- Cedap2020_test %>%
  filter(non_plausibile_99 == 0 & pred_flag == 1) %>%
  check_plausibilita_range()


#================ 3. Rimossi da entrambi================

rimossi_entrambi <- Cedap2020_test %>%
  filter(non_plausibile_99 == 1 & pred_flag == 1) %>%
  check_plausibilita_range()


#================ 4. Salvataggio subset ================

write_csv2(rimossi_solo_percentile,
           file.path(path_base, "RIMOSSI_SOLO_PERCENTILE_subset_RANGE.csv"))
write_csv2(rimossi_solo_logistica,
           file.path(path_base, "RIMOSSI_SOLO_LOGISTICA_subset_RANGE.csv"))
write_csv2(rimossi_entrambi,
           file.path(path_base, "RIMOSSI_ENTRAMBI_subset_RANGE.csv"))


#================ 5. Summary finale ================

tabella_rimossi <- data.frame(
  Metodo = c("Solo percentili", "Solo logistica", "Entrambi"),
  Totale = c(nrow(rimossi_solo_percentile),
             nrow(rimossi_solo_logistica),
             nrow(rimossi_entrambi)),
  Tenere = c(sum(rimossi_solo_percentile$TENERE),
             sum(rimossi_solo_logistica$TENERE),
             sum(rimossi_entrambi$TENERE)),
  Eliminare = c(sum(rimossi_solo_percentile$ELIMINARE),
                sum(rimossi_solo_logistica$ELIMINARE),
                sum(rimossi_entrambi$ELIMINARE))
) %>%
  mutate(
    Perc_Tenere = round(100 * Tenere / Totale, 1),
    Perc_Eliminare = round(100 * Eliminare / Totale, 1)
  )

print(tabella_rimossi)

#================ 6. ELIMINATI DAI PERCENTILI MA NON DALLA LOGISTICA ================


percentili_elim_log_mant <- rimossi_solo_percentile %>%
  filter(TENERE == 1)  # TENERE = logistica avrebbe tenuto

cat("\nPercentili eliminano ma logistica mantiene:\n")
cat("Totale casi:", nrow(percentili_elim_log_mant), "\n")

write_csv2(percentili_elim_log_mant,
           file.path(path_base, "Percentili_elim_log_mant.csv"))

log_elim_percent_mant <- rimossi_solo_logistica %>%
  filter(TENERE == 1)  # TENERE = percentili avrebbero tenuto

cat("\nLogistica elimina ma percentili mantengono:\n")
cat("Totale casi:", nrow(log_elim_percent_mant), "\n")

write_csv2(log_elim_percent_mant,
           file.path(path_base, "Log_elim_percent_mant.csv"))

# ================ Sintesi finale dei due confronti ================

tabella_confronto <- data.frame(
  Metodo = c(
    "Percentili eliminano, logistica mantiene",
    "Logistica elimina, percentili mantengono"
  ),
  Totale = c(nrow(percentili_elim_log_mant),
             nrow(log_elim_percent_mant))
)

print(tabella_confronto)

#================ 7. Test metodo migliore ================

metodo_migliore <- tabella_rimossi$Metodo[which.max(tabella_rimossi$Perc_Tenere)]
perc_migliore <- max(tabella_rimossi$Perc_Tenere)

cat("\nMETODO CON MAGGIORE CAPACITÀ DI MANTENERE CASI PLAUSIBILI SECONDO I RANGE PESO/ALTEZZA:\n")
cat(metodo_migliore, "con", perc_migliore, "% di plausibili.\n")

# ================ Reinserimento dei casi plausibili rimossi solo dalla logistica ================

# Estraiamo i casi da reintegrare
reintegra_logistica <- rimossi_solo_logistica %>%
  filter(TENERE == 1)

# Creiamo il dataset originale senza i casi rimossi dalla logistica
Cedap2020_test_senza_logistica <- Cedap2020_test %>%
  filter(!(non_plausibile_99 == 0 & pred_flag == 1))

# Reinseriamo i casi plausibili nella posizione originale
# Assumiamo che l'ordine dei record sia lo stesso dell'originale
Cedap2020_test_reintegrato <- bind_rows(
  Cedap2020_test_senza_logistica,
  reintegra_logistica %>% select(altezza_m, peso_m, cittad_m_classi, BMI)
) %>%
  arrange(row_number())  # opzionale, per ripristinare ordine originale

cat("Totale casi dopo reintegrazione della logistica:", nrow(Cedap2020_test_reintegrato), "\n")


