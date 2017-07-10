---
ID: 990
post_title: 3D plot with a cut-off line
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/3d-plot-with-a-cut-off-line/
published: true
post_date: 2016-11-22 17:48:50
---
Did you ever notice that things IRL are in 3D? Well today, let's do some 3D plots!

First, let's define our three variables

<pre lang='rsplus'>
library(rgl)

x <- 1:5/10
y <- 1:5
z <- x %o% y
z <- z + .2*z*runif(25) - .1*z

</pre>

Now let's suppose that we want to plot an additional line at a specific cut-off value of 0.6

<pre lang='rsplus'>
cutoff <- 0.6
</pre>

Let's plot all that with the RGL package:
<pre lang='rsplus'>
persp(x, y, z, theta=-35, phi=10,col="lightgrey",xlab="X factor", ylab="Why", zlab="Z-bra")
cLines <- contourLines(x,y,z,levels=c(cutoff))
lines(trans3d(x=cLines[[1]]$x, y=cLines[[1]]$y, z=cutoff,pmat=p ),col = 'red',lw=2,lt=2)
</pre>


Here is the figure:
<a href="http://www.guru-gis.net/wp-content/uploads/2016/11/Screenshot-from-2016-11-22-175501.png" rel="attachment wp-att-993"><img src="http://www.guru-gis.net/wp-content/uploads/2016/11/Screenshot-from-2016-11-22-175501.png" alt="screenshot-from-2016-11-22-175501" width="482" height="447" class="alignnone size-full wp-image-993" /></a>