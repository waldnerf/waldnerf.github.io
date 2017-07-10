---
ID: 136
post_title: Bash OTB function using R
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/bash-otb-function-using-r/
published: true
post_date: 2014-10-14 09:10:07
---
This example demonstrates how to bash the function <a href="http://orfeo-toolbox.org/Applications/BandMath.html" title="BandMath" target="_blank"><strong>BandMath</strong> </a>from OTB to compute NDVI of a list of SPOT4 images. The OTB functions can directly be used in the terminal so we will have to call it with the <a href="https://stat.ethz.ch/R-manual/R-devel/library/base/html/system.html" title="system" target="_blank"><strong>system</strong></a> function.

List raster files in the directory. (See the post <a href="http://www.guru-gis.net/?p=109" title="List of files with specific name in a folder">List of files with specific name in a folder</a>).

<pre lang="rsplus">
directory<-"/home/BalckGuru/GIS/"
filename<-list.files(directory, pattern="^SPOT4.*.tif$")
</pre>

For each raster files, apply the  <a href="http://orfeo-toolbox.org/Applications/BandMath.html" title="BandMath" target="_blank"><strong>otbcli_BandMath</strong></a> function with defined parameters by calling the terminal with <a href="https://stat.ethz.ch/R-manual/R-devel/library/base/html/system.html" title="system" target="_blank"><strong>system</strong></a> function. You can paste the <em>command</em> in one code line but for clarity reason, I prefer to split the different parameters on different lines. 

<pre lang="rsplus">
for (i in filename){
  
  path.in<-paste('"', directory, "/", i, '"', sep="")
  path.out<-paste('"',directory, "/NDVI_", i,'"', sep="")
  
  command<-'otbcli_BandMath'
  command<-paste(command, '-il', path.in)
  command<-paste(command, '-out', path.out)
  command<-paste(command, '-ram 1024')
  command<-paste(command, '-exp "(im1b3-im1b2)/(im1b3+im1b2)"')
    
  system(command)
}
</pre>