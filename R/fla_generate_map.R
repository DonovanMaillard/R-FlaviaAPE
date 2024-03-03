#' Cartographie standardisée des données spatiales.
#'
#' @param df Dataframe contenant les données spatiales à cartographier, dont un champs contenant la géométrie au format WKT (projection WGS84)
#' @param territory Objet comportant la géométrie du territoire (geojson chargé avec st_read par exemple). Peut comporter un ou plusieurs polygones.
#' @param url_basemap URL du service WMS fournissant le fond de carte. Par défaut, c'est le fond topographique de l'IGN qui est utilisé : https://wxs.ign.fr/inspire/inspire/r/wms
#' @param wkt_field Chaîne de caractères décrivant le nom du champs contenant la géométrie WKT dans le dataframe source. (par défaut, "wkt")
#' @param data_color Chaîne de caractères permettant de définir la couleur d'affichage des données (sous forme de variable "blue" ou de code hexadécimal "#ff7f00"). (Par défaut, "#ff7f00")
#' @param fillPolygons Paramètre permettant de remplir (1) ou non (0) les géométries des données "au polygone", ou de varier l'opacité du remplissage (ex. 0.5)
#' @param title Chaîne de caractères permettant d'afficher un titre en tête de la carte.
#' @param attrib Chaîne de caractères permettant d'afficher l'attribution en pied de carte (par défaut : "Flavia APE - 2024")
#' @param scale Paramètre TRUE/FALSE permettant d'afficher une échelle sous la carte (par défaut : TRUE)
#' @param print Paramètre TRUE/FALSE permettant d'exporter la carte dans le répertoire de travail au format image .png. (Par défaut: TRUE)
#' @param filename Chaîne de caractère définissant le nom du fichier png si Print=T. (Par défaut : "map.png")
#' @return La carte des données spatiales, avec un masque et une emprise correspondant au territoire fourni.
#' @import sf
#' @import leaflet
#' @import leaflet.extras
#' @import mapview
#' @export

fla_generate_map <- function(df=NULL, territory=NULL, url_basemap=NULL, wkt_field="wkt", data_color="#ff7f00", fillPolygons=1, title=NULL, attrib="Flavia APE - 2024", scale=T, print=T, filename="map.png") {
  ### Fonction imbriquée : 
  ### fla_get_geom_type()
  ###
  # Contrôler la présence de données géographiques
  if (missing(df)) {
    stop("Aucune données géographique fournie pour le paramètre df.")
  }
  
  # Fond de carte
  if (missing(url_basemap)) {
    url_basemap<-"https://wxs.ign.fr/inspire/inspire/r/wms"
    message("Aucun URL de Webservice WMS n'a été fourni pour le paramètre url_basemap. Un fond topographique de l'IGN sera utilisé par défaut : https://wxs.ign.fr/inspire/inspire/r/wms")
  }
  
  # Contrôler la présence du territoire
  if (missing(territory)) {
    stop("Aucun territoire n'a été fourni pour définir le rendu, le masque et l'emprise de la carte : cette information est nécessaire. Vous pouvez charger un fichier GeoJSON (WGS84) avec la fonction mon_territoire<-st_read(mon_fichier.geojson)")
  }
  
  # Etablir une zone tampon blanche autour du territoire (pour les rendus)
  buffered_bbox_polygon <- st_bbox(st_buffer(territoire, 1000000)) %>% st_as_sfc()
  
  # Déduire notre territoire de la zone blanche
  mask <- st_difference(buffered_bbox_polygon,st_union(territoire))
  
  # Calculer la bbox pour définir l'emprise affichée
  bbox <- st_bbox(territoire) %>% as.character()
  
  # Calculer le type de géométrie qui correspond à chaque ligne
  df<-fla_get_geom_type(df, wkt_field)
  
  # Créer 3 couches distinctes pour les points, les lignes, et les polygones
  sp_points <- df[df$r_app_geom_type %in% c(2, 5), ]
  sp_lines <- df[df$r_app_geom_type %in% c(3, 6), ]
  sp_polygons <- df[df$r_app_geom_type %in% c(4, 7), ]
  
  
  # Générer la carte 
  # Données cartographies de base
  map<- leaflet()%>%
    addWMSTiles(
      url_basemap,
      layers = "EL.GridCoverage",
      options = WMSTileOptions(format = "image/png", transparent = TRUE, opacity = 0.2),
      attribution = attrib
    ) %>%
    addPolygons(
      data=mask,
      fillOpacity = 1,
      color = "black",
      fillColor = "white",
      stroke=TRUE,
      weight = 1
    ) %>%
    fitBounds(bbox[1], bbox[2], bbox[3], bbox[4])
  
  # Elements optionnels
  if (scale) {
    map<-addScaleBar(map, position = "bottomleft")
  }
  
  if (!missing(title)) {
    map<-addControl(map, html=title, position = "topright")
  }	
  
  # S'il y a des polygones
  # Créer les objets SF correspondants et les ajouter à la carte
  
  if (nrow(sp_polygons) > 0) {
    sf_polygons<-st_as_sf(st_as_sfc(sp_polygons[[wkt_field]], crs = 4326))
    map<-addPolygons(
      map,
      data=sf_polygons,
      color=data_color,
      opacity=1,
      fillOpacity=fillPolygons,
      weight=1,
      layerId=sf_polygons$id_synthese
    )
  } else {
    NULL
  }
  
  # S'il y a des lignes
  # Créer les objets SF correspondants et les ajouter à la carte
  
  if (nrow(sp_lines) > 0) {
    sf_polylines<-st_as_sf(st_as_sfc(sp_lines[[wkt_field]], crs = 4326))
    map<-addPolylines(
      map,
      data=sf_polylines,
      color=data_color,
      opacity=1,
      layerId=sf_polylines$id_synthese
    )
  } else {
    NULL
  }
  
  # S'il y a des points
  # Créer l'objet SFC correspondant et ajouter ses items à la carte
  
  if (nrow(sp_points) > 0) {
    sfc_points<-st_cast(st_as_sfc(sp_points[[wkt_field]], crs = 4326), "POINT") #Ne conserve qu'un point, même si type multipointipoint
    map<-addCircles(
      map,
      data=st_coordinates(sfc_points),
      color=data_color,
      opacity=1,
      layerId=sfc_points$id_synthese
    )
  } else {
    NULL
  }
  
  map<-addPolygons(
    map,
    data=territoire,
    weight = 1,
    color = "black",
    fillOpacity = 0
  )
  
  # Si impression demandée :
  if (print) {
    mapshot(map, file = filename, cliprect = "viewport", remove_controls=c("zoomControl", "layersControl","homeButton"))
  }
  
  return(map)
}