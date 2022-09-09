#' Calcule le nombre d'observations dans un lot de données
#'
#' @param data La table de données importées depuis GeoNature
#'
#' @return Le nombre d'observations dans un lot de données
#' @import utils
#' @export
fla_nb_obs <- function(data){
  nb_obs<-dim(data)[1]
  return(nb_obs)
}
