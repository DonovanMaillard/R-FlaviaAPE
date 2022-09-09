#' Calcule le nombre de relevés effectués au sein d'un lot de données.
#'  Basé sur le nombre de combinaisons différentes entre les date_min,
#'  date_max et localisation des observations.
#'
#' @param data La table de données importées depuis GeoNature
#' @param date_debut Le nom du champs à utiliser pour la date de début de la session (date_debut par défaut)
#' @param date_fin Le nom du champs à utiliser pour la date de fin de la session (date_fin par défaut)
#' @param localisation Le nom du champs à utiliser pour la localisation du relevé (wkt_l93 par défaut)
#' @return Le nombre de relevés effectués dans un lot de données
#' @export
fla_nb_releves <- function(data, date_debut='date_debut', date_fin='date_fin', localisation='wkt_l93'){
  nb_releves<-dim(unique(data[,c(date_debut,date_fin, localisation)]))[1]
  return(nb_releves)
}
