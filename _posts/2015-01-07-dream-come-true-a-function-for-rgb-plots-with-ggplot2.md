---
ID: 768
post_title: 'Dreams come true: a function for RGB plots with GGPLOT2'
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/dream-come-true-a-function-for-rgb-plots-with-ggplot2/
published: true
post_date: 2015-01-07 14:30:25
---
In love with the ggplot2 look? Sick of using plotRGB to display your RGB raster?
Here comes the rggplot function!

Have a look:

<pre lang='rsplus'>

rggbplot <- function(inRGBRst,npix=NA,scale = 'lin'){
  
  rgblinstretch <- function(rgbDf){
    maxList <- apply(rgbDf,2,max)
    minList <- apply(rgbDf,2,min)
    temp<-rgbDf
    for(i in c(1:3)){
      temp[,i] <- (temp[,i]-minList[i])/(maxList[i]-minList[i])
    }
    return(temp)
  }
  
  rgbeqstretch<-function(rgbDf){
    
    temp<-rgbDf
    for(i in c(1:3)){
      unique <- na.omit(temp[,i])
      if (length(unique>0)){
        ecdf<-ecdf(unique)
        temp[,i] <- apply(temp[,i,drop=FALSE],2,FUN=function(x) ecdf(x))
      }
    }
    return(temp)
  }

  if(is.na(npix)){
    if(ncell(inRGBRst)>5000){
      npix <- 5000
    }
    else{
      npix <- ncell(inRGBRst)
    }
  }
  x <- sampleRegular(inRGBRst, size=npix, asRaster = TRUE)
  dat <- as.data.frame(x, xy=TRUE)
  colnames(dat)[3:5]<-c('r','g','b')
  
  if(scale=='lin'){
    dat[,3:5]<- rgblinstretch(dat[,3:5])
  } else if(scale=='stretch'){
    dat[,3:5]<- rgbeqstretch(dat[,3:5])
  }
  
  p <- ggplot()+ geom_tile(data=dat, aes(x=x, y=y, fill=rgb(r,g,b))) + scale_fill_identity()
  
}

b <- (brick(system.file("external/rlogo.grd", package="raster")))*6-600
print(rggbplot(b))

</pre>

<a href="http://www.guru-gis.net/wp-content/uploads/2015/01/rgb_ggplot2.png"><img src="http://www.guru-gis.net/wp-content/uploads/2015/01/rgb_ggplot2.png" alt="rgb_ggplot2" width="614" height="637" class="alignnone size-full wp-image-769" /></a>