---
ID: 332
post_title: Format data as Date using R
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/deal-with-date-using-r/
published: true
post_date: 2014-10-28 11:40:00
---
Yo GIS addict,

You can format data as <em>Date</em> object (e.g. The 29th January of 1947 at 15 hours 05 minutes 15 seconds) like this:

<pre lang="rsplus">
as.Date("19470129", format="%Y%m%d") 
as.Date("29/01/47", format="%d/%m/%y")  # will be "2047-01-29"
as.Date("29Jan1947", format="%d%b%Y")
as.Date("29-Jan-1947", format="%d-%b-%Y")
as.Date("29/Jan/1947", format="%d/%b/%Y")
as.Date("29 Jan 1947", format="%d %b %Y")
as.Date("1947-01-29 15:05:15", format="%Y-%m-%d %H:%M:%S")
</pre>

You have to specify the day in order to avoid malformed <em>Date</em>. If not, to get round this, consider using the following:

<pre lang="rsplus">
#Dummy data
df <- data.frame(period = c("Jan/1947", 
                            "Feb/1947",
                            "Mar/1947"))

#Add the first day of the month to each date
df$period2 <- as.Date(x=paste("1/",df$period, sep=""), format="%d/%b/%Y") 

> df
      period         period2
1   Jan/1947      1947-01-01
2   Feb/1947      1947-02-01
3   Mar/1947      1947-03-01
</pre>