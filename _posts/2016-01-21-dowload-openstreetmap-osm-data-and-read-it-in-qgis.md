---
ID: 931
post_title: >
  Dowload OpenStreetMap (OSM) data and
  read it in QGIS
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/dowload-openstreetmap-osm-data-and-read-it-in-qgis/
published: true
post_date: 2016-01-21 11:59:14
---
Happy New GIS,

Be sure to get the last version of GDAL (<a href="http://www.sarasafavi.com/installing-gdalogr-on-ubuntu.html">Ubuntu installation</a>) 

Go to <a href="http://download.geofabrik.de/index.html">Geofabrik</a>. 
Download the compressed <strong>.osm.pbf</strong> files corresponding to our area (Continent, Country).

Using <strong>ogr</strong> to convert the pbf file into a SQlite database which can be used directly in QGIS with <strong>Add SpatiaLite Layer</strong>.

<pre lang='rsplus'>
ogr2ogr -f "SQLite" -dsco SPATIALITE=YES -spat xmin ymin xmax ymax GuruBlard_Region.db OSM_continent.pbf
</pre>

where <code>xmin ymin xmax ymax</code>:
spatial query extents, in the SRS of the source layer(s) (or the one specified with -spat_srs). Only features whose geometry intersects the extents will be selected. The geometries will not be clipped unless -clipsrc is specified

For further information, visit this <a href="http://anitagraser.com/2014/05/31/a-guide-to-googlemaps-like-maps-with-osm-in-qgis/">post</a> of Anita Graser.