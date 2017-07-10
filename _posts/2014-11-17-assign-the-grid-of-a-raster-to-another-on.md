---
ID: 506
post_title: Assign the grid of a raster to another
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/assign-the-grid-of-a-raster-to-another-on/
published: true
post_date: 2014-11-17 17:26:27
---
Howdy Guru-GISers!

Here is a very useful piece of code to use whenever you want to assign the grid of a raster to another data set. It is written in python and can be called from the command line or from R using system().
It takes three arguments:

inRst: the input file you want to assign a new grid to
targetRst: the raster file you want to copy the grid from
outRst: your output file

ENJOY!



<pre lang="python">
def getBoundingBox(inRst):
    import gdal
    ds = gdal.Open(inRst, 0)
    if ds is None:
        print 'Could not open ' + inRst
        sys.exit(1)
    
    cols = ds.RasterXSize
    rows = ds.RasterYSize
    geotransform = ds.GetGeoTransform()
    
    xmin = geotransform[0]
    ymax = geotransform[3]
    
    xres  = geotransform[1]
    yres = geotransform[5]
    
    xmax = xmin+cols*xres
    ymin = ymax+rows*yres
    
    return xmin, ymin, xmax, ymax, xres, yres 

def resample2grid(inRst, targetRst, outRst):
    
    import os
    import osr, gdal
    
    # Get target srs
    gdal.AllRegister()
    Ds = gdal.Open(targetRst,gdal.GA_ReadOnly)
    projWKT = Ds.GetProjection()
    
    srs = osr.SpatialReference()
    srs.ImportFromWkt(projWKT)                  
    target_srs = srs.ExportToProj4()


    # Get target extent and resotution
    [xmin, ymin, xmax, ymax, xres, yres] = getBoundingBox(targetRst)

    warp = "gdalwarp -t_srs '%s' -te %s %s %s %s -tr %s %s -r average  -overwrite -co 'COMPRESS=LZW' -co 'TILED=YES' %s %s"%(target_srs,xmin, ymin, xmax, ymax, xres, abs(yres), inRst, outRst )
    os.system(warp)
    return('done')

if __name__ == '__main__':
    import sys
    inRst     = sys.argv[0]
    targetRst = sys.argv[1]
    outRst    = sys.argv[3]
    resample2grid(inRst, targetRst, outRst)

</pre>


R version by Guru-Blard:
<!--more-->
<pre lang="rsplus">
getBoundingBox<-function(inRst){
  require(raster)
  r<-raster(inRst)
  ext<-extent(r)
  ext<-paste(ext[1], ext[3], ext[2], ext[4])
  res<-paste(res(r)[1], res(r)[2])
  result<-list(ext=ext, res=res)
  return (result)
}

resample2grid<-function(inRst, targetRst, outRst, ram=2000, method="cubic"){
  require(raster)
  
  r<-raster(targetRst)
  target_srs<-projection(r)                                               #Get or set the coordinate reference system (CRS) of a Raster* object.
  param<-getBoundingBox(targetRst)                                        #Get raster bounding box and x,y resolution
  
  command<-'gdalwarp'                                                     #image reprojection and warping utility
  command<-paste(command, "--config GDAL_CACHEMAX", ram)                  #Speed-up with more cache (avice: max 1/3 of your total RAM)
  command<-paste(command, "-t_srs", paste0('"',target_srs, '"'))          #target spatial reference set. The coordinate systems that can be passed are anything supported by the OGRSpatialReference.SetFromUserInput() call, which includes EPSG PCS and GCSes (ie. EPSG:4296), PROJ.4 declarations (as above), or the name of a .prf file containing well known text.
  command<-paste(command, "-tr", param$res)                               #set output file resolution (in target georeferenced units)
  command<-paste(command, "-te", param$ext)                               #set georeferenced extents of output file to be created (in target SRS).
  command<-paste(command, "-r", method)                                   #Resampling method to use. See http://www.gdal.org/gdalwarp.html for available methods are:
  command<-paste(command, "-overwrite -co 'COMPRESS=LZW' -co 'TILED=YES'")
  command<-paste(command, inRst)
  command<-paste(command, outRst)
  system(command)

  return('done')
}

</pre>