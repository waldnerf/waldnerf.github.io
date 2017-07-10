---
ID: 4
post_title: Useful R libraries
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: http://www.guru-gis.net/test-r-code/
published: true
post_date: 2014-10-11 00:55:30
---
Here is a list of useful R libraries for GIS analysis.

<span style="font-size: x-large;"><strong>Data handling</strong></span>

Provides bindings to Frank Warmerdam's Geospatial Data Abstraction Library (GDAL).
<pre lang="rsplus">library(rgdal)</pre>
Reading, writing, manipulating, analyzing and modeling of gridded spatial data.
Set of tools for manipulating and reading geographic data, in particular ESRI shapefiles.
<pre lang="rsplus">library(maptools)</pre>
Reading, writing, manipulating, analyzing and modeling of gridded spatial data. The package implements basic and high-level functions. Processing of very large files is supported.
<pre lang="rsplus">library(raster)</pre>
<strong>Classification</strong>

<!--more-->

Among different statistical function, the useful k-means clustering function is available in this package.
<pre lang="rsplus">library(stats)</pre>
Classification and regression based on a forest of trees using random inputs.
<pre lang="rsplus">library(RandomForest)</pre>
<strong>Figure</strong>

An implementation of the grammar of graphics in R. It combines the advantages of both base and lattice graphics.
<pre lang="rsplus">library(ggplot2)</pre>
The rasterVis package complements raster library providing a set of methods for enhanced visualization and interaction.
<pre lang="rsplus">library(rasterVis)</pre>
<strong>list</strong>
<pre lang="rsplus">library(SDMTools)</pre>
<pre lang="rsplus">library(rgl)</pre>
<pre lang="rsplus">library(foreign)</pre>
<pre lang="rsplus">library(nortest)</pre>
<pre lang="rsplus">library(Hmisc)</pre>
<pre lang="rsplus">library(plyr)</pre>
<pre lang="rsplus">library(rgeos)</pre>
<pre lang="rsplus">library(adegenet)</pre>
<pre lang="rsplus">library(cluster)</pre>
<pre lang="rsplus">library(spdep)</pre>
<pre lang="rsplus">library(foreign)</pre>




<strong>To install all the package at once:
<pre lang="rsplus">
list.of.packages <- c("rgdal", "maptools", "raster", "stats", "RandomForest", "ggplot2", "rasterVis", "SDMTools", "rgl", "foreign", "nortest", "Hmisc", "plyr", "rgeos", "adegenet", "cluster", "spdep", "foreign")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
</pre>