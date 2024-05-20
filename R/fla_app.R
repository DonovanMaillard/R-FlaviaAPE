#' Lance l'application dashboard de Flavia APE
#'
#'
#' @return Lance l'application dashboard de Flavia APE
#' @import shiny
#' @import shinydashboard
#' @import DT
#' @export

fla_app <- function() {
  appDir <- system.file("shinyapp", package = "RFlaviaAPE")
  shinyAppDir(appDir)
}
