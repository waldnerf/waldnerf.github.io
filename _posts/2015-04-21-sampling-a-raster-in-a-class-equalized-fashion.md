---
ID: 875
post_title: >
  Sampling a raster in a class-equalized
  fashion
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/sampling-a-raster-in-a-class-equalized-fashion/
published: true
post_date: 2015-04-21 08:49:24
---
Dear followers,

Here is a function that would allow to sample randomly each class of a raster equally given the minor class in the landscape.

<pre lang='rsplus'>
rSampleEqualClass <- function(r,prop=1){
  
  if((prop>1) | (prop<0) ){
    print('prop value outside bouds')
  } else {
    # Identify n, the number of pixels to extract by class
    count <- as.matrix(table(r[]))
    n <- ceiling(prop*min(count))
    
    # extract the random pixels
    l <- as.data.frame(sampleStratified(r,size=n))
    colnames(l)<-c("cell",'values')
    
    # create new raster with the selected pixels
    r.out <- r
    r.out[]<-NA
    r.out[l$cell] <- l$values
    
   
  }
  return(r.out)
}
</pre>

And here a small example to demonstrate its use:

<pre lang='rsplus'>
library(raster)

r <- raster(system.file("external/rlogo.grd", package="raster"))
r[r<=105]<-0
r[r>105]<-1
plot(r)

for(i in 1:10){
  print(i)
  plot(rSampleEqualClass(r,prop=0.8),main=i)
}
</pre>