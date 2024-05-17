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
                    h1("Générer un rapport automatique"),
                    fluidRow(
                        box(width=12,
                            h2("Chargement du jeu de données"),
                            fileInput(inputId="csv-flavia-file", label="Fichier CSV exporté de la Flaviabase", width="100%", buttonLabel="Sélectionner un fichier"),
                            textInput(inputId="token-lifetraits", label="Token de l'export 'Traits de vie'", width="50%", placeholder="Disponible depuis le module exports de la FlaviaBase"),
                            fileInput(inputId="geojson-file", label="Fichier geojson du territoire étudié (optionnel)", width="50%", buttonLabel="Sélectionner un fichier GeoJson")
                        )
                    ),
                    fluidRow(
                        box(width=12,
                            h2("Analyse descriptive du lot de données")
                        )
                    ),
            ),

            # Second tab content
            tabItem(tabName = "compile",
                    h1("Compiler deux lots de données"),
                    fluidRow(
                        box(width=12,
                            h2("Chargement des jeux de données"),
                            box(
                                title = "Fichier CSV de référence",
                                "Fichier CSV de référence (FlaviaBase)",
                                fileInput("csv-ref-file", "Sélectionner un fichier..."),
                                width=6
                            ),
                            box(
                                title = "Fichier CSV à comparer (bibliographie)",
                                "Fichier CSV à comparer (SINP)",
                                fileInput("csv-biblio-file", "Sélectionner un fichier..."),
                                width=6
                            ),
                            box(
                                title = "Token de l'export Traits de vie (Optionnel)",
                                "Disponible depuis le module d'exports de la flaviabase",
                                textInput("token-lifetraits", "Token de l'export 'Traits de vie'"),
                                width=6
                            )
                        )
                    ),
                    fluidRow(
                        box(width=12,
                            h2("Analyse descriptive du lot de données"),
                        )
                    ),
            ),

            # Third tab content
            tabItem(tabName = "atlas",
                    h1("Générer un atlas"),
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
            )
        )
    )
)
