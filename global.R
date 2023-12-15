# Importe les données 

print("data charged")
data <- read.csv("/Users/celiamarty/Desktop/R shinny/Projet-R-Shiny-/DATA/Crime_Data_from_2020_to_Present.csv", header = TRUE)
print("data load")

titre_appli = " analyse crime 2023"

variables_data = names(data)


#crm.cd.1_NA
#weapon.Used.Cd_NA
#Crm.Cd.2_NA
#Crm.Cd.3_NA
##Crm.Cd.4_NA