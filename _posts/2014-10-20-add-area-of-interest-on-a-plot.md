---
ID: 282
post_title: Add area of interest on a plot
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/add-area-of-interest-on-a-plot/
published: true
post_date: 2014-10-20 07:22:33
---

<pre lang="rsplus">
library(spatial.tools)
library(rasterVis)

inRst <- stack(brick(system.file("external/tahoe_highrez.tif", package="spatial.tools")))

inPlot<-gplot(inRst) + geom_tile(aes(fill = value)) +
  scale_fill_gradient('Cropland Proportion\n',low = "#ffffcc", high = "#347C17", trans='log', na.value = "grey50")+
  theme(legend.position = "bottom",panel.background = element_rect(fill='#EBF4FA', colour='black')) 



plotWithGlobe <- function(inPlot, inData,type="aoi",filename=''){
  library(ggplot2)
  library(maps)
  library(gridExtra)
  
  if(type=='aoi'){
    # This should get the corner points for the box, picking min and max of
    # lat and long
    if('Raster'%in% is(inData)){
      ext <- extent(inData)
      dfext <- data.frame(long = c(ext@xmin, ext@xmax, ext@xmax, ext@xmin,ext@xmin),
                          lat  = c(ext@ymin,ext@ymin, ext@ymax,ext@ymax,ext@ymax),group=1)
    } else {
      dfext <- data.frame(long = c(min(inData$x), max(inData$x), max(inData$x), min(inData$x),min(inData$x)),
                          lat  = c(min(inData$y),min(inData$y), max(inData$y),max(inData$y),max(inData$y)),group=1)
    }
  } else if(type == 'point'){
      if('Raster'%in% is(inData)){
        ext <- extent(inData)
        dfext <- data.frame(long = mean(c(ext@xmin, ext@xmax)),
                            lat  = mean(c(ext@ymin, ext@ymax)),group=1)
      } else {
        dfext <- data.frame(long = mean(c(min(inData$x), max(inData$x))),
                            lat  = mean(c(min(inData$y), max(inData$y))), group=1)
      }
  } else {
    print('Wrong type of interest')
    break
  }
  # Now plot the Area of interest onto the Globe
  world <- map_data("world")
  ##  et puis la fonction (que j'ai pris du site de ggplot)
  geoloc<-ggplot()
  geoloc<- geoloc+ geom_polygon( data=world, aes(x=long, y=lat, group = group),colour="white", fill="#BDBDBD" ) +
    geom_path(size=0.5)
  if(type=='aoi'){
    geoloc <- geoloc +  geom_polygon(data=dfext,aes(x=long, y=lat),fill=NA,colour="red",size=3) 
  } else if(type=='point'){
    geoloc <- geoloc + geom_point(data=dfext,aes(x=long, y=lat),fill=NA,colour="red",size=5) 
  }
  geoloc <- geoloc + 
    scale_y_continuous(breaks=(-2:2) * 30) +
    scale_x_continuous(breaks=(-4:4) * 45) +
    theme_bw(base_size = 15) +
    coord_map("ortho", orientation=c(dfext$lat[1], dfext$long[1], 0)) +
    theme(axis.text.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          plot.background = element_rect( fill = 'transparent',colour = 'transparent'),
          panel.background = element_rect(fill='#EBF4FA', colour='black'),strip.background=element_rect( colour='black'))
  print(geoloc)
  
  inPlot <- inPlot +
            theme(legend.position = "bottom", legend.text=element_text(size=12, face='bold'), 
            legend.title=element_text(size=12, face='bold'), legend.key = element_blank() ,
            axis.ticks = element_line(size = 1)) +labs(x = '', y = '')+
            scale_x_continuous(expand = c(0, 0))+scale_y_continuous(expand = c(0, 0))

  if(grep('png$',basename(filename))){
    png(filename)
    grid.newpage()
    vpb_ <- viewport(width = 1, height = 1, x = 0.5, y = 0.5)  # the larger map
    vpa_ <- viewport(width = 0.4, height = 0.4, x = 0.8, y = 0.8)  # the inset in upper right
    print(inPlot, vp = vpb_)
    print(geoloc, vp = vpa_)
    dev.off()
  } else if (grep('pdf$',basename(filename))){
    pdf(filename)
    grid.newpage()
    vpb_ <- viewport(width = 1, height = 1, x = 0.5, y = 0.5)  # the larger map
    vpa_ <- viewport(width = 0.4, height = 0.4, x = 0.8, y = 0.8)  # the inset in upper right
    print(inPlot, vp = vpb_)
    print(geoloc, vp = vpa_)
    dev.off()
  }
}

plotWithGlobe(inPlot, inData=inRst,type="point",filename='my_plot_aoi.png')

</pre>