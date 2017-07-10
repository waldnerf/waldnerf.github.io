---
ID: 674
post_title: Define class specific functions
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/define-class-specific-functions/
published: true
post_date: 2014-12-03 10:41:17
---
Tired of specifying all the parameters for a graph you do very often?
Here is a dummy example explaining how to define a function specifically for a class:

<pre lang='rsplus'>
y18 <- c(1:3, 5, 4, 7:3, 2*(2:5), rep(10, 4))
x18 <- c(1:18)
(ys18  <- smooth.spline(x18,y18))
outl<-which(abs(y18-ys18$y)>3*sd(abs(y18-ys18$y)))
x <- list(y=y18,ys=ys18,outl=outl)
class(x)<-'splint'

plot.splint<-function(x,...){
  plot(x$y,...)
  lines(x$ys,col='blue')
  points(x$outl,x$y[x$outl],col='red',pch=20)
}

plot(x,main='Temporal smoothing and outlier deteciton',xlab='Time',ylab='Vegetation Index')

</pre>

And here is the result:

<center>
<a href="http://www.guru-gis.net/wp-content/uploads/2014/12/temporal_smoothing.png"><img src="http://www.guru-gis.net/wp-content/uploads/2014/12/temporal_smoothing.png" alt="temporal_smoothing" width="559" height="351" class="alignnone size-full wp-image-676" /></a>
</center>