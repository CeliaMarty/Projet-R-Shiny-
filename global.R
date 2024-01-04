# Importe les données

print("data charged")
data <- read.csv("/Users/celiamarty/Desktop/R shinny/Projet-R-Shiny-/DATA/Crime_Data_from_2020_to_Present.csv", header = TRUE)
print("data load")

# Affichage des premières lignes du jeu de données

head(data)

# Affichage du résumé de chaque colonne : permet de voir les colonnes à modifier et ou étudier

summary(data)

#On remarque que ça ne sert à rien d'utiliser les colones suivantes car il y a trop de NA.
#- crm.cd.1_NA
#- weapon.Used.Cd_NA
#- Crm.Cd.2_NA
#- Crm.Cd.3_NA
#- Crm.Cd.4_NA

# Extraire les noms des colonnes du jeu de donnée les stocker dans un vecteur

variables_data = names(data)

#Modification sur la colonne sexe de manière à garder que 3 lettres
data <- data %>%
  filter(Vict.Sex %in% c("F", "M", "X"))

#Modification sur la colonne age de manière à avoir que des nombres supérieurs à O
data <- data %>%
  filter(Vict.Age > 0)

# Convertir la colonne de dates en format de date pour ensuite filtrer les données par années
data$DATE.OCC <- as.Date(data$DATE.OCC, format = "%m/%d/%Y")

#Filtrer les données pour l'année 2020 et les stocker dans une variable
data_2020 <- data %>%
  filter(year(DATE.OCC) == 2020)

#Filtrer les données pour l'année 2021 et les stocker dans une variable
data_2021 <- data %>%
  filter(year(DATE.OCC) == 2021)

# Filtrer les données pour l'année 2022 et les stocker dans une variable
data_2022 <- data %>%
  filter(year(DATE.OCC) == 2022)

# Filtrer les données pour l'année 2023 et les stocker dans une variable
data_2023 <- data %>%
  filter(year(DATE.OCC) == 2023)

# Affichage des données 
cat("Nombre de délits en 2020:", nrow(data_2020),"/n")
cat("Nombre de délits en 2021:", nrow(data_2021), "\n")
cat("Nombre de délits en 2022:", nrow(data_2022), "\n")
cat("Nombre de délits en 2023:", nrow(data_2023), "\n")


# Graphique en barre pour afficher le nombre de délits par années
crimeBarPlot <- ggplot(data, aes(x = factor(year(DATE.OCC)),fill = factor(year(DATE.OCC)))) +
  geom_bar() +
  labs(title = "Nombre de délits par année",
       x = "Année",
       y = "Nombre de délits")+
  scale_fill_discrete(name = "Année")
print(crimeBarPlot)

# Histogramme pour afficher la répartition ds délits selon l'âge des victimes
Victim_age <- ggplot(data, aes(x = Vict.Age)) +
  geom_histogram(binwidth = 10, fill = "blue", color = "black", alpha = 0.5) +
  labs(title = "Distribution du nombre de délits selon l'âge des victimes",
       x = "Âge",
       y = "Fréquence") +
  theme_minimal()
print(Victim_age)

# Calcul de la moyenne de délits par mois en 2023
average_crimes_per_month_2023 <- data_2023 %>%
  mutate(Month = month(as.Date(DATE.OCC, format = "%m/%d/%Y"), label = TRUE)) %>%
  group_by(Month) %>%
  summarise(TotalCrimes = n()) %>%
  summarise(AverageCrimes = round(mean(TotalCrimes)))
print(average_crimes_per_month_2023)

# Calcul de la moyenne de délits par jour en 2023
average_crimes_per_day_2023 <- data_2023 %>%
  mutate(Day = day(as.Date(DATE.OCC, format = "%m/%d/%Y"))) %>%
  group_by(Day) %>%
  summarise(TotalCrimes = n()) %>%
  summarise(AverageCrimes = round(mean(TotalCrimes)))
print(average_crimes_per_day_2023) 