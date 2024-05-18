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
                        box(title = "Données sources", status = "primary", solidHeader = TRUE, width = 12,
                            fluidRow(
                                column(12,
                                    fileInput(inputId="csv-flavia-file", label="Fichier CSV exporté de la Flaviabase", width="100%", accept=".csv", buttonLabel="Sélectionner un fichier"),
                                ),
                                column(6,
                                    textInput(inputId="token-lifetraits", label="Token de l'export 'Traits de vie'", placeholder="Disponible depuis le module exports de la FlaviaBase"),
                                ),
                                column(6,
                                    fileInput(inputId="geojson-file", label="Fichier geojson du territoire étudié (optionnel)", buttonLabel="Sélectionner un fichier GeoJson")
                                )
                            )
                        )
                    ),
                    # Si les données sources sont en attente : 
                    fluidRow(
                        "En attente de données à analyser"
                        ),
                    # Si des données sources sont fournies, retourner le rapport :
                    fluidRow(
                        box(title = "Rapport automatique : analyse descriptive", status = "success", solidHeader = TRUE, width = 12,
                            # Données de synthèse globale
                            fluidRow(
                                column(12, 
                                    h3("Chiffres clés")
                                ),
                                column(4,
                                    "Nombre total de données",
                                    textOutput("nb_data")
                                ),
                                column(4,
                                    tableOutput("contents")
                                ),
                                column(4,
                                    "Nombre de relevés"
                                )
                            ),
                            # Prospection
                            fluidRow(
                                column(12, 
                                    h3("Effort de prospection")
                                ),
                                column(6,
                                    "Méthodes utilisées"
                                ),
                                column(6,
                                    "Carte"
                                )
                            ),
                            # Espèces et traits de vie
                            fluidRow(
                                column(12, 
                                    h3("Espèces et traits de vie")
                                ),
                                column(6,
                                    "Tableau des espèces"
                                ),
                                column(6,
                                    "Graphiques, statuts, traits de vie etc"
                                )
                            )
                        )
                    )
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
