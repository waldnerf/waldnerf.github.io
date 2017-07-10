---
ID: 825
post_title: Lazy Raster Processing With Gdal Vrts
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/lazy-raster-processing-with-gdal-vrts/
published: true
post_date: 2015-01-28 10:04:54
---
Hi there, today an introduction to VRT, a magic tool, by Matthew T. Perry. Post from <a href="http://blog.perrygeo.net/2010/02/18/lazy-raster-processing-with-gdal-vrts/">here</a>.

Lazy Raster Processing With Gdal Vrts.
No, not lazy as in REST :-) … Lazy as in “Lazy evaluation”:

<ul>
    In computer programming, lazy evaluation is the technique of delaying a computation until the result is required.</ul>

Take an example raster processing workflow to go from a bunch of tiled, latlong, GeoTiff digital elevation models to a single shaded relief GeoTiff in projected space:

<ul>
    1) Merge the tiles together
    2) Reproject the merged DEM (using bilinear or cubic interpolation)
    3) Generate the hillshade from the merged DEM</ul>

Simple enough to do with GDAL tools on the command line. Here’s the typical, process-as-you-go implementation:

<pre lang='rsplus'>
gdal_merge.py -of GTiff -o srtm_merged.tif srtm_12_*.tif 
gdalwarp -t_srs epsg:3310 -r bilinear -of GTiff srtm_merged.tif srtm_merged_3310.tif 
gdaldem hillshade srtm_merged_3310.tif srtm_merged_3310_shade.tif -of GTiff 
</pre>

Alternately, we can simulate lazy evaluation by using GDAL Virtual Rasters (VRT) to perform the intermediate steps, only outputting the GeoTiff as the final step.

<pre lang='rsplus'>
gdalbuildvrt srtm_merged.vrt srtm_12_0*.tif
gdalwarp -t_srs epsg:3310 -r bilinear -of VRT srtm_merged.vrt srtm_merged_3310.vrt 
gdaldem hillshade srtm_merged_3310.vrt srtm_merged_3310_shade2.tif -of GTiff
</pre>

So what’s the advantage to doing it the VRT way? They both produce exactly the same output raster. Lets compare:

<center>
<a href="http://www.guru-gis.net/wp-content/uploads/2015/01/benchmark.png"><img src="http://www.guru-gis.net/wp-content/uploads/2015/01/benchmark.png" alt="benchmark" width="518" height="190" class="alignnone size-full wp-image-834" /></a>
</center>

The Lazy VRT method delays all the computationally-intensive processing until it is actually required. The intermediate files, instead of containing the raw raster output of the actual computation, are XML files which contain the instructions to get the desired output. This allows GDAL to do all the processing in one step (the final step #3). The total processing time is not significantly different between the two methods but in terms of the productivity of the GIS analyst, the VRT method is superior. Imagine working with datasets 1000x this size with many more steps - having to type the command, wait 2 hours, type the next, etc. would be a waste of human resources versus assembling the instructions into vrts then hitting the final processing step when you leave the office for a long weekend.

Additionaly, the VRT method produces only small intermediate xml files instead of having a potentially huge data management nightmare of shuffling around GB (or TB) of intermediate outputs! Plus those xml files serve as an excellent piece of metadata which describe the exact processing steps which you can refer to later or adapt to different datasets.

So next time you have a multi-step raster workflow, use the GDAL VRTs to your full advantage - you’ll save yourself time and disk space by being lazy.