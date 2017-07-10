---
ID: 940
post_title: 'Styling shapefiles for QGIS: creating symbology in R'
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/styling-shapefiles-for-qgis-creating-symbology-in-r/
published: true
post_date: 2016-01-22 12:01:29
---
Hello world!

Today, I'd like to share with y'all a function that I wrote to save symbology associated with a shapefile of points in R. 
All you need is you shapefile in which you should have three columns:
1. <strong>col</strong>: indicating the color you want to associate with to your class in hex values (see the super <a href="http://www.color-hex.com/">http://www.color-hex.com/</a> website.).
2. <strong>label</strong>: the label of your class
3. <strong>value</strong>: the numeric value of your label

Enjoy!


Here is the function (you can also find it on my shiny <a href="https://github.com/waldnerf/R/blob/master/writeQML.R">GITHUB</a>). You can also simply type in source_url("https://rawgit.com/waldnerf/R/master/writeQML.R") (! requires the devtools package).

<pre lang='rsplus'>
writeQML <- function(inShp, col, label, value, filename){
  require(RColorBrewer)
  require(XML)
  inNames <- names(inShp)
  names(inShp)[which(names(inShp)==value)] <- "Value"
  names(inShp)[which(names(inShp)==col)] <- "v"
  names(inShp)[which(names(inShp)==label)] <- "Label"
  
  inShp$v <- unlist(lapply(as.character(inShp$v),function(x) paste(c(col2rgb(x),'255'),collapse = ',')))
  inShp$Label <- as.character(inShp$Label)
  
  inShp <- inShp[-which(duplicated(inShp@data[,c('Value','v','Label')])),]
  
  # set alpha
  alpha = 1
  
  base = newXMLNode("qgis")
  addAttributes(base,version="2.8.1-Wien", minimumScale="0", maximumScale="1e+08", simplifyDrawingHints="0", minLabelScale="0", maxLabelScale="1e+08",simplifyDrawingTol="1" ,simplifyMaxScale="1", hasScaleBasedVisibilityFlag="0", simplifyLocal="1", scaleBasedLabelVisibilityFlag="0")
  trans <- newXMLNode("transparencyLevelInt", 255)
  rend <- newXMLNode("renderer-v2", attrs = c(attr=value,symbollevels="0",type="categorizedSymbol"))
  
  # sort the categories
  categories <- newXMLNode("categories")
  category <- lapply(seq_along(inShp$Value),function(x){newXMLNode("category", attrs = c(symbol = as.character(x-1), value = inShp$Value[x], label = inShp$Label[x]))
  })
  addChildren(categories,category)
  
  # sort the symbols
  symbols <- newXMLNode("symbols")
  symbol <- lapply(seq_along(inShp$Value),function(x){dum.sym <- newXMLNode("symbol", attrs = c(outputUnit="MM",alpha=alpha,type="marker",name=as.character(x-1)))
  layer <- newXMLNode("layer", attrs =c(pass="0",class="SimpleMarker",locked="0"))
  prop <- newXMLNode("prop", attrs =c(k="color",v= inShp$v[x]))
  addChildren(layer, prop)
  addChildren(dum.sym, layer)
  }) 
  addChildren(symbols, symbol)
  
  # add categories and symbols to rend
  addChildren(rend, list(categories, symbols))
  addChildren(base, list(trans, rend))
  
  # save to qml-file
  writeLines(saveXML(base, prefix = "<!DOCTYPE qgis >"), filename)
}
</pre>

And a self-sufficient example. 

<pre lang='rsplus'>
# Prepare the shapefile
inDf <- structure(list(x = c(25.582125, 25.880375, 24.955375, 26.066375, 25.409375, 25.902125),
                       y = c(-26.147625, -26.202625, -26.166125, -26.117625, -26.035875, -26.046375), 
                       Class = c(1L, 2L, 3L, 10L, 10L, 10L),
                       colT = c("#ffa500", "#aaeeff", "#a8c093", "#4584dc","#4584dc", "#4584dc"), 
                       attT = c("Stuff", "Other stuff", "Thing","Nice thing", "Nice thing", "Nice thing")), 
                       .Names = c("x", "y", "Class", "colT", "attT"),
                       row.names = c(NA, 6L), class = "data.frame")

spat.df <- SpatialPointsDataFrame(inDf[,c('x','y')], inDf)
projection(spat.df) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
shapefile(spat.df, filename='/to/your/path/example.shp',overwrite=T)
filename <- "/to/your/path/example.qml"

writeQML(spat.df, "colT", 'attT', 'Class', filename)
</pre>