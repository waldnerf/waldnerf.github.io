---
ID: 648
post_title: Open a .gdb in R without using ArcGIS
author: Khan-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/open-a-gdb-in-r-without-using-arcgis/
published: true
post_date: 2014-11-27 12:06:24
---
Hi GisWorld,

Since GDAL 1.11, a driver to read the ESRI geodatabase (.gdb) is available (<a href="http://www.gdal.org/drv_filegdb.html">http://www.gdal.org/drv_filegdb.html</a>).
It is thus possible to load the database in R:

<pre lang="rsplus">
 library('rgdal')
 myFeatureClass<-readOGR('/path_to_gdb/myGDB.gdb',layer='myFeatureClass')
</pre>