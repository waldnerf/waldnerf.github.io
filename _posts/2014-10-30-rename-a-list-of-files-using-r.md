---
ID: 349
post_title: Rename a list of files using R
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/rename-a-list-of-files-using-r/
published: true
post_date: 2014-10-30 11:53:56
---
<a href="http://www.guru-gis.net/list-of-a-files-with-specific-name-in-a-folder/" title="List of files with specific name in a folder">List the files</a> of your directory and use <strong>file.rename</strong>.

The example below shows how to change the name of a list of files "xxxxxxxx.tif", "yyyyyyyy.tif", ... in "MODIS_1.tif", "MODIS_2.tif", ...

<pre lang="rsplus">
setwd("/home/blackguru/")

files_list<-list.files(pattern="*.tif")
file.rename(files_list, paste0("MODIS_", 1:length(file_list), ".tif"))
</pre>