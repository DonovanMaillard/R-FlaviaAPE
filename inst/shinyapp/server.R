#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shinydashboard)
library(DT)

options(shiny.maxRequestSize = 100*1024^2)  # 100 Mo en bytes


#
# Onglet rapport automatique
# 

function(input, output) {
  # Récupérer le fichier de données 
  data <- reactive({
        file <- input$csvFlaviaFile
        if (is.null(file)) {
            return(data.frame())  # retourne un dataframe vide si aucun fichier n'est chargé
        }
        read.csv2(file$datapath, h=T)
    })

  response <- reactive({
    subset(data(), data()$cd_nom==210264)
    })

  output$dataTable <- renderDT({
        datatable(response(), options = list(pageLength = 5))  # affiche les données avec pagination
    })

}
