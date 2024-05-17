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


function(input, output, session) {
	'todo'
}

#
# Onglet rapport automatique
# 

function(input, output) {
  # Stocker le fichier source chargé dans un dataframe
  data <- reactive({
    file <- input$csv-flavia-file
    if (is.null(file))
      return(NULL)
    ext <- tools::file_ext(file$name)
    if (ext == "csv") {
      read.csv2(file$datapath, header = input$header)
    } else {
      stop("Type de fichier non supporté.")
    }
  })

  nb_data <- reactive({
        dim(data)[1]
    })
  
  # Afficher les données dans la UI
  output$nb_data <- renderText({
        # Le texte dépend de la valeur du slider
        paste("Nombre total de données : ", nb_data)
    })
}