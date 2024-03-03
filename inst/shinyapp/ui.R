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
            tabItem(tabName = "report",
                    h2("Générer un rapport automatique")
            ),

            # Second tab content
            tabItem(tabName = "compare",
                    h2("Comparer deux lots de données")
            ),

            # Third tab content
            tabItem(tabName = "atlas",
                    h2("Générer un atlas"),
                    fluidRow(
                        box(
                            title = "Charger les données d'observations",
                            "Format CSV ; avec un champs de géométrie au format WKT en WGS84",
                            fileInput("csv_obs", "Sélectionner un fichier...")
                        ),
                        box(
                            title = "Charger la couche territoire en geojson",
                            "Fichier GeoJSON comportant un ou plusieurs polygones, en WGS84",
                            fileInput("territory_file", "Sélectionner un fichier...")
                        )
                    ),
                    fluidRow(
                        box(
                            title = "Paramètres de l'atlas"
                        )
                    )
            ),

            # Fourth tab content
            tabItem(tabName = "chrono",
                    h2("Analyse des données chronocapture")
            )
        )
    )
)
