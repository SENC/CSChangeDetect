# -*- coding: utf-8 -*-
"""
Spyder Editor
Change detection using  registered satellite images - 2 img on same location
Simple image difference techique
"""
import gdal,gdalnumeric
import numpy as np



#Input satellite images - same extent,resolution,location
satImgBefore= "T:/Selective2010.tif"#"T:/Machine Learning/R/2010.tif" #"T:/before.tif"
satImgAfter="T:/Selective2011.tif" # "T:/Machine Learning/R/2011.tif" #"T:/after.tif"

# convert pixel array with 3 layer info
arrayPipelineImg=gdalnumeric.LoadFile(satImgBefore).astype(np.int8)
arrayNoPipelineImg=gdalnumeric.LoadFile(satImgAfter).astype(np.int8)
arrayPipelineImgPreProcessed= arrayPipelineImg[:3,:705,:1776]
#since 2 image has differenct dimension , take common rows and col
#diff=arrayImg2[0:704,0:1775]-arrayImg1[0:704,1:1775]
# image difference betwee img2-img1
#AfterImage - before image
#below commented code to check we are getiig black [0,0,0] image
#diff=arrayPipelineImgPreProcessed- arrayPipelineImgPreProcessed
diff=arrayNoPipelineImg-arrayPipelineImgPreProcessed

#Before image - after image to see the diff
#diff=arrayPipelineImgPreProcessed - arrayNoPipelineImg

#classify images based on relvant group pixels-significant changes
classes=np.histogram(diff,bins=4)[1]
#print ("class :" , (classes))

# To mask insigificant changes as just black 
lookup=[ [0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,255,0],[255,0,0]]

#lookup=[ [255,0,0],[255,0,0],[255,0,0],[255,0,0],[0,255,0],[255,0,0]]
start=1
#print ("diff shape", diff.shape[0])
#setup output imag array with size same as diff - 3L,mRows,nCol
rgbDifference=np.zeros((diff.shape[0],diff.shape[1],diff.shape[2]), np.int8)
print (rgbDifference.shape)
#process all classes and assign colors
for i in range(len(classes)):
   mask= np.logical_and(start <=diff, diff <=classes[i])
   for j in range(len(lookup[i])):
       rgbDifference = gdalnumeric.numpy.choose( mask, (rgbDifference[j], lookup[i][j]))
   start = classes[i]+1
gdalnumeric.SaveArray(rgbDifference, "T:/DifferenceImage.tif", format="GTiff", prototype=satImgAfter)