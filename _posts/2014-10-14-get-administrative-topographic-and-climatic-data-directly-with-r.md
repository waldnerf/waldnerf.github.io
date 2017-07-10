---
ID: 173
post_title: 'Get administrative, topographic and climatic  data directly in R'
author: Khan-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/get-administrative-topographic-and-climatic-data-directly-with-r/
published: true
post_date: 2014-10-14 14:45:27
---
This post shows some examples of the function  <strong>getData</strong> into the Raster package. This function  allows to directly download data from 3 global datasets (<strong>Administrative borders</strong>, <strong>Altitude, <strong>Climate</strong></strong>). This will be shown for a country (Belgium). The code is below.

<strong>Administrative borders </strong> (from GDMA dataset) is available at 5 country sub-levels

<a href="http://www.guru-gis.net/wp-content/uploads/2014/10/1Admin.png"><img class="alignnone wp-image-174 size-full" src="http://www.guru-gis.net/wp-content/uploads/2014/10/1Admin.png" alt="1Admin" width="1114" height="287" /></a><strong>Altitude</strong> (from the SRTM dataset) at 90m of resolution


<a href="http://www.guru-gis.net/wp-content/uploads/2014/10/2Altitude.png"><img class="alignnone wp-image-175 size-full" src="http://www.guru-gis.net/wp-content/uploads/2014/10/2Altitude.png" alt="2Altitude" width="1086" height="430" /></a><strong>Climate</strong> (available from worldclim at 0.5 minute of degree corresponding to 5.5 km of spatial resolution in Belgium)

Mean <strong>precipitations</strong> by month<a href="http://www.guru-gis.net/wp-content/uploads/2014/10/31Precipitations.png"><img class="alignnone wp-image-176 size-full" src="http://www.guru-gis.net/wp-content/uploads/2014/10/31Precipitations.png" alt="31Precipitations" width="906" height="655" /></a>     Annual mean <strong>temperature</strong><a href="http://www.guru-gis.net/wp-content/uploads/2014/10/32MeanTemperature.png"><img class="alignnone size-full wp-image-177" src="http://www.guru-gis.net/wp-content/uploads/2014/10/32MeanTemperature.png" alt="32MeanTemperature" width="906" height="520" /></a>

<!--more-->



<pre lang="rsplus">
# 1/ ADMINISTRATIVE BORDERS
## Get Adminstrative boundaries data at 5 different level from (GADM)
# polygons for all countries at a higher resolution than the 'wrld_simpl' data in the maptools pacakge

admin_bel_l0<-getData('GADM',country='BEL',level=0)
admin_bel_l1<-getData('GADM',country='BEL',level=1)
admin_bel_l2<-getData('GADM',country='BEL',level=2)
admin_bel_l3<-getData('GADM',country='BEL',level=3)
admin_bel_l4<-getData('GADM',country='BEL',level=4)

par(mfrow=c(1,5))
plot(admin_bel_l0,zcol='NAME_ISO',main='level 0')
title("level 0")
plot(admin_bel_l1,zcol='ISO',main='level 1')
title("level 1")
plot(admin_bel_l2,zcol='ISO',main='level 2')
title("level 2")
plot(admin_bel_l3,zcol='ISO',main='level 3')
title("level 3")
plot(admin_bel_l4,zcol='ISO',main='level 4')
title("level 4")

# 2/ ALTITUDE
## Get SRTM data (90m)
par(mfrow=c(1,2))
r_alt<-getData('alt',country="BEL")
plot(r_alt,main= 'altitude')
hist(r_alt,main= 'altitude distribution' )

# 3/ CLIMATE 
# 3.1/ MEAN PRECIPITATIONS BY MONTH
#Get climatic data (from http://www.worldclim.org) 'tmin', 'tmax', 'prec', 'bio'
r_prec<-getData('worldclim', var='prec',res=0.5, lon=4.35, lat=50.8)
levelplot(r_prec)
plot(admin_bel_l0,ext=admin_bel_l0,zcol='NAME_ISO',add=T)

idx <- seq(1, 12)
r_prec_crop<-crop(r_prec,admin_bel_l0)
r_prec_crop_z <- setZ(r_prec_crop, idx)
names(r_prec_crop_z) <- month.abb

myTheme=rasterTheme(region=rev(sequential_hcl(10, power=1)))
p<-levelplot(r_prec_crop_z, par.settings=myTheme)
p + layer(sp.polygons(admin_bel_l2, lwd=0.8, col='black'))


# 3.2/ ANNUAL MEAN TEMPERATURE
r_bio<-getData('worldclim', var='bio',res=0.5, lon=4.35, lat=50.8) #resolution is in minute of degree
# (0.5 minutes is about 5.56 km in Belgium ans is the finest resolution available from worldclim)

# there are 12 (monthly) files for each variable except for 'bio' which contains 19 files
# BIO1 = Annual Mean Temperature
# BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp))
# BIO3 = Isothermality (BIO2/BIO7) (* 100)
# BIO4 = Temperature Seasonality (standard deviation *100)
# BIO5 = Max Temperature of Warmest Month
# BIO6 = Min Temperature of Coldest Month
# BIO7 = Temperature Annual Range (BIO5-BIO6)
# BIO8 = Mean Temperature of Wettest Quarter
# BIO9 = Mean Temperature of Driest Quarter
# BIO10 = Mean Temperature of Warmest Quarter
# BIO11 = Mean Temperature of Coldest Quarter
# BIO12 = Annual Precipitation
# BIO13 = Precipitation of Wettest Month
# BIO14 = Precipitation of Driest Month
# BIO15 = Precipitation Seasonality (Coefficient of Variation)
# BIO16 = Precipitation of Wettest Quarter
# BIO17 = Precipitation of Driest Quarter
# BIO18 = Precipitation of Warmest Quarter
# BIO19 = Precipitation of Coldest Quarter

# NOTE: Temperature data is in units of °C * 10 
par(mfrow=c(1,2))
plot(r_bio$bio1_16/10,ext=admin_bel_l0,main="Annual Mean Temperature")
plot(admin_bel_l0,ext=admin_bel_l0,zcol='NAME_ISO',add=T)
hist(r_bio$bio1_16/10, main="")
</pre>