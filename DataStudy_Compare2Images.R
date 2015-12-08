#Path: T:\CS\ImageComparsion

#This code used to study the 2 different satllite images for change detection

#set the path
setwd("T:/CS/ImageComparison/Code")
getwd()#print to confirm

#iclude require libraries - if its first time install.packages("raster")
library(raster)
library(RPyGeo) #not used 
library(ggplot2)#not used

#Set seed to reproduce same results where random value used
set.seed(12345)
#Read the image file both tiff & png
beforeTif<- brick ("2010.tif")
afterTif <- brick ("2011.tif")
png1 <- brick("2010.png")
png2 <- brick("2011.png")

#Raster attributes comparison
afterTif;beforeTif

#check the nRow,mCol - should be equal if NOT to have to do preprocess
dim(beforeTif);dim(afterTif)
dim(png1);dim(png2)

#taekn reference image and try to crop the which we are interested
plotRGB(beforeTif)
drawExtent(show=T,col = "red")
#once you mark your cursor(2 points) in the plot image it will show the extent
newExtent <- extent(753844.6,754738.9,3163789,3164144)

croppedImg1 <- crop(beforeTif,newExtent)
croppedImg1
image(croppedImg1)

#crop the 2nd image with same extent
cropImg2 <- crop(afterTif,newExtent)
image(cropImg2)
par(mfrow=c(3,3))
plotRGB(png1);plot(croppedImg1);plot(cropImg2)
#2nd image
par(mfrow=c(1,4))
plotRGB(afterTif);plotRGB(cropImg2)

#compare Co-ordinate reference system and extent are same for both 
crs(croppedImg1);crs(cropImg2)
extent(croppedImg1);extent(cropImg2)


