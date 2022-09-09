#' Synthese globale d'un lot de données
#' Fonction permettant d'obtenir les informations de synthèse sur un lot de données
#' Renvoie le nombre de données, de taxons, de relevés, les méthodes utilisées etc.
#'
#' @param data Le tableau R des données à analyser à partir d'un export GeoNature
#'
#' @return Rapport de synthèse du lot de données
#' @import utils
#' @import rmarkdown
#' @import markdown
#' @import knitr
#' @import magrittr
#' @import stats
#' @export
fla_rapport <- function(data){
  Nombre_donnees<-fla_nb_obs(data)[1]
  Diversite<-fla_diversite(data)[1]
  Nombre_JDD<-fla_nb_jdd(data)[1]
  Nombre_sessions<-fla_nb_session(data)[1]
  Nombre_releves<-fla_nb_releves(data)[1]
  Sessions_par_methode<-aggregate(data$date_debut, by=list(data$technique_observation), FUN=length)

  rmarkdown::render("templates/template_report.Rmd")
}
