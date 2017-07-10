---
ID: 881
post_title: >
  Assemble png into a grid using
  ImageMagick and R
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/assemble-png-into-a-grid-using-imagemagick-using-r/
published: true
post_date: 2015-06-08 14:31:33
---
Holà GISpa,

Here is a R function that uses the montage function of <strong><a href="http://www.imagemagick.org/script/binary-releases.php">ImageBrick</a></strong> to assemble png in one grid. All the parameters are explained <a href="http://www.imagemagick.org/Usage/montage/">here</a>.

<pre lang='rsplus'>
pattern='CoolestPngEver_'
In<-list.files("/export/homes/gurublard/", full.names=T, pattern=pattern)
Out<-paste0(/export/homes/gurublard/", pattern,"all.png")
command<-paste0("montage -label '%f' -density 300 -tile 4x0 -geometry +5+50 -border 10 ", paste(In, collapse=" "), " ", Out)
system(command)
</pre>

<a href="http://www.guru-gis.net/wp-content/uploads/2015/06/ImageMagick.png"><img src="http://www.guru-gis.net/wp-content/uploads/2015/06/ImageMagick.png" alt="ImageMagick" width="844" height="845" class="alignnone size-full wp-image-888" /></a>