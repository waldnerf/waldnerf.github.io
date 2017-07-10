---
ID: 663
post_title: >
  How to randomly split a data frame or a
  vector into a training and test dataset
  ?
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/how-to-randomly-split-a-data-frame-into-a-training-and-a-test-dataset/
published: true
post_date: 2014-11-27 15:58:14
---
GIS là,

Here it is the function to do that. Fix the <em>seed</em> if you want to generate the exact same sample several time.
<em>prop</em> allows to define the proportion of the total data that will be sample for the training set.

<pre lang="rsplus">
#' Splitdf splits a dataframe into a training sample and test sample with a given proportion
#' 
#' This function takes a data frame and according to predefined proportion "prop" it will return a training and a test sample
#' 
#' @param input a n x p dataframe of n observations and p variables or a vector
#' @param seed the seed to be set in order to ensure reproductability of the split
#' @param prop the proportion of the training sample [0-1]
#' @return a list with two slots: trainset and testset
#' @author BlackGuru
#' @details
#' This function takes a data frame or a vector and according to predefined proportion "prop" it will return a training and a test sample. "prop" corresponds to the proportion of the training sample.
#' @export

splitdf <- function(input, prop=0.5, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  if (is.data.frame(input)){
    index <- 1:nrow(input)
    trainindex <- sample(index, trunc(length(index)*prop))
    trainset <- input[trainindex, ]
    testset <- input[-trainindex, ]
  }else if (is.vector(input)){
    index<-1:length(input)  
    trainindex <- sample(index, trunc(length(index)*prop))
    trainset <- input[trainindex]
    testset <- input[-trainindex]
  }else{
    print("Input must be a dataframe or a vector")
  }
  list(trainset=trainset,testset=testset)
}

</pre>