---
ID: 102
post_title: Define No Data of a raster
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/define-no-data-of-a-raster/
published: true
post_date: 2014-10-13 18:46:45
---
Initiate random raster.

<pre lang="rsplus">
library(raster)
xy <- matrix(c(1:10),20,20)
r <- raster(xy)
</pre>

Plot result.

<pre lang="rsplus">
library(RColorBrewer)
pal<-brewer.pal(10, "Spectral") 
plot(r, col=pal[c(1:10)])
</pre>

<center><a href="http://www.guru-gis.net/wp-content/uploads/2014/10/nodata1.png"><img src="http://www.guru-gis.net/wp-content/uploads/2014/10/nodata1.png" alt="nodata1" width="399" height="436" class="alignnone size-full wp-image-104" /></a></center>

<!--more-->

Define No Data and plot result.

<pre lang="rsplus">
r[r==6]<-NaN
plot(r, col=pal[c(1:10)])
</pre>

<center><a href="http://www.guru-gis.net/wp-content/uploads/2014/10/nodata2.png"><img src="http://www.guru-gis.net/wp-content/uploads/2014/10/nodata2.png" alt="nodata2" width="399" height="436" class="alignnone size-full wp-image-105" /></a></center>