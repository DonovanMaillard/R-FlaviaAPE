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
library(dplyr)

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

  # Nombre de données
  output$nb_data <- renderText({
        nrow(data())
    })

  # Liste des taxons
  taxa <- reactive({
    data() %>%
      distinct(cd_ref, nom_valide, group3_inpn)
    })

  output$dataTable <- renderDT({
    datatable(taxa(), options = list(pageLength = 5))# affiche les données avec pagination
    })

  output$export_taxa <- downloadHandler(
    filename<-function(){
        paste('taxons_',Sys.Date(),'.csv',sep=',')
      },
      content<-function(){
        write.csv2(taxa(),filename)
      }
    )

  # Nombre de taxons
  output$nb_species <- renderText({
        nrow(taxa())
    })

}
