---
ID: 630
post_title: Interactive Plotting with Manipulate
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/interactive-plotting-with-manipulate/
published: true
post_date: 2014-11-26 14:58:32
---
Hi everyone, 

This is a quick post on a nice R library called 'manipulate' that enables the addition of interactive capabilities to standard R plots. This is accomplished by binding plot inputs to custom controls rather than static hard-coded values.

The manipulate function accepts a plotting expression and a set of controls (e.g. slider, picker, or checkbox) which are used to dynamically change values within the expression. When a value is changed using its corresponding control the expression is automatically re-executed and the plot is redrawn.

See more <a href="https://support.rstudio.com/hc/en-us/articles/200551906-Interactive-Plotting-with-Manipulate" title="manipulate" target="_blank">here </a>