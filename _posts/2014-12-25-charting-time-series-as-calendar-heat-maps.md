---
ID: 743
post_title: >
  Charting time-series as calendar heat
  maps
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/charting-time-series-as-calendar-heat-maps/
published: true
post_date: 2014-12-25 16:15:00
---
Merry GISmas dearest followers!
A couple of weeks ago, I made a post on <a href="http://www.guru-gis.net/plot-heat-maps-for-correlations-confusion-matrices-etc/">heatmaps</a>. Today I came across a nice <a href="http://stackoverflow.com/questions/2076370/most-underused-data-visualization">answer </a>on stackoverflow, it goes like this:

<pre lang='rsplus'>
# LOAD THE DATA
stock <- "MSFT"
start.date <- "2006-01-12"
end.date <- Sys.Date()
quote <- paste("http://ichart.finance.yahoo.com/table.csv?s=",
               stock, "&a=", substr(start.date,6,7),
               "&b=", substr(start.date, 9, 10),
               "&c=", substr(start.date, 1,4), 
               "&d=", substr(end.date,6,7),
               "&e=", substr(end.date, 9, 10),
               "&f=", substr(end.date, 1,4),
               "&g=d&ignore=.csv", sep="")    
stock.data <- read.csv(quote, as.is=TRUE)
stock.data <- transform(stock.data,
                        week = as.POSIXlt(Date)$yday %/% 7 + 1,
                        wday = as.POSIXlt(Date)$wday,
                        year = as.POSIXlt(Date)$year + 1900)
</pre>

The data has the following structure:
<pre lang='rsplus'>
> head(stock.data)
        Date  Open  High   Low Close   Volume Adj.Close week wday year
1 2014-12-24 48.64 48.64 48.08 48.14 11437800     48.14   52    3 2014
2 2014-12-23 48.37 48.80 48.13 48.45 23648100     48.45   51    2 2014
3 2014-12-22 47.78 48.12 47.71 47.98 26566000     47.98   51    1 2014
4 2014-12-19 47.63 48.10 47.17 47.66 64551200     47.66   51    5 2014
5 2014-12-18 46.58 47.52 46.34 47.52 40105600     47.52   51    4 2014
6 2014-12-17 45.05 45.95 44.90 45.74 34970900     45.74   51    3 2014
</pre>
And now this is how we chart it:

<pre lang='rsplus'>
library(ggplot2)
ggplot(stock.data, aes(week, wday, fill = Adj.Close)) + 
  geom_tile(colour = "white") + 
  scale_fill_gradientn('MSFT \n Adjusted Close',colours = c("#D61818","#FFAE63","#FFFFBD","#B5E384")) + 
  facet_wrap(~ year, ncol = 1)
</pre>

Here is how it looks like :-)

<center>
[caption id="attachment_744" align="alignnone" width="492"]<a href="http://www.guru-gis.net/wp-content/uploads/2014/12/Rplot02.png"><img src="http://www.guru-gis.net/wp-content/uploads/2014/12/Rplot02.png" alt=" " width="492" height="446" class="size-full wp-image-744" /></a> Calendar heatmap[/caption]
</center>