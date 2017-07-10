---
ID: 816
post_title: Generate a random landscape
author: Grey Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/generate-a-random-landscape/
published: true
post_date: 2015-01-19 16:01:46
---
Hey GuruFans…

Have you ever wanted to test all your cool algorithms on a simulated landscape instead of a real one? No? Well, too bad… I will still show you how to create quickly a nice landscape from scratch using the R secr and raster packages…

<pre>
# script to generate a random landscape

require(raster)
require(secr)
require(igraph)
tempmask &lt;- make.mask(nx = 200, ny = 200, spacing = 10)

# Create 3 masks with different properties of the degree of fragmentation or aggregation of the patches (p), the proportion occupied by the patches (A) and the minimum patch size (minpatch)
DBFmask &lt;- raster(randomHabitat(tempmask, p = 0.5, A = 0.2, minpatch = 20))
WCRmask &lt;- raster(randomHabitat(tempmask, p = 0.4, A = 0.4, minpatch = 8))
SCRmask &lt;- raster(randomHabitat(tempmask, p = 0.3, A = 0.5, minpatch = 5))

r &lt;- raster(tempmask)

r[] &lt;- 4
r[which(as.vector(SCRmask)==1)]&lt;-3
r[which(as.vector(WCRmask)==1)]&lt;-2
r[which(as.vector(DBFmask)==1)]&lt;-1

plot(r)
</pre>

And it should look something like this:


<a href="http://www.guru-gis.net/wp-content/uploads/2015/01/Rplot.png"><img class="alignnone size-medium wp-image-817" src="http://www.guru-gis.net/wp-content/uploads/2015/01/Rplot-300x286.png" alt="Rplot" width="300" height="286" /></a>