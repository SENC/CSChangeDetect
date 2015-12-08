#Detect changes btw 2 satelite images
#load first images 2010
library(raster)
#vignette("Raster")

dirpath <- "T:/CS/ImageComparison/Code"
setwd(dirpath)


#2010 Satelite image loaded as Raster object
#
pipelineImg2010 <- brick("Selective2010.tif")
NopipelineImg2011 <- brick("Selective2011.tif")
dim(pipelineImg2010);dim(NopipelineImg2011)
NopipelineImg2011
r1 <- brick (NopipelineImg2011,nrows=705,ncols=1776,crs=NA,nl=3)
hasValues(r1)

pipelineImg2010[705,3]
diff <- NopipelineImg2011[1:705,1:1776] - pipelineImg2010[1:705,1:1776]
dim(diff)
image(diff)
class(diff)

values(r1)<- diff

r1
plot(r1)

vals2 <- getValues(pipelineImg2010,row=705)
vals2
setValues(r1,vals)
hasValues(r1)
plot(r1)


r1[[1]]


dim(pipelineImg2010);dim(NopipelineImg2011)

help(raster)

r1 <- brick (NopipelineImg2011, nrows=705,ncols=1776, crs=NA,nl=3)
r1
image(r1)
setValues(r1,getValues(pipelineImg2010,1:705,705))
hasValues(r1)

extent(r1)=extent(NopipelineImg2011)
res(r1)=res(NopipelineImg2011)

dim(pipelineImg2010)
dim(NopipelineImg2011)

setValues(r1,getValues(pipelineImg2010))

plot(r1)
length(r1)
length(NopipelineImg2011)
r1
NopipelineImg2011

r2 <- raster(ncol=10, nrow=10)
r2
ncell
vals <- 1:ncell(r)
vals
r <- setValues(r, vals)
# equivalent to
r[] <- vals

r1

#1
cells <-rowColFromCell(pipelineImg2010,c(705,1:1776))

#2
cells <- c(705,1776,3)
cells
r1 <- rasterFromCells(pipelineImg2010,ncell(NopipelineImg2011),values = TRUE)

r1 <-setValues(r1,vals,values = TRUE)
r1

#subset
s1<- subset(pipelineImg2010,2:3)
sel3 <- dropLayer(pipelineImg2010,1)
sel3
nlayers(sel3)

t1 <-extract(pipelineImg2010,1:705)
dim(t1)
t1[705]
r1 <-setValues(r1,t1)
cellvals <- cellsFromExtent(NopipelineImg2011,extent = extent(pipelineImg2010),expand = F)

r1 <- setValues(r1,cellvals)
NopipelineImg2011

blueband1[1:10,1:5]
blueband1[[1,5]]
new= cellStats(pipelineImg2010,stat = TRUE)

(pipelineImg2010)
NopipelineImg2011

#R band difference
blueband1 <- NopipelineImg2011[[1]]
blueband1

Rdiff <- NopipelineImg2011 [[1]]-png1[[1]]
#plot(png2[[1]]);plot(png1[[1]]);plot(Rdiff)
plot(png2[[1]],main="2011-Red band");plot(png1[[1]],main="2010-Red band");plot(Rdiff,main="Red band diff")


#Green band difference
Gdiff <- png2[[2]]-png1[[2]]

plot(png2[[2]],main="2011-Green band");plot(png1[[2]],main="2010-Green band");plot(Gdiff,main="Green band diff")

#Blue band
Bluediff <- png2[[3]]-png1[[3]]

plot(png2[[3]],main="2011-Blue band");plot(png1[[3]],main="2010-Blue band");plot(Bluediff,main="Blue band diff")
