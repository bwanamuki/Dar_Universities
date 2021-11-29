#Author: Faustus S. Reginald
#Email: bwanamuki@hotmail.com
#Tel: 0754284641

library(osmdata)
library(ggplot2)
library(ggmap)
library(leaflet)

#Get boundaries 
dar<-getbb("Dar es Salaam", format_out = "polygon")

#Getting streets of Dar es Salaam
dar_street <-dar %>%
  opq() %>%
  add_osm_feature("highway", 
                  c("motorway", "primary", "secondary", "tertiary")) %>%
  osmdata_sf()

#Creating Universities and Colleges in Dar es Salaam
dar_uni <- dar%>%
  opq() %>%
  add_osm_feature(key = "amenity", value =c("university", "college"))%>%
  osmdata_sf()

#Get the map by using ggmap
dar_map <- get_map(dar, source = "osm")
ggmap(dar_map) +
  geom_sf(data = dar_uni$osm_polygons,
    inherit.aes = FALSE,
    colour = "#08519c",
    fill = "#08306b",
    alpha = .5,
    size = 1
  ) +
  geom_sf(data = dar_street$osm_lines, 
    inherit.aes = FALSE, 
    color = "#A52A2A", 
    size = .4, 
    alpha = .8) +
  labs(title="Universities and Colleges in Dar es Salaam", 
     x = "Longitude", y = "Latitude", 
     caption = "Created by: Faustus S. Reginald")+
  theme_bw()+theme(plot.title = element_text(face = "bold", hjust = 0.5),
                   plot.caption =element_text(hjust = 1, face = "italic")
                   )
