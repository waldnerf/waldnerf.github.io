---
ID: 386
post_title: Add ID field to a shapefile using R
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/add-id-field-to-a-shapefile-using-r/
published: true
post_date: 2014-10-31 18:58:02
---
Hi GI(rl)S. 
Sometimes useful.

<pre lang="rsplus">
library(rgdal)

shp<-readOGR("/homes/blackguru/World_Domination.shp", layer="World_Domination")

shp@data$ID<-c(1:length(shp@data[,1]))

writeOGR(shp, "/homes/blackguru/World_Domination_ID.shp", layer="World_Domination", driver="ESRI Shapefile")

</pre>