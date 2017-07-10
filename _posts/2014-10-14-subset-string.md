---
ID: 195
post_title: Subset string with gsub
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: http://www.guru-gis.net/subset-string/
published: true
post_date: 2014-10-14 16:35:07
---
Imagine that you have a list of file names and you want to extract a part of the character strings for a specific purpose. You can do it with the <strong>gsub</strong> function (among others).

Here is an example:

You have a list of files with this name structure: SPOT4_yearmonthday_NDVI.tif.

<pre lang="rsplus">
file.list<-c("SPOT4_20140512_NDVI.tif", 
             "SPOT4_20140610_NDVI.tif",
             "SPOT4_20140721_NDVI.tif")
</pre>

You want to extract the date in the middle of the file name. You can  use <strong>gsub</strong> like this:

<pre lang="rsplus">
file.date<-gsub(pattern='.*_(.*)_.*$','\\1',file.list ) 
#You will remove any characters .* that are not between the two underscores _(.*)_ 
# Substitute the entire string with the bit found inside the parentheses - "\\1"
</pre>

Other examples:

<pre lang="rsplus">
beginning<-gsub(pattern='(.*)_.*_.*$','\\1', file.list) 
[1] "SPOT4" "SPOT4" "SPOT4"

end<-gsub(pattern='.*_(.*).tif','\\1', file.list) 
[1] "NDVI" "NDVI" "NDVI"
</pre>

As a reminder, you can format the extracted data as <em>Date</em> object like this:

<pre lang="rsplus">
file.date<-as.Date(file.date, format="%Y%m%d") 
</pre>