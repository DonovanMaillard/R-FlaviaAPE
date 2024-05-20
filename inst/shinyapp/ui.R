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
                                    fileInput(inputId="csvFlaviaFile", label="Fichier CSV exporté de la Flaviabase", width="100%", accept=".csv", buttonLabel="Sélectionner un fichier"),
                                )
                            )
                        )
                    ),
                    fluidRow(
                        box(title = "Statistiques globales", status = "success", solidHeader = TRUE, width = 12,
                            textOutput(outputId="nb_species")
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

