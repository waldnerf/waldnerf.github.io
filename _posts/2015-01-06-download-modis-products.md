---
ID: 765
post_title: Download MODIS products
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/download-modis-products/
published: true
post_date: 2015-01-06 10:28:03
---
Tired of browsing through the MODIS catalogue? Here is the solution for you!
Providing a list of tiles, year, product and FTP site, this here code browse all the products and download the ones your interested in. Have fun!

 <pre lang='rsplus'>
library(rgdal)
library(RCurl)
setInternet2(use = TRUE)
options(download.file.method="auto")
#set dir
setwd("/dir/on/my/raptor/machine")
# location of the MODIS data:
MOD09GQ <- "http://e4ftl01.cr.usgs.gov/MOLT/MOD09GQ.005/"
product = "MOD09GQ"
yearList = c('2008')
tileList <- c('h18v04')

for(tile in tileList){
  for(year in yearList){
    # get the list of directories (thanks to Barry Rowlingson):
    items1 <- strsplit(getURL(MOD09GQ), "\n")[[1]]
    # get the directory names and create a new data frame:
    dates=data.frame(dirname=substr(items1[20:length(items1)],52,62))
    
    # get the list of *.hdf files:
    dates <- data.frame(dirname=grep(year,dates$dirname,value = TRUE))
    for (i in 1:NROW(dates)){
      # for each date per year
      getlist <- strsplit(getURL(paste(MOD09GQ, dates$dirname[i], sep="")), ">")[[1]]
      getlist=getlist[grep(product,getlist)]
      getlist=getlist[grep(".hdf<",getlist)]
      filenames=substr(getlist,1,nchar(getlist[1])-3)
      
      BLOCK <- grep(pattern=paste0("MOD09GQ.*.",tile,".*.hdf"),filenames,value = TRUE)
      
      # Download all blocks from the list to a local drive:
      download.file(paste(MOD09GQ,  dates$dirname[i], BLOCK,sep=""),destfile=file.path(getwd(),BLOCK), cacheOK=FALSE, )
    }
  }
}


</pre>