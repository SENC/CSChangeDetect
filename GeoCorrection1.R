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


blueBand1 <- png1[[1]]
dim(blueBand1)

headvalues1 <- head(blueBand1)
plot(headvalues1)

hist(headvalues1)

#2nd image
blueBand2 <- png2[[1]]
dim(blueBand2)

#geo correction

x1=blueBand1[2701,4601]
x1
x2=blueBand2[2701,4601]
x2
plot(blueBand2)
drawExtent(show=T,col="red")

extent(blueBand2,)
