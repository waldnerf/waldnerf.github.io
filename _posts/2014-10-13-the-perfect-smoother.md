---
ID: 86
post_title: The Perfect Smoother
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/the-perfect-smoother/
published: true
post_date: 2014-10-13 18:20:08
---
<em>The well-known and popular Savitzky-Golay filter has several disadvantages. A very attractive alternative is a smoother based on penalized least squares, extending ideas presented by Whittaker 80 years ago. This smoother is extremely fast, gives continuous control over smoothness, interpolates automatically, and allows fast leave-one- out cross-validation. It can be programmed in a few lines of R code <a href="http://pubs.acs.org/doi/pdf/10.1021/ac034173t" title="A Perfect Smoother" target="_blank"> (Eilers, 2003)</a>. </em>

<pre lang="rsplus">
whitsmw <- function(y, lambda=10) {
  # Whittaker smoother with weights
  # Input:
  #   y:      data series, sampled at equal intervals
  #           (arbitrary values allowed when missing)
  #   lambda: smoothing parameter; large lambda gives smoother result
  #   d:      order of differences (default = 2)  TO BE MODIFIED IN THE FUNCTION
  # Output:
  #   z:      smoothed series
  #   cve:    RMS leave-one-out prediction error
  #   h:      diagonal of hat mat
  #   w:      weights (0/1 for missing/non-missing data)
  #
  # Remark: the computation of the hat diagonal for m > 100 is experimental;
  # with many missing observation it may fail.
  #
  # Paul Eilers, 2003
  
  # Smoothing
  m <- length(y)
  w <- rep(1, length(y))- as.numeric(is.na(y))
  y[is.na(y)]<-0
  E <- diag(m)#Matrix(, sparse = TRUE)
  W <- diag(w)#1Matrix(, sparse = TRUE)
  
  D = diff(E, d=2)
  P = chol(W+lambda * t(D) %*% D) #   Cholesky()
  z = solve(P,solve(t(P), w*y))
}
</pre>

<!--more-->