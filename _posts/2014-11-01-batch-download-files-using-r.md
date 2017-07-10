---
ID: 393
post_title: Batch download files using R
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/batch-download-files-using-r/
published: true
post_date: 2014-11-01 15:01:12
---
Hello GIS world !

Here are the steps to batch <strong>download.files</strong> function in R. The example below shows how to download NDVI gimms data from ecocast.arc.nasa.gov website.

<pre lang="rsplus">
setwd("/homes/blackguru/gimms/")

library(XML)
url<-c("http://ecocast.arc.nasa.gov/data/pub/gimms/3g/2010s_new/")
doc<-htmlParse(url)
#get <a> nodes.
Anodes<-getNodeSet(doc,"//a")
#Select the files of interest 
files<-grep("*VI3g",sapply(Anodes, function(Anode) xmlGetAttr(Anode,"href")),value=TRUE)
#make the full url
urls<-paste(url,files,sep="")

#Download each file.
mapply(function(x,y) download.file(x,y),urls,files)

# or faster but ressource 'intensive', download each file in parallel
require(parallel)
cl <- makeCluster(detectCores())
clusterMap(cl, download.file, url = urls, destfile = files, 
           .scheduling = 'dynamic')
# 'dynamic' scheduling means that each core won't have to wait for others to finish before starting 
#  its next download
</pre>

Another example with MODIS data and files in subfolders.

<pre lang="rsplus">
setwd("homes/blackguru/MODIS/")

library(XML)
url<-c("http://e4ftl01.cr.usgs.gov/MOLT/MOD11C3.006/")
doc<-htmlParse(url)
#get <a> nodes.
Anodes<-getNodeSet(doc,"//a")

files<-grep("2",sapply(Anodes, function(Anode) xmlGetAttr(Anode,"href")),value=TRUE)
urls<-paste(url,files,sep="")

doc<-lapply(urls, function(x){htmlParse(x)})
Anodes<-lapply(doc, function(x){getNodeSet(x,"//a")})
files<-lapply(Anodes, function(x){grep(".hdf$",sapply(x, function(Anode) xmlGetAttr(Anode,"href")),value=TRUE)})
urls<-paste(urls,files,sep="")

require(parallel)
cl <- makeCluster(detectCores())
clusterMap(cl, download.file, url = urls, destfile = files, 
           .scheduling = 'dynamic')
</pre>