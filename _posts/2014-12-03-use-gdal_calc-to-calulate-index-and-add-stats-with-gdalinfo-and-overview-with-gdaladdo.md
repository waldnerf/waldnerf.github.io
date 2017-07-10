---
ID: 686
post_title: 'Use gdal_calc to calculate index (NDVI, NDWI, &#8230;) , add stats with gdalinfo and overview with gdaladdo'
author: Khan-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/use-gdal_calc-to-calulate-index-and-add-stats-with-gdalinfo-and-overview-with-gdaladdo/
published: true
post_date: 2014-12-03 12:31:25
---
His GISguys!

Here is a simple example of how to use the very fast multi-thred gdal_calc to get NDWI with stats, histogram and overviews. 


<pre lang='rsplus'>
file='my_input_file.tif'
outfile='my_output_file.tif'

  system(
    paste('gdal_calc.py',
          '-A',file,
          '--A_band=2',
          '-B',file,
          '--B_band=4',
          paste(' --outfile=', outpufile,sep=''),
          paste(' --calc=','\"','(A.astype(float)-B)/(A.astype(float)+B)','\"',sep=''),
          paste('--type=','\'','Float32','\'',sep=''),
          paste('--co=','\"','COMPRESS=LZW','\"',sep='')))
  
  system(paste('gdalinfo -hist -stats',outpufile))
  
  system(
    paste('gdaladdo',
          outpufile,
          '2 4 8 16')

</pre>

Here is another version with byte file as output (values ranging from 0 to 255, faster and smaller files):

<pre lang='rsplus'>
file='my_input_file.tif'
outfile='my_output_file.tif'

  system(
    paste('gdal_calc.py',
          '-A',file,
          '--A_band=2',
          '-B',file,
          '--B_band=4',
          paste(' --outfile=', outpufile,sep=''),
          paste(' --calc=','\"','((((A.astype(float)-B)/(A.astype(float)+B))+1)*128)','\"',sep=''),
          paste('--type=','\'','Byte','\'',sep=''),
          paste('--co=','\"','COMPRESS=LZW','\"',sep='')))
  
  system(paste('gdalinfo -hist -stats',outpufile))
  
  system(
    paste('gdaladdo',
          outpufile,
          '2 4 8 16')
</pre>