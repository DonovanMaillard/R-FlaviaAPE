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

# Chargement des fichiers
load_data <- function(input, output) {
    observeEvent(input$load, {
        req(input$file)
        df <- read.csv2(input$file$datapath, h=T, fileEncoding = "UTF-8")

        # Nom par défaut si non fourni
        name <- input$df_name
        if (is.null(name) || name == "") {
            name <- "loaded_data"
        }

        assign(name, df, envir = .GlobalEnv)

        return(name)

        # Fonction pour recharger la liste des objets
        liste_objets <- reactive({
            # Obtenir les noms des objets dans l'environnement global
            objets <- ls(envir = .GlobalEnv)
            return(objets)
        })

        # Afficher la liste des objets dans l'interface
        output$liste_objets <- renderPrint({
            objets <- liste_objets()
            if (length(objets) > 0) {
                return(objets)
            } else {
                return("Aucun objet trouvé dans l'environnement.")
            }
        })
    })
}
