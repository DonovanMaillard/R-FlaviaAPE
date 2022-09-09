#' Calcule la diversité biologique inventoriée dans un lot de données
#'
#' @param data La table de données importées depuis GeoNature
#' @param column Le nom du champs à utiliser pour calculer la diversité (cd_ref par défaut)
#' @return Le nombre de taxons compris dans un lot de données
#' @export
fla_diversite <- function(data,column='cd_ref'){
	Diversite<-length(factor(unique(data[[column]])))
	return(Diversite)
}
