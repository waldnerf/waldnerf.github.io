---
ID: 216
post_title: >
  Create raster with a defined attribute
  and color table
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/create-raster-with-a-defined-attribute-and-color-table/
published: true
post_date: 2014-10-14 21:23:10
---
In this post, Dearest Disciples, you will learn how to write a color and attribute table along with your image. For that, the good old rgdal package is used with writeGDAL and the parameters colorTable and catNames. Everything is wrapped in the function addColorTable. 

Using this, you can easily plot (as shown below) your rasters or opened them in your favorite GIS software without bothering with the symbology!


<pre lang="rsplus">
addColorTable <- function(inRstName, outRstName, rat.df){
  library(rgdal)
  r<- readGDAL(inRstName)
  rat.df$color<- as.character(rat.df$color)
  rat.df$attribute<- as.character(rat.df$attribute)
  outRst <- writeGDAL(r, outRstName, type="Byte", 
  colorTable=list(rat.df$color), 
  catNames=list(rat.df$attribute), mvFlag=11L)
  return(raster(outRst))
}


library(rgdal)
library(raster)

# create dummy data set
r <- raster(nrow=10, ncol=10)
r[] <- 0
r[51:100] <- 1
r[3:6, 1:5] <- 2
r[1, 1] <- 3
writeRaster(r,'dummy_raster.tif',overwrite=T)

# This defines the values, the color and the attribute
valT <- c(0,1,2,3)
colT <-  c("#FF0000", "#FF9900" ,"#99FF00","#0000FF")
attT <- c('Forest','Water body','City','Cropland')
rat.df <- data.frame(value=valT,color=colT,attribute=attT)

# apply the magic function
rnew <- addColorTable('dummy_raster.tif', 'dummy_raster_with_symbology.tif', rat.df)

# plot the results and tadaaaa
spplot(rnew, col.regions=colT)

</pre>

<center>
<a href="http://www.guru-gis.net/wp-content/uploads/2014/10/Rplot2.png"><img src="http://www.guru-gis.net/wp-content/uploads/2014/10/Rplot2.png" alt="Rplot" width="510" height="370" class="alignnone size-full wp-image-217" /></a></center>