---
ID: 109
post_title: >
  List files with specific name in a
  folder
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/list-of-a-files-with-specific-name-in-a-folder/
published: true
post_date: 2014-10-13 19:03:02
---
The function  is <a href="https://stat.ethz.ch/R-manual/R-devel/library/base/html/list.files.html" title="list.files" target="_blank"><strong>list.files</strong></a>. The pattern argument has to be filled with the <a href="http://astrostatistics.psu.edu/su07/R/html/base/html/regex.html" title="pattern rules">specif rules</a> to find your files. In the example below, we are looking for files with names starting with "SPOT" (^ symbol) and finishing with "tif" ($ symbol) regardless of the letters between (.* symbol). 

<pre lang="rsplus">
directory<-("/home/GuruBlard/GIS/")
file_list<-as.list(list.files(directory, pattern="^SPOT.*tif$"))
</pre>

Another example below, we are looking for files with names  with "MS" in the middle (.*MS.* symbol) and finishing with "tif" ($ symbol).

<pre lang="rsplus">
directory<-("/home/GuruBlard/GIS/")
file_list<-as.list(list.files(directory, pattern='.*MS.*.tif$'))
</pre>

List objects allow to use the <a href="https://stat.ethz.ch/R-manual/R-devel/library/base/html/lapply.html" title="lapply" target="_blank"><strong>lapply</strong></a> function that avoid using loops which can lead to a fuzzy code.
Example reading raster files:

 <pre lang="rsplus">
raster_list<-lapply(file_list, raster)
</pre>