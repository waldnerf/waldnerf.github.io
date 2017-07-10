---
ID: 645
post_title: >
  Minimum function documentation with
  Roxygen2
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/minimum-function-documentation-with-roxygen2/
published: true
post_date: 2014-11-27 12:03:59
---
How to document your function in order to produce nice documentation without doing anything? 
Use roxygen! Thanks to a bunch of tags, it will automatically read your code and produce a documentation file. 

Here is a minimum example that should accompany all your functions from now on:

<pre lang='rsplus'>
#' Goal of you function
#' 
#' This function is awesome because it takes that and return this
#' 
#' @param x a n x p matrix of n observations and p predictors
#' @param y a vector of length n representing the response
#' @param t a tuning parameter
#' @return a vector of parameters 
#' @author White Guru
#' @details
#' This function is awesome and here is an comprehensive explanation of why it is so
#' @seealso \code{related packages}
#' @export
#' @importFrom list of the packages used (related packages)
</pre>

Ow and I almost forget to say that you need to install.packages('roxygen2') and build your code to produce the documentation.