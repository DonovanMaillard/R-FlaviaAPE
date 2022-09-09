#' Calcule le nombre de sessions de terrain au sein d'un lot de données.
#'  Basé sur les combinaisons date_min, date_max des observations. Une chasse
#'  de jour et une chasse de nuit compteront donc pour deux sessions (une diurne
#'  et une nocturne)
#'
#' @param data La table de données importées depuis GeoNature
#' @param date_debut Le nom du champs à utiliser pour la date de début de la session (date_debut par défaut)
#' @param date_fin Le nom du champs à utiliser pour la date de fin de la session (date_fin par défaut)
#' @return Le nombre de sessions de terrain dans un lot de données
#' @export
fla_nb_session <- function(data, date_debut='date_debut', date_fin='date_fin'){
  nb_session<-dim(unique(data[,c(date_debut,date_fin)]))[1]
  return(nb_session)
}
