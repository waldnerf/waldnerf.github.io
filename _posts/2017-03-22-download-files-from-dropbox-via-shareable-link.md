---
ID: 999
post_title: >
  Download files from Dropbox via
  shareable link
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/download-files-from-dropbox-via-shareable-link/
published: true
post_date: 2017-03-22 22:25:38
---
Hello there!

I have a nice piece of code for today on how to download a file from a dropbox shareable link (I reckon it adapted slightly a code found <a href="http://thebiobucket.blogspot.be/2013/04/download-files-from-dropbox.html">here</a>). Here is how it works. Argument <strong>x</strong> is the document name, <strong>d</strong> the document key, and <strong>outfile</strong> is the desired filename and location.
 
<pre lang='rsplus'>
dl_from_dropbox <- function(x, key, outfile) {
  require(RCurl)
  bin <- getBinaryURL(paste0("https://dl.dropboxusercontent.com/s/", key, "/", x),
                      ssl.verifypeer = FALSE)
  con <- file(outfile, open = "wb")
  writeBin(bin, con)
  close(con)        
}

# Example:
dl_from_dropbox("GViewer_Embeds.txt", "06fqlz6gswj80nj", '/home/GViewer_Embeds.txt')
</pre>