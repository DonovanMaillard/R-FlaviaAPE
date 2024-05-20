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
    #req(input$csvFlaviaFile)
    read.csv2(input$csvFlaviaFile$datapath, h=T)
    })

    # Déclencher l'analyse au clic de l'utilisateur
    output$DTData <- renderDT({
      input$LaunchReport
        isolate({
          data()
        })
      })
}
