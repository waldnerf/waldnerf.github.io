---
ID: 978
post_title: Load googlesheet data in R
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/load-googlesheet-data-in-r/
published: true
post_date: 2016-05-15 12:39:20
---
Dear R-addict, 

At the era of cloud-based computing, functions such as read.csv, read.xls or even fread are really old-fashioned. 
Here is a chunk of code that will allow you to load data from a googlesheet:

<pre lang='rsplus'>

install.packages("gsheet")
library(gsheet)
# Download a sheet

# Download a sheet
url <- 'https://docs.google.com/spreadsheets/d/1XBs7p44-djCPmN4TnPEgboUVAdB2mChbAlCjqnVOyQ0'
a <- gsheet2tbl(url)
</pre>