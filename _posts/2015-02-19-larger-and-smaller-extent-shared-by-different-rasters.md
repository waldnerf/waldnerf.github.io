---
ID: 843
post_title: >
  Larger and smaller extent shared by
  different rasters
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/larger-and-smaller-extent-shared-by-different-rasters/
published: true
post_date: 2015-02-19 09:32:07
---
Hello GISton, 

Here is a way to get the larger (red) and the smaller (green) extent shared by different rasters.

<center>
<a href="http://www.guru-gis.net/wp-content/uploads/2015/02/extent_raster.png"><img src="http://www.guru-gis.net/wp-content/uploads/2015/02/extent_raster.png" alt="extent_raster" width="546" height="391" class="alignnone size-full wp-image-844" /></a>
</center>
<pre lang='rsplus'>
library(raster)

# dummy extent from your rasters, instead use lapply(raster list, extent)
a <- raster(nrows=884, ncols=804, xmn=-45.85728, xmx=-43.76855, ymn=-2.388705, ymx=-0.5181549)
b <- raster(nrows=884, ncols=804, xmn=-45.87077, xmx=-43.78204, ymn=-2.388727, ymx=-0.5208711)
c <- raster(nrows=884, ncols=804, xmn=-45.81952, xmx=-43.7173,  ymn=-2.405129, ymx=-0.5154312)

a[] <- 1
b[] <- 2
c[] <- 3

plot(a, xlim=c(-45.8,-43.7), ylim=c(-2.41, -0.5))
par(new=TRUE)
plot(b, xlim=c(-45.8,-43.7), ylim=c(-2.41, -0.5))

a<-extent(-45, -30, -20, -10)
b<-extent(-55, -35, -25, -5) 
c<-extent(-40 ,-25 , -15 ,0)
extent_list<-list(a, b, c)

# make a matrix out of it, each column represents a raster, rows the values
extent_list<-lapply(extent_list, as.matrix)
matrix_extent<-matrix(unlist(extent_list), ncol=length(extent_list))
rownames(matrix_extent)<-c("xmin", "ymin", "xmax", "ymax")

# create an extent that covers all the individual extents
larger_extent<-extent(min(matrix_extent[1,]), max(matrix_extent[3,]),
                      min(matrix_extent[2,]), max(matrix_extent[4,]))

# create the larger extent shared by all the individual extents
smaller_extent<-extent(max(matrix_extent[1,]), min(matrix_extent[3,]),
                       max(matrix_extent[2,]), min(matrix_extent[4,]))

# Plot results

a.shp<-as(a, 'SpatialPolygons')
b.shp<-as(b, 'SpatialPolygons')
c.shp<-as(c, 'SpatialPolygons')
larger_extent.shp<-as(larger_extent, 'SpatialPolygons')
smaller_extent.shp<-as(smaller_extent, 'SpatialPolygons')
  
plot(a.shp,  xlim=c(larger_extent@xmin, larger_extent@xmax), ylim=c(larger_extent@ymin, larger_extent@ymax))
plot(b.shp,  xlim=c(larger_extent@xmin, larger_extent@xmax), ylim=c(larger_extent@ymin, larger_extent@ymax), add=TRUE)
plot(c.shp,  xlim=c(larger_extent@xmin, larger_extent@xmax), ylim=c(larger_extent@ymin, larger_extent@ymax), add=TRUE)
plot(larger_extent.shp,  xlim=c(larger_extent@xmin, larger_extent@xmax), ylim=c(larger_extent@ymin, larger_extent@ymax), 
     add=TRUE, lwd=3, border="red")
plot(smaller_extent.shp,  xlim=c(larger_extent@xmin, larger_extent@xmax), ylim=c(larger_extent@ymin, larger_extent@ymax), 
     add=TRUE, lwd=3, border="green")
</pre>