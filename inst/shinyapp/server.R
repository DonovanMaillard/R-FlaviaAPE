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

options(shiny.maxRequestSize = 100*1024^2)  # 100 Mo en bytes


#
# Onglet rapport automatique
# 

function(input, output) {
  # Stocker le fichier source chargé dans un dataframe
  observeEvent(input$'goButton', {
    output$token <- renderText({
     paste("La token est ", input$'token-lifetraits')
    })
  })
  
}
