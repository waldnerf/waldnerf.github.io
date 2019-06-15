# https://twitter.com/dsquintana/status/993410511332134912?lang=en
#blogdown::install_hugo()
blogdown::build_site()
blogdown::serve_site()

#install.packages("remotes")
# see: https://github.com/petzi53/bib2academic/
#remotes::install_github("petzi53/bib2academic")
bib2academic::bib2acad("mybib_20190609.bib", copybib = TRUE, abstract = FALSE, overwrite = FALSE)
# If everything went smoothly make a copy of your static/files/citations/ and content/publication folder. Then copy your .bib files into static/files/citations/ and your .md files into content/publication.
