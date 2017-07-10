---
ID: 783
post_title: Plot points with a google map background
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/plot-points-with-a-google-map-background/
published: true
post_date: 2015-01-13 09:50:54
---
Good Morning Followers!

Yesterday, I found a nice post <a href="blog.revolutionanalytics.com/2015/01/creating-a-custom-soil-attribute-plot-using-ggmap.html">here</a> by Joseph Rickert. I produces nice plots with points and a google map background. Try it and have fun!

<pre lang='rsplus'>
library(ggmap)
library(plyr)
library(gridExtra)
temp <- tempfile()
download.file("http://www.plantsciences.ucdavis.edu/plant/data.zip", temp)
connection <- unz(temp, "Data/Set3/Set3data.csv")
rice <- read.csv(connection)
names(rice) <- tolower(names(rice))
# Create a custom soil attribute plot
# @param df Data frame containing data for a field
# @param attribute Soil attribute
# @return Custom soil attribute plot
create_plot <- function(df, attribute) {
  map <- get_map(location = c(median(df$longitude), 
                              median(df$latitude)),
                 maptype = "satellite",
                 source = "google",
                 crop = FALSE,
                 zoom = 15)
  plot <- ggmap(map) + geom_point(aes_string(x = "longitude", 
                                             y = "latitude",
                                             color = attribute),
                                  size = 5,
                                  data = df)
  plot <- plot + ggtitle(paste("Farmer", df$farmer, "/ Field", df$field))
  plot <- plot + scale_color_gradient(low = "darkorange", high = "darkorchid4")
  return(plot)
}
ph_plot <- dlply(rice, "field", create_plot, attribute = "ph")
ph_plots <- do.call(arrangeGrob, ph_plot)
</pre>

<a href="http://www.guru-gis.net/wp-content/uploads/2015/01/6a010534b1db25970b01bb07d2c8c1970d-800wi.png"><img src="http://www.guru-gis.net/wp-content/uploads/2015/01/6a010534b1db25970b01bb07d2c8c1970d-800wi.png" alt="6a010534b1db25970b01bb07d2c8c1970d-800wi" width="800" height="674" class="alignnone size-full wp-image-784" /></a>