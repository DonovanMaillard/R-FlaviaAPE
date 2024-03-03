#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shinydashboard)

dashboardPage(
    dashboardHeader(title = "Flavia APE - Analyses"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Charger des données", tabName = "loader", icon = icon("upload")),
            menuItem("Compiler des données", tabName = "compile", icon = icon("copy")),
            menuItem("Visualiser des données", tabName = "view", icon = icon("table")),
            menuItem("Générer un rapport", tabName = "report", icon = icon("file")),
            menuItem("Générer un atlas", tabName = "maps", icon = icon("map")),
            menuItem("Analyse chronocapture", tabName = "chrono", icon = icon("clock"))
        )
    ),
    dashboardBody(
        tabItems(
            
            # First tab content
            tabItem(tabName = "loader",
                    fluidRow(
                        box(
                            title = "Charger un fichier CSV",
                            text = "Test",
                            fileInput("file", "Sélectionner un fichier...")
                        ),
                        
                        box(
                            title = "Nom de la table de données",
                            textInput("df_name", "Nom de l'objet R contenant les données (sans espaces)", placeholder = "Saisir un nom"),
                            actionButton("load", "Charger les données")
                        )
                    ),
                    fluidRow(
                        box(
                            title = "Objets actuellement disponibles dans l'environnement",
                            verbatimTextOutput("liste_objets")
                        )
                    )
            ),
            
            # Second tab content
            tabItem(tabName = "compile",
                    h2("Compiler plusieurs fichiers de données")
            ),
            
            # Third tab content
            tabItem(tabName = "view",
                    h2("Visualiser des données brutes")
            ),
            
            # Fourth tab content
            tabItem(tabName = "report",
                    h2("Générer un rapport automatique")
            ),
            
            # Fivth tab content
            tabItem(tabName = "maps",
                    h2("Générer un atlas")
            ),
            
            # Sixth tab content
            tabItem(tabName = "chrono",
                    h2("Analyse des données chronocapture")
            )
        )
    )
)