---
ID: 150
post_title: >
  Plot shapefiles with continuous
  variables
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/plot-shapefiles-with-continuous-variables/
published: true
post_date: 2014-10-14 10:11:59
---
In today's post, let's have a look at the plotting functions for continuous variables in shapefiles. To do that we need four functions contained in three packages:
  - <strong>readOGR</strong> (rgdal): to read the shapefile
- <strong>fortify</strong> (rgdal): to convert the SpatialPolygonDataFrame to a data frame understandable by ggplot
- <strong>join</strong> (plyr): to join the attributes to the data frame
- <strong>ggplot</strong> (ggplot2): to display the data

The boring part is the conversion from polygon to a data frame that ggplot can handle. To facilitate that, the <strong>prepShp4plot</strong> function has been created. The hardest part becomes the choice of color for the legend!
 
<pre lang="rsplus"> 
prepShp4plot <- function(inShp){
    inShp$id <- as.numeric(1:NROW(inShp))
    inShp.fort <- fortify(inShp, region = "id")
    countryDf <- join(inShp.fort,inShp@data)
}


# Load the required packages
library(plyr)
library(rgdal)
library(ggplot2)
library(rworldmap)

# FOR CLARITY in this example, let's import a shapefile from the rworldmap package
inShp <- getMap(resolution="coarse")

# Load the shapefile of interest
#shpDir <- '/home/whiteguru/path2shp'
#setwd(shpDir)
#inShp <- readOGR(dsn='.','world_boundary')


# Use a small function that prepares your polygon shapefile to be displayed
countryDf <- prepShp4plot(inShp)


ggplot(data = countryDf, aes(x = long, y = lat, fill = as.numeric(POP_EST), group = group)) +
  geom_polygon(colour = "black") +
  coord_equal() +
  coord_map()+
  theme(panel.background = element_rect(fill='#EBF4FA', colour='black'))+
  scale_fill_gradientn('Human population\n',
                       limits=c(min(na.omit(countryDf$POP_EST)),max(na.omit(countryDf$POP_EST))),
                       colours=c("red","yellow","darkgreen"),
                       breaks=c(min(na.omit(countryDf$POP_EST)),
                       mean(na.omit(countryDf$POP_EST)),
                       max(na.omit(countryDf$POP_EST))),
                       labels = c('Very Small\n','Small\n','Large\n'))
</pre>

<center>
<a href="http://www.guru-gis.net/wp-content/uploads/2014/10/Rplot011.png"><img src="http://www.guru-gis.net/wp-content/uploads/2014/10/Rplot011.png" alt="Rplot01" width="700" height="400" class="alignnone size-full wp-image-156" /></a>
</center>