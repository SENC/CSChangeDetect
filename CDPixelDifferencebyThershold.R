#This code used to copy the difference pixel value based on thershold 

#set the path
setwd("T:/CS/ImageComparison/Code")
getwd()#print to confirm

#iclude require libraries - if its first time install.packages("raster")
library(raster)

#Set seed to reproduce same results where random value used
set.seed(12345)

#load sat imagge as Raster brick object
pipelineImg2010 <- brick("Selective2010.tif")
NopipelineImg2011<- brick("Selective2011.tif")

par(mfrow=c(1,3))
plotRGB(pipelineImg2010);plotRGB(NopipelineImg2011)

#raster object details
pipelineImg2010
NopipelineImg2011

arrayPipeline <- pipelineImg2010[1:705,1:1776]
arrayNoPipeline <- NopipelineImg2011[1:705,1:1776]

#compute smaller rows so can apply the logic in entire array
#newArray2 = head(arrayNoPipeline)
#newArray1 = head(arrayPipeline)

newArray2 = arrayNoPipeline
newArray1 = arrayPipeline


summary(newArray1);dim(newArray2)

newArrayDiff <- newArray2 - newArray1
dim(newArrayDiff)

# % of changes 
changes <- newArrayDiff/newArray2
#changes

# Set the thershold value 
thershold = 0.65

#compare with thershold - TRUE -FALSE
#thershold < newArrayDiff/newArray2

#sigchangesIndex <-  newArrayDiff[changes>thershold]
#sigchangesIndex

#tru false matrix
#if the pixel difference is negative , just include the % variance in postive
#changes <- ifelse(newArrayDiff<0,(changes *-1),changes)

issigchanges <- (thershold < changes)
#issigchanges

#sigchanges1

#get significant changed pixel values
#newArrayDiff[which(issigchanges)]

#index 
sigchangesIndex=which(issigchanges)
#sigchangesIndex

#set the actual pixel (significant change) values where 1 

sigChangePixelValues <- newArrayDiff[which(issigchanges)]

#sigChangePixelValues

#new array with siginifcatn changes and rest 0 for all
#convert negative value to positive  
###sigChangePixelValues <- ifelse (sigChangePixelValues<0, (sigChangePixelValues*-1),sigChangePixelValues)

pixelDiff_class <- ifelse(issigchanges=="TRUE",sigChangePixelValues,0)


changedetectedImg <- brick (NopipelineImg2011,nrows=705,ncols=1776,crs=NA,nl=3)
changedetectedImg

extent(changedetectedImg) <- extent(NopipelineImg2011)
projection(changedetectedImg)<-projection(NopipelineImg2011)
#just choosed nrow,rcol 
#it returs the cell values in matrix format
hasValues(changedetectedImg)

values(changedetectedImg) <- pixelDiff_class
#can check raster objetct has pixel values 
hasValues(changedetectedImg)
inMemory(changedetectedImg)

changedetectedImg
plotRGB(changedetectedImg)
plot(correctedImg)

writeRaster(changedetectedImg,"PixelImgDifference.tif", format="GTiff",overwrite=T)


#brick
output <- brick("PixelImgDifference.tif")

plotRGB(pipelineImg2010);plotRGB(NopipelineImg2011);plotRGB(output)
