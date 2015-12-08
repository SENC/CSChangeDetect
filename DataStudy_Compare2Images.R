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


#After manual comparion,,in 2011 there are o pipeline but 2010 has
#Programmatically highlight the difference
par(mfrow=c(1,2))
plotRGB(cropImg2)
plotRGB(croppedImg1)

#save the raster object as file
writeRaster(croppedImg1,"Selective2010.tif", format="GTiff")
writeRaster(cropImg2,"Selective2011.tif", format="GTiff")

#[2]  
pipelineImg2010 <- brick("Selective2010.tif")
NopipelineImg2011<- brick("Selective2011.tif")

plotRGB(pipelineImg2010);plotRGB(NopipelineImg2011)

#raster object details
pipelineImg2010
NopipelineImg2011


dim(pipelineImg2010);dim(NopipelineImg2011)
#get error for teh belwo sice 2 extent are not same
diff = pipelineImg2010[[1]] - NopipelineImg2011[[1]]
extent(pipelineImg2010)
e1 <-extent(NopipelineImg2011)
e1
pipelineImg2010v2 <- crop(pipelineImg2010,e1)
#crop using extent seems not workedbut to set same extent just use the below code
extent(pipelineImg2010v2);extent(NopipelineImg2011)
extent(pipelineImg2010v2)=extent(NopipelineImg2011)

pipelineImg2010v2;NopipelineImg2011
