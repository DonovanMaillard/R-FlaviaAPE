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
library(DT)
library(bslib)

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
                    #
                    # DONNEES SOURCES - INPUTS 
                    #
                    fluidRow(
                        box(title = "Données sources", status = "primary", solidHeader = TRUE, width = 12,
                            fluidRow(
                                column(12,
                                    fileInput(inputId="csvFlaviaFile", label="Fichier CSV exporté de la Flaviabase", width="100%", accept=".csv", buttonLabel="Sélectionner un fichier"),
                                )
                            )
                        )
                    ),
                    # 
                    # RESULTATS - OUTPUTS
                    # 
                    fluidRow(
                        box(title = "Statistiques globales", status = "success", solidHeader = TRUE, width = 12,
                            div(
                                fluidRow(
                                    column(4, 
                                        card(
                                            card_header(
                                                class = "bg-dark",
                                                "Nombre de données"
                                            ),
                                            card_body(
                                                h3(textOutput(outputId="nb_species"))
                                            )
                                        )
                                    ),
                                    column(4, 
                                        card(
                                            card_header(
                                                class = "bg-dark",
                                                "Nombre de taxons"
                                            ),
                                            card_body(
                                                h3(textOutput(outputId="nb_species")),
                                                br(),
                                                h4("Dont X espèces et Y sous-espèces")
                                            )
                                        )
                                        ),
                                    column(4, 
                                        card(
                                            card_header(
                                                class = "bg-dark",
                                                "Nombre de relevés"
                                            ),
                                            card_body(
                                                h3(textOutput(outputId="nb_species"))
                                            )
                                        )
                                        )
                                    ),
                            ),
                            div(
                                fluidRow(
                                    column(4, 
                                        card(
                                            card_header(
                                                class = "bg-dark",
                                                "Nombre de sessions de prospections"
                                            ),
                                            card_body(
                                                h3(textOutput(outputId="nb_species"))
                                            )
                                        )
                                    ),
                                    column(4, 
                                        card(
                                            card_header(
                                                class = "bg-dark",
                                                "Méthodes utilisées"
                                            ),
                                            card_body(
                                                h3(textOutput(outputId="nb_species")),
                                                br(),
                                                h4("Dont X espèces et Y sous-espèces")
                                            )
                                        )
                                        ),
                                    column(4, 
                                        card(
                                            card_header(
                                                class = "bg-dark",
                                                "Autre info"
                                            ),
                                            card_body(
                                                h3(textOutput(outputId="nb_species"))
                                            )
                                        )
                                        )
                                    ),
                            )
                        )
                    ),
                    # Retourner la liste des espèces dans une datatable
                    fluidRow(
                        box(title = "Taxons", status = "success", solidHeader = TRUE, width = 12,
                            DTOutput(outputId="dataTable")
                        )
                    )
            )
        )
    )
)

