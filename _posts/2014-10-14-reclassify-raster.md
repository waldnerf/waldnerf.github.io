---
ID: 125
post_title: Reclassify raster
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/reclassify-raster/
published: true
post_date: 2014-10-14 08:39:42
---
Here is a method to replace raster values with new ones.

Initiate random raster and plot result.

<pre lang="rsplus">
library(raster)
xy <- matrix(c(1:10),20,20)
r <- raster(xy)
</pre>

<pre lang="rsplus">
library(RColorBrewer)
pal<-brewer.pal(10, "Spectral") 
plot(r, col=pal[c(1:10)])
</pre>

<center>
<a href="http://www.guru-gis.net/wp-content/uploads/2014/10/reclassify1.png"><img src="http://www.guru-gis.net/wp-content/uploads/2014/10/reclassify1.png" alt="reclassify1" width="483" height="436" class="alignnone size-full wp-image-127" /></a>
</center>

<!--more-->

Build the matrix for the reclassification, the first and second column are the old and new values, respectively.

<pre lang="rsplus">
m<-c(1,5,
     2,4,
     3,0,
     4,2,
     5,1,    
     6,3,
     7,6,
     8,NaN,
     9,5,
     10,10 
)

rclmat <- matrix(m, ncol=2, byrow=TRUE)
</pre>

Reclassify the raster and plot the result.
<pre lang="rsplus">
r <- reclassify(r, rclmat)
plot(r, col=pal[c(1:10)])
</pre>

<center>
<a href="http://www.guru-gis.net/wp-content/uploads/2014/10/reclassify2.png"><img src="http://www.guru-gis.net/wp-content/uploads/2014/10/reclassify2.png" alt="reclassify2" width="483" height="436" class="alignnone size-full wp-image-128" /></a>
</center>