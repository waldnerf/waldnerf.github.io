---
ID: 858
post_title: >
  List filenames in a directory that are
  different from a specific pattern
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/list-filenames-in-a-directory-that-are-different-from-a-specific-pattern/
published: true
post_date: 2015-03-04 13:54:35
---
Dear followers,

Have you already need to list filenames in a directory that are different from a specific pattern ?

Just let the MaGIS happen  with the <strong>list.diff</strong> function !

<pre lang='rsplus'>
list.diff<-function(dir, pattern){
  filename.all<-list.files(dir)
  filename.diff<-list.files(dir, pattern)
  filename<-setdiff(filename.all,filename.diff)
  return(filename)
}
</pre>