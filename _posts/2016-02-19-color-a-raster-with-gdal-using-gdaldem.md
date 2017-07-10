---
ID: 950
post_title: Color a raster with gdal using gdaldem
author: Khan-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/color-a-raster-with-gdal-using-gdaldem/
published: true
post_date: 2016-02-19 17:06:51
---
Hi Gigis, 
Have you never look for a simple way to color a raster without manualy modifying the symbology or use a python/r script to build a RAT? 
Here is the solution for lazy gis people like me ;-)
My example is a raster Geotif with 0 for land, 1 for water and 255 for no data. Most of the time, when you open it in a GIS, you have black overview because the contrast is adjusted on the 255 value. Here is how to proceed:

1/ Write a simple text file colortable.txt such as:
    0 white
    1 blue
    255 grey
2/gdaldem color-relief -of VRT sourcefile.tif colortable.txt out.vrt destfile.tif

3/ Just open the VRT, and the magic is there!

Khan-Guru, the Raster Magician