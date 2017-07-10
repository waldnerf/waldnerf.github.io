---
ID: 957
post_title: >
  Efficient manuscript revision with
  latexdiff
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/efficient-manuscript-revision-with-latexdiff/
published: true
post_date: 2016-03-10 11:31:28
---
Hi there, 

Here is a nice tip to highlight the revisions in your manuscripts before resubmitting to your favorite journals: use latexdiff!

<code>latexdiff --type=CTRADITIONAL old_shitty_manuscript.tex new_shiny_manuscript.tex > diff.tex</code>

You can then easily customize how differences appear in your pdf by changing the commands in the preamble. 
Here are my settings:
<code>
\providecommand{\DIFadd}[1]{{\protect\color{blue}  #1}} %DIF PREAMBLE
\providecommand{\DIFdel}[1]{} %DIF PREAMBLE
</code>

New text appears in blue and old text is simply removed.