---
ID: 700
post_title: 'ggmap, map and mapdata: 3 useful packages for mapping places from the world'
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/ggmap-map-and-mapdata-3-useful-packages-for-mapping-places-from-the-world/
published: true
post_date: 2014-12-03 17:14:27
---
Hi GalaGIS !

<strong>ggmap</strong> is a useful package to question the Google map API in order to get coordinate of a specific place. Furthermore, <strong>map</strong> en <strong>mapdata</strong> combined allow to plot any countries of the world easily. What else ?

<pre lang="rsplus">
library(mapdata)
library(map)
library(ggmap)

cities<-c("Liège", "Mons", "Namur", "Anvers", "Bruxelles", "Gand", "Bruges", "Hasselt", "Arlon")

cities<-as.data.frame(cities)
cities$lat<-""
cities$long<-""

for (i in 1:nrow(cities))
{
  cities[i,2:3]<-geocode(as.character(cities$cities[i]))
}

cities$lat<-as.numeric(cities$lat)
cities$long<-as.numeric(cities$long)
points<-SpatialPointsDataFrame(cities[, 2:3], data=cities)

map('worldHires','Belgium')
plot(points,pch='.',cex=8,add=T)
text(points$lat, points$long, label=points$cities, cex=0.8, offset=0.5, pos=3)
</pre>

And the resulting plot:

<center>
<a href="http://www.guru-gis.net/wp-content/uploads/2014/12/belgium.png"><img src="http://www.guru-gis.net/wp-content/uploads/2014/12/belgium.png" alt="belgium" width="560" height="450" class="alignnone size-full wp-image-702" /></a>
</center>