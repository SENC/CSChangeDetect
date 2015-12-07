#Detect changes btw 2 satelite images
#load first images 2010

library(raster)
#vignette("Raster")

dirpath <- "E:/CS/ImageComparsion/Code"
setwd(dirpath)


#2010 Satelite image loaded as Raster object
#
png1 <- brick("2010.png")
png1
plotRGB(png1)


png2 <- brick ("2011.png")
plotRGB (png2)

plot(png2)
par(mfrow=c(1,3))
#R band difference
Rdiff <- png2[[1]]-png1[[1]]
#plot(png2[[1]]);plot(png1[[1]]);plot(Rdiff)
plot(png2[[1]],main="2011-Red band");plot(png1[[1]],main="2010-Red band");plot(Rdiff,main="Red band diff")


#Green band difference
Gdiff <- png2[[2]]-png1[[2]]

plot(png2[[2]],main="2011-Green band");plot(png1[[2]],main="2010-Green band");plot(Gdiff,main="Green band diff")

#Blue band
Bluediff <- png2[[3]]-png1[[3]]

plot(png2[[3]],main="2011-Blue band");plot(png1[[3]],main="2010-Blue band");plot(Bluediff,main="Blue band diff")
