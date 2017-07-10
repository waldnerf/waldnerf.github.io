---
ID: 731
post_title: Copy to clipboard from R on Ubuntu
author: Guru-Blard
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/copy-to-clipboard-from-r-on-ubunutu/
published: true
post_date: 2014-12-16 11:37:31
---
Hi young padaGIS,

Install xclip: 
<pre>
sudo apt-get install xclip
</pre>

Then use this function:
<pre lang='rsplus'>
#' @title Copy an object in the clipboard
#' 
#' @description Copy an object in the clipboard}
#' 
#' @param sep The object to copy.
#' @param sep A character to be used as separator for each column of the object
#' @param row.names  Copy row names (default is FALSE)
#' @param col.names Copy column names (default is TRUE)
#' @return copy the object as character in the clipboard
#' @author freecube source:http://stackoverflow.com/questions/10959521/how-to-write-to-clipboard-on-ubuntu-linux-in-r

clipboard <- function(x, sep="\t", row.names=FALSE, col.names=TRUE){
     con <- pipe("xclip -selection clipboard -i", open="w")
     write.table(x, con, sep=sep, row.names=row.names, col.names=col.names)
     close(con)
}
</pre>


Example:
<pre lang='rsplus'>
vec <- c(1,2,3,4)

clipboard(vec)
clipboard(vec, ",", col.names=FALSE)
clipboard(vec, " ", row.names=TRUE)
</pre>