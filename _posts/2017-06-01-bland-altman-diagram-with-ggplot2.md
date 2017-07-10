---
ID: 1012
post_title: Bland-Altman diagram with ggplot2
author: White-Guru
post_excerpt: ""
layout: post
permalink: >
  http://www.guru-gis.net/bland-altman-diagram-with-ggplot2/
published: true
post_date: 2017-06-01 10:10:50
---
Hello world!

Today, I'd like to share with you a code for plotting Bland-Altman diagrams.
The Bland-Altman diagram (Bland & Altman, 1986 and 1999), or difference plot, is a graphical method to compare two measurements techniques. In this graphical method the differences (or alternatively the ratios) between the two techniques are plotted against the averages of the two techniques. Alternatively (Krouwer, 2008) the differences can be plotted against one of the two methods, if this method is a reference or "gold standard" method.
Horizontal lines are drawn at the mean difference, and at the limits of agreement, which are defined as the mean difference plus and minus 1.96 times the standard deviation of the differences.

<pre lang='rsplus'>
Bland.Altman.diagram <-
  function(x,y,id=FALSE, alpha = .05,rep.meas = FALSE,subject,idname = FALSE, xname = 'x',yname = 'y',...) {

    library(ggplot2)
	  library(RColorBrewer)
	
    #*** 1. Set a few constants
    z <- qnorm(1 - alpha / 2)  ## value of z corresponding to alpha
    d <- x - y               ## pair-wise differences
    m <- (x + y) / 2           ## pair-wise means
    
    #*** 2. Calculate mean difference
    d.mn <- mean(d,na.rm = TRUE)
    
    #*** 3. Calculate difference standard deviation
    if (rep.meas == FALSE) {
      d.sd = sqrt(var(d,na.rm = TRUE))
    } else {
      #*** 3a. Ensure subject is a factor variable
      if (!is.factor(subject))
        subject <- as.factor(subject)
      
      #*** 3b. Extract model information
      n <- length(levels(subject))      # Number of subjects
      model <- aov(d ~ subject)           # One way analysis of variance
      MSB <- anova(model)[[3]][1]       # Degrees of Freedom
      MSW <- anova(model)[[3]][2]       # Sums of Squares
      
      #*** 3c. Calculate number of complete pairs for each subject
      pairs <- NULL
      for (i in 1:length(levels(as.factor(subject)))) {
        pairs[i] <- sum(is.na(d[subject == levels(subject)[i]]) == FALSE)
      }
      Sig.dl <-
        (MSB - MSW) / ((sum(pairs) ^ 2 - sum(pairs ^ 2)) / ((n - 1) * sum(pairs)))
      d.sd <- sqrt(Sig.dl + MSW)
    }
    
    #*** 4. Calculate lower and upper confidence limits
    ucl <- d.mn + z * d.sd
    lcl <- d.mn - z * d.sd
    print(d.mn)
    print(ucl)
    print(lcl)
    
    #*** 5. Make Plot
    xlabstr = paste(c('Mean(',xname,', ',yname,')'), sep = "",collapse = "")
    ylabstr = paste(c(xname, ' - ', yname), sep = "",collapse = "")
    id = ifelse(id==FALSE, as.factor(rep(1,length(m))), as.factor(id))
    xy <- data.frame(m,d,id)
    xy$id <- as.factor(xy$id)
    maxm <- max(m)


    #scatterplot of x and y variables
    scatter <- ggplot(xy,aes(m, d)) 
      
      
    if(idname == FALSE){
      scatter <- scatter + geom_point(color='darkgrey') + scale_color_manual( guide=FALSE)
    } else {
      scatter <- scatter + geom_point(aes(color = id))+ scale_color_brewer(idname, palette="Set1") # Set1
    }
    
    scatter <- scatter + geom_abline(intercept = d.mn,slope = 0, colour = "black",size = 1,linetype = "dashed" ) +
      geom_abline(
        intercept = ucl,slope = 0,colour = "black",size = 1,linetype = "dotted"
      ) +
      geom_abline(
        intercept = lcl,slope = 0,colour = "black",size = 1,linetype = "dotted"
      ) +
      ylim(min(lcl, -max(xy$d), min(xy$d)), max(ucl, max(xy$d), -min(xy$d)))+
      xlab(xlabstr) +
      ylab(ylabstr) +
      #geom_text(x=maxm-2.4,y=d.mn,label='Mean',colour='black',size=4)+
      #geom_text(x=maxm-2.4,y=ucl,label='+1.96 SD',colour='black',size=4)+
      #geom_text(x=maxm-2.4,y=lcl,label='-1.96 SD',colour='black',size=4)+
      theme(
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(color="black", size = 1)
    )
    
    plot(scatter)
      
    values <- round(cbind(lcl,d.mn,ucl),4)
    colnames(values) <- c("LCL","Mean","UCL")
    if (rep.meas == FALSE){
      Output <- list(limits = values,Var = d.sd ^ 2)
    } else {
      Output <- list(limits = values,Var = Sig.dl,MSB = MSB,MSW = MSW)
    }
    return(Output)
  }

A <- c(-0.358, 0.788, 1.23, -0.338, -0.789, -0.255, 0.645, 0.506, 
       0.774, -0.511, -0.517, -0.391, 0.681, -2.037, 2.019, -0.447, 
       0.122, -0.412, 1.273, -2.165)
B <- c(0.121, 1.322, 1.929, -0.339, -0.515, -0.029, 1.322, 0.951, 
       0.799, -0.306, -0.158, 0.144, 1.132, -0.675, 2.534, -0.398, 0.537, 
       0.173, 1.508, -1.955)

Bland.Altman.diagram(A, B,alpha = .05,rep.meas = F,xname = 'A',yname = 'B')
</pre>

The result is the following:
<a href="http://www.guru-gis.net/wp-content/uploads/2017/06/Rplot01.png" rel="attachment wp-att-1015"><img src="http://www.guru-gis.net/wp-content/uploads/2017/06/Rplot01.png" alt="Rplot01" width="693" height="546" class="alignnone size-full wp-image-1015" /></a>

The 'id' field allows you to define different categories that will be colored differently on the graph:<a href="http://www.guru-gis.net/wp-content/uploads/2017/06/Rplot02.png" rel="attachment wp-att-1016"><img src="http://www.guru-gis.net/wp-content/uploads/2017/06/Rplot02.png" alt="Rplot02" width="693" height="546" class="alignnone size-full wp-image-1016" /></a>