#Detect changes btw 2 satelite images
#load first images 2010
library(raster)

dirpath <- "T:/CS/ImageComparison/Code"
setwd(dirpath)


#2010 Satelite image loaded as Raster object
# 2010 has pipeline and 2011 image has no pipeline
pipelineImg2010 <- brick("Selective2010.tif")
NopipelineImg2011 <- brick("Selective2011.tif")

#check the row,col are same for 2 images
dim(pipelineImg2010);dim(NopipelineImg2011)

#check other raster attributes are same - extent,crs,nrow,ncol,ncell

NopipelineImg2011
pipelineImg2010

#since nimg2  dim(row,col) are different ,have to create new raster object 
#which shuld match the 2nd image dimension
correctedImg <- brick (NopipelineImg2011,nrows=705,ncols=1776,crs=NA,nl=3)
correctedImg
extent(correctedImg) <- extent(NopipelineImg2011)
projection(correctedImg)<-projection(NopipelineImg2011)
#just choosed nrow,rcol 
#it returs the cell values in matrix format
hasValues(correctedImg)
diff <- NopipelineImg2011[1:705,1:1776] - pipelineImg2010[1:705,1:1776]
#shold match with ncell of raster object
dim(diff)
#can check raster objetct has pixel values 
hasValues(correctedImg)
inMemory(correctedImg)

#assign the pixel values (matrix) to the new raster object
values(correctedImg)<- diff


#can check raster objetct has pixel values 
hasValues(correctedImg)
inMemory(correctedImg)

correctedImg
plot(correctedImg)
image(correctedImg)
writeRaster(correctedImg,"ImgDifference.tif", format="GTiff",overwrite=T)
#help("writeFormats")
