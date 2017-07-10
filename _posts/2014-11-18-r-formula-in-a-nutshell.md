---
ID: 604
post_title: R formulas in a nutshell
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/r-formula-in-a-nutshell/
published: true
post_date: 2014-11-18 12:27:10
---
To foster the use of function, here is a piece of code that will teach you how to use R formula in your own functions.
R formulas have the following form: y~x1+x2+x3 or y~. if you want to consider every column in your data frame but the y.

The following function takes the formula and extract from the data frame the user-defined y and x and return them.

<pre lang="rsplus">
formula.fun <- function(formula, data=list(), ...){
  mf <- model.frame(formula=formula, data=data)
  x <- model.matrix(attr(mf, "terms"), data=mf)
  y <- model.response(mf)
  return(list(x=x,y=y))
}
</pre>

And here it is in action with the iris data set.

<pre lang="rsplus">
head(iris)
out <- formula.fun(Species ~.,data=iris)

out$x
out$y
</pre>