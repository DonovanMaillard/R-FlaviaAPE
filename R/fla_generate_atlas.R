#' Génère un lot de cartes exportées au format .png (utilise en boucle la fonction fla_generate_map)
#'
#' @param df Dataframe contenant les données spatiales à cartographier, dont un champs contenant la géométrie au format WKT (projection WGS84)
#' @param territory Objet comportant la géométrie du territoire (geojson chargé avec st_read par exemple). Peut comporter un ou plusieurs polygones.
#' @param url_basemap URL du service WMS fournissant le fond de carte. Par défaut, c'est le fond topographique de l'IGN qui est utilisé : https://wxs.ign.fr/inspire/inspire/r/wms
#' @param wkt_field Chaîne de caractères décrivant le nom du champs contenant la géométrie WKT dans le dataframe source. (par défaut, "wkt")
#' @param rotate_field Chaîne de caractères décrivant le nom du champs à utiliser pour les itérations de l'atlas
#' @param label_field Chaîne de caractères décrivant le nom du champs décrivant l'étiquette de chaque carte
#' @param data_color Chaîne de caractères permettant de définir la couleur d'affichage des données (sous forme de variable "blue" ou de code hexadécimal "#ff7f00"). (Par défaut, "#ff7f00")
#' @param fillPolygons Paramètre permettant de remplir (1) ou non (0) les géométries des données "au polygone", ou de varier l'opacité du remplissage (ex. 0.5)
#' @param attrib Chaîne de caractères permettant d'afficher l'attribution en pied de carte (par défaut : "Flavia APE - 2024")
#' @param scale Paramètre TRUE/FALSE permettant d'afficher une échelle sous la carte (par défaut : TRUE)
#' @return Un lot de cartes au format .png, exportées au sein d'un dossier "atlas" dans l'environnement de travail. Chaque fichier est nommé "valeur_du_champ_d'itération.png"
#' @import sf
#' @import leaflet
#' @import leaflet.extras
#' @import mapview
#' @export

fla_generate_atlas <- function(df=data_sp, territory=NULL, url_basemap=NULL, wkt_field="wkt", rotate_field=NULL, label_field=NULL, data_color="#ff7f00", fillPolygons=1, attrib=NULL, scale=F) {
  ### Fonction imbriquée :
  ### fla_generate_map()
  ### se charge de controler la présence d'un fond de carte, d'un dataframe et d'un territoire et de produire le rendu de chaque carte
  ###
  ###### fla_get_geom_type()
  ###### se charge de préparer les données cartograhpiques

  # Contrôler les paramètres fournis
  if (missing(rotate_field) || !(rotate_field %in% names(df))) {
    stop("La colonne à utiliser pour l'itération de l'atlas n'a pas été fournie ou n'existe pas dans le dataframe fourni.")
  }

  # Contrôler la présence ou non du champs d'étiquette
  if (missing(label_field) || !(label_field %in% names(df))) {
    message("La colonne à utiliser pour étiqueter les cartes de l'atlas n'a pas été fournie ou n'existe pas dans le dataframe fourni. Aucune étiquette ne sera affichée. Poursuite du traitement...")
    label=FALSE
  } else {
    label=TRUE
  }

  # Fond de carte
  if (missing(url_basemap)) {
    url_basemap<-"https://wxs.ign.fr/inspire/inspire/r/wms"
    message("Aucun URL de Webservice WMS n'a été fourni pour le paramètre url_basemap. Un fond topographique de l'IGN sera utilisé par défaut : https://wxs.ign.fr/inspire/inspire/r/wms")
  }

  # Créer un répertoire atlas si non existant
  if (!file.exists("atlas")) {
    # S'il n'existe pas, le créer
    dir.create("atlas")
  }

  iterations<-levels(factor(df[[rotate_field]]))
  message(paste("Cartes à générer : ",length(iterations)[1]))

  # Boucle de génération de l'atlas
  for (i in 1:length(iterations)) {
    time_start<-Sys.time()
    df_iter<-subset(df, df[[rotate_field]]==iterations[i])
    map<-fla_generate_map(url_basemap=url_basemap, territory=territory, df=df_iter, wkt_field=wkt_field, data_color=data_color, fillPolygons=fillPolygons, attrib=attrib, scale=scale, print=F)
    # Ajouter l'étiquette s'il y en a une
    if (label) {
      map<-addControl(map, html=df_iter[[1, label_field]], position = "topright")
    }
    map
    # Imprimer chaque carte
    filename<-paste("atlas/",iterations[i],".png")
    mapshot(map, file = filename, cliprect = "viewport", remove_controls=c("zoomControl", "layersControl","homeButton") )
    time_end<-Sys.time()
    message(paste("Carte",i,"/",length(iterations)," (item ",iterations[i], ") a été traitée en",as.numeric(time_end - time_start),"secondes. Poursuite du traitement..."))
  }
  return("Les cartes ont été générées dans le répertoire atlas.")
}
