---
ID: 705
post_title: On stretching histograms
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/on-stretching-histograms/
published: true
post_date: 2014-12-03 20:05:10
---
Hello GIS addicts!

Here are two functions on how to stretch the histograms of your raster for better visualization.

<pre lang='rsplus'>
#' @title Linear stretch of a multi-band raster.
#' 
#' @description Applies a linear stretch to any multiband raster \code{link{stack}} or \code{link{brick}}
#' 
#' @param img Raster* object
#' @param minmax  user defined minimum and maximum for the stretch (optional)
#' @return a Raster* object 
#' @author White-Guru
#' @seealso \code{\link{calc}}
#' @import raster
#' @export
#' 

linstretch<-function(img,minmax=NA){
  if(is.na(minmax)) minmax<-c(min(getValues(img),na.rm=T),max(getValues(img),na.rm=T))
  temp<-calc(img,fun=function(x) (255*(x-minmax[1]))/(minmax[2]-minmax[1]))
  #set all values above or below minmax to 0 or 255
  temp[temp<0]<-0;temp[temp>255]<-255;
  return(temp)
}

#' @title Histogram equalization stretch of a multi-band raster.
#' 
#' @description Applies a histogram equalization stretch to any multiband raster \code{link{stack}} or \code{link{brick}}
#' 
#' @param img Raster* object
#' @return a Raster* object 
#' @author White-Guru
#' @seealso \code{\link{calc}}
#' @import raster
#' @export
#'
eqstretch<-function(img){
  unique <- na.omit(getValues(img))
  if (length(unique>0)){
    ecdf<-ecdf(unique)
    out <- calc(img,fun=function(x) ecdf(x)*255)
  }
  return(out)
}
</pre>

And here is a dummy example of their effect:

<pre lang='rsplus'>

library(raster)
library(RColorBrewer)

#import a random raster
b <- (brick(system.file("external/rlogo.grd", package="raster")))*6-600
plotRGB(linstretch(b))

b4 <- subset(b,1)

nf<-layout(matrix(seq(1,8), byrow=T, nrow=2))
par(mar=c(3,3,1,1),oma=rep(0,4))
myramp<-colorRampPalette(brewer.pal(5,"PiYG")) #custom ramp from RColorBrewer

# no stretch
# BAD hack in order to get plot(*Raster) to look like it didn't apply a Min/Max stretch
temp<-b4; temp[1]<-0; temp[2]<-255;
plot(temp, col=myramp(255)) #plot with diff color map
hist(getValues(b4), freq=F, main="Original raster")
rm(temp)

#min/max stretch and histogram
b4.minmax<-linstretch(b4)
plot(b4.minmax, col=myramp(255))
hist(getValues(b4.minmax), breaks=seq(0,255), xlim=c(0,255), freq=F, main="Linear Min/Max")
rm(b4.minmax)

#histogram equalization
plot(eqstretch(b4), col=myramp(255))
b4.ecdf<-ecdf(getValues(b4))
hist(getValues(calc(b4, fun=function(x) b4.ecdf(x)*255)), breaks=seq(0,255), xlim=c(0,255), freq=F, main="Histogram Equalization")

#2% linear stretch
b4quant<-quantile(getValues(b4), c(0.02,0.98)) # 2% cutoffs
b4.linstretch<-linstretch(b4, minmax=c(b4quant[1],b4quant[2]))
plot(b4.linstretch, col=myramp(255))
hist(getValues(b4.linstretch), breaks=seq(0,255), xlim=c(0,255), freq=F, main="Linear 2%")
</pre>

And here is the result:
<a href="http://www.guru-gis.net/wp-content/uploads/2014/12/hist.png"><img src="http://www.guru-gis.net/wp-content/uploads/2014/12/hist.png" alt="hist" width="975" height="207" class="alignnone size-full wp-image-706" /></a>