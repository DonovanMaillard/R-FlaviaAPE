#' Calcule le nombre de jeux de données distincts dans un lot de données
#'
#' @param data La table de données importées depuis GeoNature
#' @param column Le nom du champs à utiliser pour calculer le nombre de jeux de données (jdd_uuid par défaut)
#' @return Le nombre de jeux de données compris dans un lot de données
#' @export
fla_nb_jdd <- function(data,column='jdd_uuid'){
	nb_jdd<-length(factor(unique(data[[column]])))
	return(nb_jdd)
}
