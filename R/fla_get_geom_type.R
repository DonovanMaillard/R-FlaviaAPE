#' Calcule la diversité biologique inventoriée dans un lot de données
#'
#' @param dt La table de données comportant les données à cartographier
#' @param wkt_field Le nom du champs WKT à utiliser. Doit contenir un WKT en WGS84 (4326)
#' @return Renvoie la table de données avec un champs supplémentaire contenant la validité et le type de la géométrie WKT.
#' @import sf
#' @export

fla_get_geom_type <- function(df, wkt_field) {
  # Masquer les messages d'erreurs
  output_file <- tempfile()
  sink(output_file, type = c("output", "message"))
  
  # Traitement des données
  if (!(wkt_field %in% names(df))) {
    stop("La colonne spécifiée pour le wkt n'existe pas dans le dataframe.")
  }
  
  for (i in 1:nrow(df)) {
    #Isoler le wkt
    wkt<-df[i, wkt_field]
    # Tester sa conversion en Simple Feature
    test <- suppressMessages(try(st_sfc(st_as_sfc(wkt, crs = 4326)), silent=TRUE))
    # Renvoyer le type de géométrie 	
    if (is.na(wkt) || wkt == "") {
      df$r_app_geom_type[i] <- "no-data"
    } else if (inherits(test, "try-error")) {
      df$r_app_geom_type[i] <- "invalid"
    } else {
      df$r_app_geom_type[i] <- suppressMessages(try(st_geometry_type(st_sfc(st_as_sfc(df[[wkt_field]][i]))), silent=TRUE))
    }
  }
  sink()
  return(df)
}