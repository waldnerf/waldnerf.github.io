---
ID: 902
post_title: >
  Share a legend between multiple plots
  using grid.arrange
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/share-a-legend-between-multiple-plots-using-grid-arrange/
published: true
post_date: 2015-08-12 15:11:08
---
Greetings, followeRs!

I wanted to share a really cool function to create a multiplot with a shared legend!
I was created by <a href="https://github.com/hadley">Hadley Wickham</a>, don't hesitate to go and check his other awesome functions. 

<pre lang='rsplus'>
library(ggplot2)
library(gridExtra)

grid_arrange_shared_legend <- function(...) {
    plots <- list(...)
    g <- ggplotGrob(plots[[1]] + theme(legend.position="bottom"))$grobs
    legend <- g[[which(sapply(g, function(x) x$name) == "guide-box")]]
    lheight <- sum(legend$height)
    grid.arrange(
        do.call(arrangeGrob, lapply(plots, function(x)
            x + theme(legend.position="none"))),
        legend,
        ncol = 1,
        heights = unit.c(unit(1, "npc") - lheight, lheight))
}

dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
p1 <- qplot(carat, price, data=dsamp, colour=clarity)
p2 <- qplot(cut, price, data=dsamp, colour=clarity)
p3 <- qplot(color, price, data=dsamp, colour=clarity)
p4 <- qplot(depth, price, data=dsamp, colour=clarity)
grid_arrange_shared_legend(p1, p2, p3, p4)

</pre>