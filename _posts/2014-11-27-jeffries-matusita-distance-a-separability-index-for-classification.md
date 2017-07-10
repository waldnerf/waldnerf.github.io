---
ID: 632
post_title: 'Jeffries-Matusita distance: a separability index for classification'
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/jeffries-matusita-distance-a-separability-index-for-classification/
published: true
post_date: 2014-11-27 11:42:30
---
The Bhattacharyya distance as a measure of separability has the disadvantage that it continues to grow even after the classes have become so well separated that any classification procedure could distinguish them perfectly. The Jeffries-Matusita distance measures separability of two classes on a more convenient scale [0-2] in terms of <em>B</em>:

<center>
<em>J=2(1-e^⁻B)</em>
</center>

Where <em>B</em> is the Bhattacharyya distance.

In R:
<pre lang="rsplus">
jm.distance <- function(Vector1, Vector2) {
  require(fpc)
  m1<-colMeans(as.matrix(Vector1))
  m2<-colMeans(as.matrix(Vector2))
  cov1<-cov(as.matrix(Vector1))
  cov2<-cov(as.matrix(Vector2))
  bh.distance <-bhattacharyya.dist(m1, m2, cov1, cov2)
  jm <- 2 * ( 1 - exp ( -bh.distance ) )
  return(jm)
}
</pre>