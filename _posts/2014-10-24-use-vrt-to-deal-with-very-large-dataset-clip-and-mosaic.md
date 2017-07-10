---
ID: 319
post_title: >
  Use VRT to deal with very large dataset
  clip and mosaic
author: Khan-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/use-vrt-to-deal-with-very-large-dataset-clip-and-mosaic/
published: true
post_date: 2014-10-24 14:59:30
---
Hi GIS planet, 

I have 4000 separeted geoTIFF images of 8000 by 8000 pixels and I want to mosaic and clip those images based on polygons from a shapefile (polygons are 20000 by 20000 pixels).
Here is the code I used:


<pre lang="rsplus">


## 1 Build a VRT

system(
  paste('gdalbuildvrt',
        '/path_to_images/LargeImage.vrt',
        '/path_to_images/*/*.tif')
)


## 2 Clip & Merge the files based on polygon delimations from a shapefile
zones <- readOGR('/path_to_images/Zones.shp','Zones')

for (i in 1:length(zones@polygons))
{
  # get the polygon upper left and down right of the polygones
  ulx<-zones@polygons[[i]]@Polygons[[1]]@coords[2,1]
  uly<-zones@polygons[[i]]@Polygons[[1]]@coords[2,2]
  lrx<-zones@polygons[[i]]@Polygons[[1]]@coords[4,1]
  lry<-zones@polygons[[i]]@Polygons[[1]]@coords[4,2]
  
  system(
    paste('gdal_merge.py',
          paste('-o /path_to_images/LargeImage_Zone_',toString(i),'.tif',sep=''),
          '-ul_lr' ,toString(ulx), toString(uly),toString(lrx), toString(lry),
          '/path_to_images/LargeImage.vrt'))
  system(
    paste('gdaladdo',
          paste('/path_to_images/LargeImage_Zone',toString(i),'.tif',sep=''),
          '2 4 8 16'))
}
</pre>