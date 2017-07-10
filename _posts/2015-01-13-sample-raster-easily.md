---
ID: 806
post_title: Sample raster easily
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/sample-raster-easily/
published: true
post_date: 2015-01-13 14:14:20
---
Hey GISette! What's up?

Here is a simple way to sample a raster as Raster object or SpatialPointsDataFrame using the library <strong>raster</strong> in r.

<a href="http://www.guru-gis.net/wp-content/uploads/2015/01/3plot.png"><img src="http://www.guru-gis.net/wp-content/uploads/2015/01/3plot.png" alt="3plot" width="1338" height="368" class="alignnone size-full wp-image-812" /></a>
<pre lang='rsplus'>
library(raster)
r <- raster(system.file("external/test.grd", package="raster"))
plot(r)

x<-sampleRandom(r, size=1000, asRaster=TRUE)
plot(x)

y<-sampleRandom(r, size=100, sp=TRUE)
plot(r)
plot(y, add=TRUE, pch=20, col="black")
</pre>