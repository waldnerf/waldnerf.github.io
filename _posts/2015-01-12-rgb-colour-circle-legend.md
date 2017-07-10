---
ID: 773
post_title: RGB colour circle legend
author: Grey Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/rgb-colour-circle-legend/
published: true
post_date: 2015-01-12 20:07:12
---
<del datetime="2015-01-12T19:07:17+00:00"></del>Hello world!
Have you ever needed to make a slick legend for an RGB map or plot such as this:

<center>
<a href="http://www.guru-gis.net/wp-content/uploads/2015/01/dum.map_.GPPintercompMap.png"><img class="alignnone size-medium wp-image-799" src="http://www.guru-gis.net/wp-content/uploads/2015/01/dum.map_.GPPintercompMap-300x300.png" alt="dum.map.GPPintercompMap" width="300" height="300" /></a>
</center>

Here is how to do it vectorially in R, and then adding it to your plotRGB map:

<pre lang='rsplus'>
add.3C.lgd<- function(x0, y0, scl){
 
  # x0  y0 indicate the position of where to place your legend, scl is used to change its size...

  # primary colours
  smp=seq(0,2*pi,pi/180)
  c.x=cos(smp)
  c.y=sin(smp)
  c.x[which(smppi*5/3)]=NA
  c.y[which(smppi*5/3)]=NA
  c.x[rev(which(smp>=pi*5/3))]=cos(smp[which(smp>=pi & smp=pi*5/3))]=sin(smp[which(smp>=pi & smp=pi*1/3 & smp=pi  smp=pi*1/3  smp=pi  smp<=pi*4/3)])+sqrt(3)/2
  
  c.x.g=c.x
  c.y.g=c.y
  c.x.b <- c.x*cos(2/3*pi)-c.y*sin(2/3*pi)+1
  c.y.b <- c.x*sin(2/3*pi)+c.y*cos(2/3*pi)
  c.x.r <- c.x*cos(4/3*pi)-c.y*sin(4/3*pi)+0.5
  c.y.r <- c.x*sin(4/3*pi)+c.y*cos(4/3*pi)+sqrt(3)/2
  
  # secondary colours
  smp1=seq(1/3*pi,2/3*pi,pi/180)
  smp2=seq(pi,4/3*pi,pi/180)
  smp3=rev(seq(2/3*pi,pi,pi/180))
  
  ci.x=c(cos(smp1),cos(smp2)+0.5,cos(smp3)+1)
  ci.y=c(sin(smp1),sin(smp2)+sqrt(3)/2,sin(smp3))
  
  c.x.y=ci.x
  c.y.y=ci.y
  c.x.c <- ci.x*cos(2/3*pi)-ci.y*sin(2/3*pi)+1
  c.y.c <- ci.x*sin(2/3*pi)+ci.y*cos(2/3*pi)
  c.x.m <- ci.x*cos(4/3*pi)-ci.y*sin(4/3*pi)+0.5
  c.y.m <- ci.x*sin(4/3*pi)+ci.y*cos(4/3*pi)+sqrt(3)/2
  
  # draw the individual polygons
  polygon(x = scl*c.x.r +x0,y=scl*c.y.r + y0,col = 'red')
  polygon(x = scl*c.x.b +x0,y=scl*c.y.b + y0,col = 'blue')
  polygon(x = scl*c.x.g +x0,y=scl*c.y.g + y0,col = 'green')
  polygon(x = scl*c.x.y +x0,y=scl*c.y.y + y0,col = 'yellow')
  polygon(x = scl*c.x.m +x0,y=scl*c.y.m + y0,col = 'magenta')
  polygon(x = scl*c.x.c +x0,y=scl*c.y.c + y0,col = 'cyan')
  
  # put some labels
  text(x=x0 + scl*0.5,y=y0 + 2.3*scl,labels = 'Var 1')
  text(x=x0 + scl*2.5,y=y0 - 0.5*scl,labels = 'Var 2',srt=60)
  text(x=x0 - scl*1.5,y=y0 - 0.5*scl,labels = 'Var 3',srt=-60)
}
</pre>