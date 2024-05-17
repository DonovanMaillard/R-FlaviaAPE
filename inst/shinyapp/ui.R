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
            menuItem("Générer un rapport", tabName = "report", icon = icon("file")),
            menuItem("Compiler des données", tabName = "compile", icon = icon("copy")),
            menuItem("Générer un atlas", tabName = "atlas", icon = icon("map"))
        )
    ),
    dashboardBody(
        tabItems(
            # First tab content
            tabItem(tabName = "report",
                    h2("Générer un rapport automatique"),
                    fluidRow(
                        div(class = "col-md-12",
                            h1("Chargement du jeu de données"),
                            box(
                                title = "Fichier source",
                                "Format CSV ; avec un champs de géométrie au format WKT en WGS84",
                                fileInput("csv_data", "Sélectionner un fichier...")
                            ),
                            box(
                                title = "Token de l'export Traits de vie",
                                textInput("token-lifetraits", "Token de l'export 'Traits de vie'")
                            )
                        )
                    ),
                    fluidRow(
                        div(class = "col-md-12",
                            h1("Rapport automatique"),
                        )
                    ),
            ),

            # Second tab content
            tabItem(tabName = "compile",
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
