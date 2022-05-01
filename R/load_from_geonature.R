#' Importer un fichier csv provenant de GeoNature
#' Une fonction pour importer un fichier csv issu d'un export
#' GeoNature, sans modification d'encodage ni de format.
#'
#' @param file Chemin du fichier csv à importer
#'
#' @return L'object R comportant les données issues de l'export GeoNature
#' @import utils
#' @import reportr
#' @export
load_from_geonature <- function(file){
  read.csv(file, sep=";", header=TRUE, dec=".", fileEncoding = 'UTF-8')
  message("test de message")
}
