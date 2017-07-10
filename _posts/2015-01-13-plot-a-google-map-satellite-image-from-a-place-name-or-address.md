---
ID: 789
post_title: >
  Plot a google map satellite image from a
  place name or address
author: Khan-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/plot-a-google-map-satellite-image-from-a-place-name-or-address/
published: true
post_date: 2015-01-13 09:17:54
---
Good morning Gis addict, 
Need a HR satellite image from Google Map for a figure?
Here is an easy way!


<pre lang="rsplus">

library(dismo)

# enter the address here
x <- geocode('Croix du Sud 2,1348 Louvain‐la‐Neuve')
e <- extent(as.numeric(x[5:8])+ c(-0.001, 0.001, -0.001, 0.001))
g <- gmap(e, type = "satellite")
plot(g)
</pre>
<a href="http://www.guru-gis.net/wp-content/uploads/2015/01/LLN.png"><img class="alignnone size-full wp-image-790" src="http://www.guru-gis.net/wp-content/uploads/2015/01/LLN.png" alt="LLN" width="994" height="643" /></a>