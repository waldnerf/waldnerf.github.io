---
ID: 410
post_title: >
  Import external segmentation in
  eCognition
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/import-external-segmentation-in-ecognition/
published: true
post_date: 2014-11-08 17:12:58
---
Holà GIS believer,

Currently, there is no option allowing to import a shapefile as a segmentation layer in eCognition.

To do so, you have to use a "trick". 

Import the shapefile (or the raster) as 'Thematic layer' (the field attribute has to be an "ID" different for each object). Use chessboard segmentation with the object size bigger than your image file and select your shapefile as thematic layer. 
Execute the process. 

That's it !

The algorithm will create identical objects than in your imported segmentation.