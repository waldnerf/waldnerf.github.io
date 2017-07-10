---
ID: 847
post_title: >
  Merge shapefiles list using OGR
  (ogr2ogr)
author: Khan-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/merge-shapefiles-list-using-ogr-ogr2ogr/
published: true
post_date: 2015-02-20 11:48:21
---
Tired of using ArcGis to merge a huge number of shapefiles?

Here is a simple way to use ogr2ogr and merge shapefiles, so easy!

<pre lang='rsplus'>

list_files<-Sys.glob('/path_to_shapefiles/*.shp')

#create destination file (copy of the first file to merge)
merged_file<-'/path_to_my_results/merged_shapefile.shp'
system(paste(
  'ogr2ogr',
  merged_file,
  list_files[1]))

# update the merged_fille by appending all the shapefiles of the list list_files
for (i in seq(2,length(list_files))){
system(paste('ogr2ogr',
             '-update',
             '-append',
             merged_file,
             list_files[i]
             ))
}
</pre>