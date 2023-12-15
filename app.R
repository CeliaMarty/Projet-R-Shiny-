library(shiny)
    ui <- fluidPage(
      titlePanel("L.A DATA CRIME"),
            br(),
            br(),
            br(),
            navlistPanel(
            "MENU",
            br(),
            br(),
            br(),
            tabPanel("HOME",
                     ),
            br(),
            br(),
            br(),
            tabPanel("VICTIMS", 
            ),
            br(),
            br(),
            br(),
            tabPanel("LOCATION",
            ),
            br(),
            br(),
            br(),
            tabPanel("TYPE OF CRIME",
            ),
        mainPanel(
          img(src = "www/losangeles.jpeg", alt = "Image"),
              h3("SOME NUMBERS"),
              valueBoxOutput("maBox"),
              valueBoxOutput("maBox1")
          
        )
        )
            )
server <- function(input, output)
{
  output$maBox <- renderValueBox({
    valueBox(123, "Nombre de délits",
             icon = icon("exclamation-triangle"))
  })
  output$maBox1 <- renderValueBox({
    valueBox(122, "Nombre d'habitants",
             icon = icon("users"))
    })
}    
shinyApp(ui = ui, server = server)


