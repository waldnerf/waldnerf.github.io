---
ID: 36
post_title: Plot raster with continuous gradient
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/plot-raster-with-continuous-gradient/
published: true
post_date: 2014-10-13 15:27:41
---
When it comes to plotting raster, the gplot function in the rasterVis package combines rapidity with the beauty of ggplot2. Here is a small example on how to plot a continuous raster data defining the shades of the color scale. Enjoy!

<pre lang="rsplus">

library(raster) 
library(rasterVis)
## Create a matrix with random data & use image()
xy <- matrix(150*abs(rnorm(400)),20,20)
rast <- raster(xy)
# Give it lat/lon coords for 36-37°E, 3-2°S
extent(rast) <- c(36,37,-3,-2)
# ... and assign a projection
projection(rast) <- CRS("+proj=longlat +datum=WGS84")

p<-gplot(rast, maxpixels=500000)+ geom_tile(aes(fill = value)) +
  scale_fill_gradientn(colours=c("#FFF5EE",'#F5F5DC',"#3CB371","#008000","#FF8C00","red"),limits=c(0.00000001,500))+
  coord_equal()+ labs(title = paste('Test title'))+scale_x_continuous(expand = c(0, 0))+scale_y_continuous(expand = c(0, 0))
print(p)
</pre>
And here is the result!

<center><a href="http://www.guru-gis.net/wp-content/uploads/2014/10/Rplot1.png"><img src="http://www.guru-gis.net/wp-content/uploads/2014/10/Rplot1.png" alt="Rplot" width="660" height="383" class="alignnone size-full wp-image-48" /></a></center>