#Inclusions des scripts R :
source = "global.R"
source = "Packages.R"

#Interface utilisateur    
ui <- navbarPage(
  title = "CRIMEPULSE L.A", # Titre de la page
  tabsetPanel(
    # Onglet Accueil
    tabPanel("Accueil",
             fluidPage(
               # Colonne 1
               column (4,
                       br(),
                       br(),
                       br(),
                       tags$img(src = "cp-LA.png", width = 120, height = 120), #Image
                       br(),
                       br(),
                       br(),
                       br(),
                       p("Bienvenue sur l'application CRIMEPULSE L.A !"), # Texte
                       br(),
                       p("Votre source d'information interactive sur la criminalité à Los Angeles."),
                       p("Explorez les tendances de la criminalité et les statistiques annuelles pour mieux comprendre la sécurité dans cette ville. Notre plateforme vous offre une expérience immersive avec des cartes et des visualisations de données intéractives. Que vous soyez un résident local, un professionnel de la sécurité publique ou un passionné de données, CrimePulse L.A vous fournit les outils nécessaires pour explorer et comprendre les réalités de la criminalité à Los Angeles."),
               ),
               # Colonne2
               column (4,
                       h3("Quelques chiffres"), #Titre colonne
                       br(),
                       br(),
                       valueBoxOutput("maBox2"), #Boites de valeur 
                       valueBoxOutput("maBox3"),
                       valueBoxOutput("maBox4")
               ),
               # Colonne 3
               column (4,
                       h3("Nombre de délits par an"), # Titre colonne
                       br(),
                       br(),
                       plotOutput("crimeBarPlot") # Plot du nombre de délits par an
               )
             )
    ),
    # Onglet Victimes
    tabPanel("Victimes",
             fluidPage(
               # Colonne 1
               column(6,
                      br(),
                      br(),
                      selectInput("Choix","Sélectionnez une année pour afficher la répartition des victimes selon leur sexe pour l'année choisie",
                                  c("2020","2021","2022","2023")), # Menu déroulant
                      br(),
                      br(),
                      br(),
                      br(),
                      plotOutput("crimeBarPlotSexe") #Plot de la répartion du nombre de délits en fonction du sexe de la victime et de l'année
               ),
               # Colonne 2
               column(6,
                      br(),
                      br(),
                      selectInput("Choix2","Sélectionnez une année pour afficher la répartition des victimes selon leur âge pour l'année choisie",
                                  c("2020","2021","2022","2023")), # Menu déroulant
                      br(),
                      br(),
                      br(),
                      br(),
                      plotOutput("Victim_age") #Plot de la répartion du nombre de délits en fonction de l'âge de la victime et de l'année
               )
               
             )
    ),
    # Onglet Localisation
    tabPanel("Localisation",
             # Colonne 1
             fluidPage(
               column(6,
                      br(),
                      br(),
                      radioButtons("radio_input", "Sélectionnez une zone pour visualiser la répartition des délits selon les quartiers en 2023. Vous pouvez également cliquer sur un délit pour savoir son type",
                                   choices = c("Southwest", "Central", "N Hollywood
","Mission","Devonshire","Northeast","Harbor","Van Nuys","West Valley
","West LA","Wilshire","Pacific","Rampart","77th Street","Topanga","Foothill","Hollenbeck","Hollywood","Newton","Olympic","Southeast"))
               ),# Boutons radio
               # Colonne 2
               column(6,
                      br(),
                      br(),
                      br(),
                      br(),
                      leafletOutput("map") # Carte Leaflet
               )
             )
    ),
    # Onglet Type de délits
    tabPanel("Type de délits",
             fluidPage(
               br(),
               br(),
               selectInput("crimeType", "Sélectionnez un type de délit :", unique(data$Crm.Cd.Desc)),
               dataTableOutput("table") # Tableau de données
             ),
    )
  )
)
#Définition du server Shiny
server <- function(input, output) {
  
  
#Mises à jour des sorties dynamiques :  
  # Mettre à jour la valeur de la boîte pour le nombre de délits en 2023
  output$maBox2 <- renderValueBox({
    valueBox(nrow(data_2023), "Nombre de délits total en 2023",
             icon = icon("calendar"))
  })
  
  output$maBox3 <- renderValueBox({
    valueBox((average_crimes_per_month_2023), "Moyenne de délits par mois en 2023",
             icon = icon("calendar-days"))
  }) 
  
  output$maBox4 <- renderValueBox({
    valueBox((average_crimes_per_day_2023), "Moyenne de délits par jour en 2023",
             icon = icon("calendar-day"))
  })
  
  
  # Afficher le bar plot sur le menu home 
  output$crimeBarPlot <- renderPlot({
    ggplot(data, aes(x = factor(year(DATE.OCC)),fill = factor(year(DATE.OCC)))) +
      geom_bar() +
      labs(title = "Nombre de délits par année",
           x = "Année",
           y = "Nombre de délits")+
      scale_fill_discrete(name = "Année")
    print(crimeBarPlot)
  })
  # Afficher les bar plot sur le menu victimes en fonction de l'année sélectionnée
  output$crimeBarPlotSexe <- renderPlot({
    selected_year <- as.numeric(input$Choix)
    
    if (selected_year == 2021) {
      ggplot(data_2021, aes(x = Vict.Sex, fill = Vict.Sex)) +
        geom_bar() +
        labs(title = "Distribution du nombre de délits selon le sexe des victimes en 2021",
             x = "Sexe",
             y = "Nombre de délits")
    } else if (selected_year == 2020) {
      ggplot(data_2020, aes(x = Vict.Sex, fill = Vict.Sex)) +
        geom_bar() +
        labs(title = "Distribution du nombre de délits selon le sexe des victimes en 2020",
             x = "Sexe",
             y = "Nombre de délits")
    } else if (selected_year == 2022) {
      ggplot(data_2022, aes(x = Vict.Sex, fill = Vict.Sex)) +
        geom_bar() +
        labs(title = "Distribution du nombre de délits selon le sexe des victimes en 2022",
             x = "Sexe",
             y = "Nombre de délits")
    } else if (selected_year == 2023) {
      ggplot(data_2023, aes(x = Vict.Sex, fill = Vict.Sex)) +
        geom_bar() +
        labs(title = "Distribution du nombre de délits selon le sexe des victimes en 2023",
             x = "Sexe",
             y = "Nombre de délits")
    } else {
      cat("Sélectionnez une année")
    }
  })
  
  
  output$Victim_age <- renderPlot({
    selected_year2 <- as.numeric(input$Choix2)
    
    if (selected_year2 == 2021) {
      ggplot(data_2021, aes(x = Vict.Age)) +
        geom_histogram(binwidth = 10, fill = "blue", color = "black", alpha = 0.5) +
        labs(title = "Distribution du nombre de délits selon l'âge des victimes en 2021",
             x = "Âge",
             y = "Nombre de délits") +
        theme_minimal()
    } else if (selected_year2 == 2020) {
      ggplot(data_2020, aes(x = Vict.Age)) +
        geom_histogram(binwidth = 10, fill = "blue", color = "black", alpha = 0.5) +
        labs(title = "Distribution du nombre de délits selon l'âge des victimes en 2020",
             x = "Âge",
             y = "Nombre de délits") +
        theme_minimal()
    } else if (selected_year2 == 2022) {
      ggplot(data_2022, aes(x = Vict.Age)) +
        geom_histogram(binwidth = 10, fill = "blue", color = "black", alpha = 0.5) +
        labs(title = "Distribution du nombre de délits selon l'âge des victimes en 2022",
             x = "Âge",
             y = "Nombre de délits") +
        theme_minimal()
    } else if (selected_year2 == 2023) {
      ggplot(data_2023, aes(x = Vict.Age)) +
        geom_histogram(binwidth = 10, fill = "blue", color = "black", alpha = 0.5) +
        labs(title = "Distribution du nombre de délits selon l'âge des victimes en 2023",
             x = "Âge",
             y = "Nombre de délits") +
        theme_minimal()
    } else {
      cat("Sélectionnez une année")
    }
  }) 
  
  
  # Afficher la carte en fonction de l'area sélectionnée
  output$map <- renderLeaflet({
    selected_area <- input$radio_input
    
    filtered_data <- data[data_2023$AREA.NAME == selected_area, ]
    
    leaflet(filtered_data) %>%
      addTiles() %>%  # Ajouter des tuiles (carte de fond)
      addMarkers(
        lat = ~LAT,    # Latitude des points
        lng = ~LON,    # Longitude des points
        popup = ~Crm.Cd.Desc,  # Popup avec la description du délit
        clusterOptions = markerClusterOptions()
      )%>%
      setView(lng = filtered_data$LON[1], lat = filtered_data$LAT[1], zoom = 13)
  })
  
  # Filtrer les données en fonction du type de crime sélectionné
  filtered_data <- reactive({
    subset(data, Crm.Cd.Desc == input$crimeType)
  })
  
  # Rendre la table interactive
  output$table <- renderDataTable({
    datatable(filtered_data(), options = list(pageLength = 5, columns = list(
        list(title = "Date.Rptd"),
        list(title = "DATE.OCC"),
        list(title = "TIME.OCC"),
        list(title = "AREA.NAME"),
        list(title = "Crm.Cd.Desc"),
        list(title = "Vict.Age"),
        list(title = "Permis.Desc"),
        list(title = "Weapon.Desc"),
        list(title = "Status.Desc"),
        list(title = "LOCATION")
)))
  })
}
#Lancer l'application Shiny
shinyApp(ui = ui, server = server)
