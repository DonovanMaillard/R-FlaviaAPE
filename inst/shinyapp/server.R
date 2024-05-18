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
  data <- eventReactive(input$goButton, {
    file <- req(input$csv_flavia_file)  # Correction du nom de l'input (utilisez des underscores)
    if (is.null(file))
      print("Data is NULL")
      return(NULL)
    ext <- tools::file_ext(file$name)
    print(paste("File extension:", ext))
    if (ext == "csv") {
      read.csv2(file$datapath, header = input$header)
    } else {
      stop("Type de fichier non supporté.")
    }
  })

  # Calculer le nombre de données
  nb_data <- reactive({
    if (is.null(data())) {
      return(0)  # retourner 0 si les données sont NULL
    } else {
      return(nrow(data()))  # utiliser nrow pour obtenir le nombre de lignes
    }
  })
  
  # Afficher le nombre total de données dans la UI
  output$nb_data <- renderText({
    # Utiliser nb_data() pour obtenir la valeur de l'expression réactive
    paste("Nombre total de données : ", nb_data())
  })

  output$contents <- renderTable({
    data()
  })
}
