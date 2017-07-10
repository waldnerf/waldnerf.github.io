---
ID: 864
post_title: >
  Calculate hillshade with gdaldem based
  on the elevation and azimuth angle
  calculated from the acquisition time
author: Khan-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/calculate-hillshade-with-gdaldem-based-on-the-elevation-and-azimuth-angle-calculated-from-the-acquisition-time/
published: true
post_date: 2015-03-27 11:58:51
---
Hi GIS fellows ! Here is a spring present, let's see how to simply create an hillshade based on the acquisition date and time !

<pre lang='rsplus'>
sunPosition <- function(year, month, day, hour=12, min=0, sec=0,
                        lat=46.5, long=6.5) {
  
  twopi <- 2 * pi
  deg2rad <- pi / 180
  
  # Get day of the year, e.g. Feb 1 = 32, Mar 1 = 61 on leap years
  month.days <- c(0,31,28,31,30,31,30,31,31,30,31,30)
  day <- day + cumsum(month.days)[month]
  leapdays <- year %% 4 == 0 & (year %% 400 == 0 | year %% 100 != 0) & 
    day >= 60 & !(month==2 & day==60)
  day[leapdays] <- day[leapdays] + 1
  
  # Get Julian date - 2400000
  hour <- hour + min / 60 + sec / 3600 # hour plus fraction
  delta <- year - 1949
  leap <- trunc(delta / 4) # former leapyears
  jd <- 32916.5 + delta * 365 + leap + day + hour / 24
  
  # The input to the Atronomer's almanach is the difference between
  # the Julian date and JD 2451545.0 (noon, 1 January 2000)
  time <- jd - 51545.
  
  # Ecliptic coordinates
  
  # Mean longitude
  mnlong <- 280.460 + .9856474 * time
  mnlong <- mnlong %% 360
  mnlong[mnlong < 0] <- mnlong[mnlong < 0] + 360
  
  # Mean anomaly
  mnanom <- 357.528 + .9856003 * time
  mnanom <- mnanom %% 360
  mnanom[mnanom < 0] <- mnanom[mnanom < 0] + 360
  mnanom <- mnanom * deg2rad
  
  # Ecliptic longitude and obliquity of ecliptic
  eclong <- mnlong + 1.915 * sin(mnanom) + 0.020 * sin(2 * mnanom)
  eclong <- eclong %% 360
  eclong[eclong < 0] <- eclong[eclong < 0] + 360
  oblqec <- 23.439 - 0.0000004 * time
  eclong <- eclong * deg2rad
  oblqec <- oblqec * deg2rad
  
  # Celestial coordinates
  # Right ascension and declination
  num <- cos(oblqec) * sin(eclong)
  den <- cos(eclong)
  ra <- atan(num / den)
  ra[den < 0] <- ra[den < 0] + pi
  ra[den >= 0 & num < 0] <- ra[den >= 0 & num < 0] + twopi
  dec <- asin(sin(oblqec) * sin(eclong))
  
  # Local coordinates
  # Greenwich mean sidereal time
  gmst <- 6.697375 + .0657098242 * time + hour
  gmst <- gmst %% 24
  gmst[gmst < 0] <- gmst[gmst < 0] + 24.
  
  # Local mean sidereal time
  lmst <- gmst + long / 15.
  lmst <- lmst %% 24.
  lmst[lmst < 0] <- lmst[lmst < 0] + 24.
  lmst <- lmst * 15. * deg2rad
  
  # Hour angle
  ha <- lmst - ra
  ha[ha < -pi] <- ha[ha < -pi] + twopi
  ha[ha > pi] <- ha[ha > pi] - twopi
  
  # Latitude to radians
  lat <- lat * deg2rad
  
  # Azimuth and elevation
  el <- asin(sin(dec) * sin(lat) + cos(dec) * cos(lat) * cos(ha))
  az <- asin(-cos(dec) * sin(ha) / cos(el))
  
  # For logic and names, see Spencer, J.W. 1989. Solar Energy. 42(4):353
  cosAzPos <- (0 <= sin(dec) - sin(el) * sin(lat))
  sinAzNeg <- (sin(az) < 0)
  az[cosAzPos & sinAzNeg] <- az[cosAzPos & sinAzNeg] + twopi
  az[!cosAzPos] <- pi - az[!cosAzPos]
  
  
  el <- el / deg2rad
  az <- az / deg2rad
  lat <- lat / deg2rad
  
  return(list(elevation=el, azimuth=az))
}



# calculate the sun position from date and time
position<-sunPosition(2012, 05, 25, hour=15, min=40, sec=42.460,lat=d_wgs@coords[2], long=d_wgs@coords[1])

system(paste('gdaldem hillshade',
             '-of GTiff',
             '-az',position$azimuth,
             '-alt',position$elevation,
             paste('/path_to_data/dtm_file','.tif',sep=''),
             paste('/path_to_data/dtm_file','_hillshade.tif',sep='')))

</pre>