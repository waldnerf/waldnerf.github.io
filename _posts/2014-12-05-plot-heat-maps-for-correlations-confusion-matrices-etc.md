---
ID: 712
post_title: >
  Plot heat maps for correlations,
  confusion matrices etc.
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/plot-heat-maps-for-correlations-confusion-matrices-etc/
published: true
post_date: 2014-12-05 11:13:23
---
Hi folks!

Wanna present your table in a nice way? Have you ever thought of heat maps? 
Here is an example on how to use them:

<pre lang='rsplus'>
library(ggplot2)
library(plyr) # might be not needed here anyway it is a must-have package I think in R 
library(reshape2) # to "melt" your dataset
library (scales) # it has a "rescale" function which is needed in heatmaps 
library(RColorBrewer) # for convenience of heatmap colors, it reflects your mood sometimes
nba <- read.csv("http://datasets.flowingdata.com/ppg2008.csv")
head(nba)
nba$Name <- with(nba, reorder(Name, PTS))
nba.m <- melt(nba)
nba.m <- ddply(nba.m, .(variable), transform,rescale = rescale(value))
p <- ggplot(nba.m, aes(variable, Name)) + geom_tile(aes(fill = rescale),colour = "white") +  scale_fill_gradient2(low="#006400", mid="#f2f6c3",high="#cd0000",midpoint=0.5)
</pre>

The nba data.frame has the folowing structure:
<pre lang='rsplus'>
> head(nba)
            Name  G  MIN  PTS  FGM  FGA   FGP FTM FTA   FTP X3PM X3PA  X3PP ORB DRB TRB AST STL BLK  TO  PF
1   Dwyane Wade  79 38.6 30.2 10.8 22.0 0.491 7.5 9.8 0.765  1.1  3.5 0.317 1.1 3.9 5.0 7.5 2.2 1.3 3.4 2.3
2  LeBron James  81 37.7 28.4  9.7 19.9 0.489 7.3 9.4 0.780  1.6  4.7 0.344 1.3 6.3 7.6 7.2 1.7 1.1 3.0 1.7
3   Kobe Bryant  82 36.2 26.8  9.8 20.9 0.467 5.9 6.9 0.856  1.4  4.1 0.351 1.1 4.1 5.2 4.9 1.5 0.5 2.6 2.3
4 Dirk Nowitzki  81 37.7 25.9  9.6 20.0 0.479 6.0 6.7 0.890  0.8  2.1 0.359 1.1 7.3 8.4 2.4 0.8 0.8 1.9 2.2
5 Danny Granger  67 36.2 25.8  8.5 19.1 0.447 6.0 6.9 0.878  2.7  6.7 0.404 0.7 4.4 5.1 2.7 1.0 1.4 2.5 3.1
6  Kevin Durant  74 39.0 25.3  8.9 18.8 0.476 6.1 7.1 0.863  1.3  3.1 0.422 1.0 5.5 6.5 2.8 1.3 0.7 3.0 1.8
</pre>

And here is the output. Nice isn't it?
<center>
<a href="http://www.guru-gis.net/wp-content/uploads/2014/12/heat_map.png"><img src="http://www.guru-gis.net/wp-content/uploads/2014/12/heat_map.png" alt="heat_map" width="658" height="637" class="alignnone size-full wp-image-714" /></a>
</center>