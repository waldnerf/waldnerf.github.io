---
ID: 755
post_title: Plot 3D with plotly
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/plot-3d-with-plotly/
published: true
post_date: 2015-01-05 16:08:08
---
Happy New Gis !

<strong>Plotly</strong> is a package that easily allows to get interactive, publication-quality plots in your web browser. There are many different plots possible, explore the gallery <a href="https://plot.ly/feed/">here</a> to have an idea.

<iframe width="800" height="600" frameborder="0" seamless="seamless" scrolling="no" src="https://plot.ly/~damien.jacques1989/100.embed?width=800&height=600"></iframe>

<pre lang='rsplus'>
# You can reproduce this figure in R with the following code!

# Learn about API authentication here: plot.ly/r/getting-started


#install packages
install.packages("devtools")
library("devtools")

install_github("ropensci/plotly")

#upgrade plotly
#devtools::install_github("ropensci/plotly")

#Define data
x <- y <- seq(-5, 5, len = 200)
X <- expand.grid(x = x, y = y)
X <- transform(X, z = dnorm(x, -2.5)*dnorm(y) - dnorm(x, 2.5)*dnorm(y))
z <- matrix(X$z, nrow = 200)

#Plot
library(plotly)

# Find your api_key here: plot.ly/settings/api
py <- plotly(username='username', key='password')
data <- list(
  list(
    z = z, 
    x = x, 
    y = y, 
    type = "surface"
  )
)
layout <- list(
  scene = list(
    xaxis = list(
      title="x",
      gridcolor = "rgb(255, 255, 255)", 
      zerolinecolor = "rgb(255, 255, 255)", 
      showbackground = TRUE, 
      backgroundcolor = "rgb(204, 204, 204)"
    ), 
    yaxis = list(
      title="y",
      gridcolor = "rgb(255, 255, 255)", 
      zerolinecolor = "rgb(255, 255, 255)", 
      showbackground = TRUE, 
      backgroundcolor = "rgb(204, 204, 204)"
    ), 
    zaxis = list(
      title="z",
      gridcolor = "rgb(255, 255, 255)", 
      zerolinecolor = "rgb(255, 255, 255)", 
      showbackground = TRUE, 
      backgroundcolor = "rgb(204, 204, 204)"
    )
  )
)
response <- py$plotly(data, kwargs=list(layout=layout))
url <- response$url
</pre>