---
ID: 870
post_title: Extract raster values in parallel
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/extract-raster-values-in-parallel/
published: true
post_date: 2015-04-02 11:27:05
---
Dear fellow Remote Senseis,

Here is a code chunk that will help you speed up the processing time when you want to extract raster values at specific locations.
It uses the a package called snowfall which allows parallel processing.
As usual, please find here under a dummy example. As there is only 3 bands it the stack, you may not see the positive effect of parallel computing...try with a 100-layer stack and you'll see.

Cheers

<pre lang='rsplus'>
install.packages("snowfall")

library(snowfall)
library(raster)

ncpus <- 3

r <- (stack(system.file("external/rlogo.grd", package="raster")))
inSlist <- unstack(r) # convert to list of single raster layers

rId <- subset(r,1)
idPix <- which(rId[]>200)

sfInit(parallel=TRUE,cpus=ncpus)
sfLibrary(raster)
sfLibrary(rgdal)
a <- sfSapply(inSlist,extract,y=idPix)
sfStop()
</pre>