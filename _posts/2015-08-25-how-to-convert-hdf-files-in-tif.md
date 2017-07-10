---
ID: 905
post_title: How to convert hdf files in tif?
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/how-to-convert-hdf-files-in-tif/
published: true
post_date: 2015-08-25 14:39:37
---
Hi crazyGISfans,

Hdf format may be sometimes difficult to manage. We prefer working with geotif.
How do you do convert hdf in tif in R with gdal_translate?

<pre lang='rsplus'>
library(gdalUtils)
library(tools)

setwd("/guru-blard/")

files<-list.files(, pattern=".hdf$")
band<-1

for (file in files){
  gdal_translate(src_dataset=get_subdatasets(file)[band], dst_dataset=paste0(file_path_sans_ext(file),"_B", band,'.tif'))
}
</pre>

That's it.