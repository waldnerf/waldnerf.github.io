---
ID: 709
post_title: Random sampling
author: White-Guru
post_excerpt: ""
layout: post
permalink: http://www.guru-gis.net/random-sampling/
published: true
post_date: 2014-12-04 21:11:10
---
Good Evening, fellow GIS analysts!

Here is a quick function to randomly draw a set of points over your area of interest, say for an accuracy assessment. 

First the function:

<pre lang='rsplus'>

randSamp <- function(n,ext,filename=''){
  if(class(ext)=='Extent'){
    x <- runif(n, ext@xmin, ext@xmax)
    y <- runif(n, ext@ymin, ext@ymax)
    s <- SpatialPoints(list(x,y))
  } else if (class(ext) %in% c('Raster','RasterStack','RasterBrick')){
    x <- runif(2*n, extent(ext)@xmin, extent(ext)@xmax)
    y <- runif(2*n, extent(ext)@ymin, extent(ext)@ymax)
    s <- SpatialPoints(list(x,y))
    proj4string(s) <- crs(ext)
  } else if (class(ext) %in% c('SpatialPolygonsDataFrame','SpatialPolygons')){
    x <- c()
    y <- c()
    id <- c()
    while(length(x)<n){
      xl <- runif(2*n, extent(ext)@xmin, extent(ext)@xmax)
      yl <- runif(2*n, extent(ext)@ymin, extent(ext)@ymax)
      sl <- SpatialPoints(list(xl,yl))
      proj4string(sl) <- proj4string(ext)
      point_in_pol <- over( sl , ext , fn = NULL,returnList = FALSE)
      idl <- which(!apply(point_in_pol, 1, function(x) all(is.na(x))))
      x <- cbind(x,xl[idl])
      y <- cbind(y,yl[idl])
    }
    id<-sample(c(1:length(x)),n)
    s <- SpatialPoints(list(x[id],y[id]))
    proj4string(s) <- proj4string(ext)
  } else {
    print('ext not of class "Extent" nor "SpatialPolygonsDataFrame", "SpatialPolygons", "Raster", "RasterStack","RasterBrick". I cannot work with this')
    break
  }
  if(filename!=''){
    s_points_df <- SpatialPointsDataFrame(s, data=data.frame(ID=1:n))
    shapefile(s_poly_df,filename,overwrite=TRUE)
  }
  return(s)
}
</pre>

And a example on how to use it:
<pre lang='rsplus'>
library(sp)
library(rgdal)
library(raster)
set.seed(1)
dat <- matrix(stats::rnorm(2000), ncol = 2)
ch <- chull(dat)
coords <- dat[c(ch, ch[1]), ]  # closed polygon
ext <- SpatialPolygons(list(Polygons(list(Polygon(coords)), ID=1)))
proj4string(ext) = CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
spsamp <- randSamp(10,ext)

# Now let's visualize this piece of art
plot(ext)
plot(spsamp,add=T,col='red')

</pre>
<a href="http://www.guru-gis.net/wp-content/uploads/2014/12/sampling.png"><img src="http://www.guru-gis.net/wp-content/uploads/2014/12/sampling.png" alt="sampling" width="559" height="358" class="alignnone size-full wp-image-710" /></a>