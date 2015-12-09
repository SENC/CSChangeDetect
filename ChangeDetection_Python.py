# -*- coding: utf-8 -*-
"""
Spyder Editor
Date: 9-Dec-2015
Developer: Senthil Chidambaram
Ref:Geo Spatial Analysis, Joel 
Scope: 
Change detection using  co-registered satellite images - 2 img on same location
Simple image difference techique 

Logic:
[1] Check dimension,extent, projection for 2 images are same
[2] Convert image in to array and subtract the numpy array-> AfterImage - BeforeImage
[3] Get the difference and Classify/group the pixel 
[4] color each class/group and mask insiginifcant changes

Note: This code works for 3 band Satellite images [Blue,Green,Red] 
Since the input file is limited hardcoded some dimension [3,2727,4614] OR [3,705,1776]
Please change the dimension if you try with your own image
Code has to be refactored

"""
import gdal,gdalnumeric
import numpy as np



#Input satellite images - same extent,resolution,location

defaultChoice = True
#Selective area - Pipeline - dimension [3,705,1776]
if defaultChoice :
 satImgBefore= "T:/Selective2010.tif"
 satImgAfter="T:/Selective2011.tif" 

else:
#Whole image -more computing -dimension [3,2727,4614]
 satImgBefore="T:/Machine Learning/R/2010.tif" #"T:/before.tif"
 satImgAfter= "T:/Machine Learning/R/2011.tif" #"T:/after.tif"


# convert pixel array with 3 layer info
arrayPipelineImg=gdalnumeric.LoadFile(satImgBefore).astype(np.int8)
arrayNoPipelineImg=gdalnumeric.LoadFile(satImgAfter).astype(np.int8)

#since 2 image has differenct dimension , take common rows and col
#diff=arrayImg2[0:704,0:1775]-arrayImg1[0:704,1:1775]
# image difference betwee img2-img1
#AfterImage - before image
#below commented code to check are we getiig black [0,0,0] image since no difference
#diff=arrayPipelineImgPreProcessed- arrayPipelineImgPreProcessed

if (arrayPipelineImg.shape ==arrayNoPipelineImg.shape):
   diff=arrayNoPipelineImg-arrayPipelineImg
else:
   #below code works for the entire satelite image with the dimension [3,2727,4614]
   #arrayNoPipelineImgPreProcessed= arrayNoPipelineImg[:3,:2727,:4614] 
   #arrayPipelineImgPreProcessed= arrayPipelineImg[:3,:2727,:4614]   
   
   arrayPipelineImgPreProcessed= arrayPipelineImg[:3,:705,:1776]   
   diff=arrayNoPipelineImg-arrayPipelineImgPreProcessed
print (diff.shape)
#Before image - after image to see the diff
#diff=arrayPipelineImgPreProcessed - arrayNoPipelineImg

# classify/group the pixels  into 5 group pixels -128 to 127 
pixelgroups=np.histogram(diff,bins=4)[1]
#print ("class :" , (classes))

# Color Table to color each class  and  mask insigificant changes as just black B,G,R
lookup=[ [0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,255,0],[0,0,255]]
#tried different color table  to see the difference output
#lookup=[ [0,0,0],[0,255,0],[0,0,255],[0,0,0],[0,255,0],[0,0,255]]
start=1
#print ("diff shape", diff.shape[0])
#setup output imag array with size same as diff - 3L,mRows,nCol and all values set to "0"(Black color)
rgbDifference=np.zeros((diff.shape[0],diff.shape[1],diff.shape[2]), np.int8)
print (rgbDifference.shape)
#process all classes and assign colors
# 
for i in range(len(pixelgroups)):
   mask= np.logical_and(start <=diff, diff <=pixelgroups[i])
   for j in range(len(lookup[i])):
       rgbDifference = gdalnumeric.numpy.choose( mask, (rgbDifference[j], lookup[i][j]))
       #rgbDifference = gdalnumeric.numpy.choose( mask, (rgbDifference[j], 255))-FULL WHITE IMAGE
   
   start = pixelgroups[i]+1
gdalnumeric.SaveArray(rgbDifference, "T:/ChangeDetection.tif", format="GTiff", prototype=satImgAfter)