---
ID: 984
post_title: Count points in polygons
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/count-points-in-polygons/
published: true
post_date: 2016-11-10 16:49:04
---
Hi guys, 

Here is a quick r-snippet to count points inside polygons:

<pre lang='rsplus'>
library("raster")

x <- getData('GADM', country='ITA', level=1)
class(x)
# [1] "SpatialPolygonsDataFrame"
# attr(,"package")
# [1] "sp"

set.seed(1)
# sample random points
p <- spsample(x, n=300, type="random")
p <- SpatialPointsDataFrame(p, data.frame(id=1:300))

proj4string(x)
# [1] " +proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0"
proj4string(p)
# [1] " +proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0"

plot(x)
plot(p, col="red" , add=TRUE)
</pre>

Here is the figure:
<a href="http://www.guru-gis.net/wp-content/uploads/2016/11/Screenshot-from-2016-11-10-165353.png" rel="attachment wp-att-985"><img src="http://www.guru-gis.net/wp-content/uploads/2016/11/Screenshot-from-2016-11-10-165353.png" alt="screenshot-from-2016-11-10-165353" width="592" height="760" class="alignnone size-full wp-image-985" /></a>

<pre lang='rsplus'>
res <- over(p, x)
table(res$NAME_1) # count points
#               Abruzzo                Apulia            Basilicata
#                    11                    20                     9
#              Calabria              Campania        Emilia-Romagna
#                    16                     8                    25
# Friuli-Venezia Giulia                 Lazio               Liguria
#                     7                    14                     7
#             Lombardia                Marche                Molise
#                    22                     4                     3
#              Piemonte              Sardegna                Sicily
#                    35                    18                    21
#               Toscana   Trentino-Alto Adige                Umbria
#                    33                    15                     6
#         Valle d'Aosta                Veneto
#                     4                    22

</pre>