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
png2
png1
nlayers(png1)
names(png1)
extract(png1,870)

#train oilpipe image
oilpipe <- brick("2010OilPipe.png")

#non pipe- vegeattion
vegetation <- brick("vegetation.png")
vegetation

training_pipeline_img <- oilpipe
training_no_pipeline_img <- vegetation

#convert to dataframe

training_pipeline_df <- data.frame(getValues(training_pipeline_img))


summary(training_pipeline_df)

names(training_pipeline_df) <- c("r","g","b")

#remove whitebackground pixels

training_pipeline_df <- training_pipeline_df[(training_pipeline_df$r <254 & training_pipeline_df$g & training_pipeline_df$b < 254 ),]

head(training_pipeline_df)

training_pipeline_df$pipeline <- "P"

#non pipeline - vegetation

training_no_pipeline_df<- data.frame(getValues(training_no_pipeline_img)) 
summary(training_no_pipeline_df)
names(training_no_pipeline_df) <- c("r","g","b")

training_no_pipeline_df <- training_no_pipeline_df [(training_no_pipeline_df$r <254 & training_no_pipeline_df$g < 254 & training_no_pipeline_df$b < 254),]
head(training_no_pipeline_df)
training_no_pipeline_df$pipeline <- "V"

str(training_no_pipeline_df)

names(training_pipeline_df);
names(training_no_pipeline_df)

#take subset from non pipeline - computing purpose - subset of 5000 pixel
training_df <- rbind(training_pipeline_df , training_no_pipeline_df[ sample (nrow(training_no_pipeline_df),4500),])
rbin
str(training_df)

training_df$pipeline <- as.factor(training_df$pipeline)

#divide trainingd df to 75% training subset and 25% test subset
library (caret)
set.seed(123456789)
trainindex <- createDataPartition(training_df$pipeline,p=0.75,list=FALSE)
traindata <- training_df[trainindex,]
testdata <- training_df[-trainindex,]

dim(traindata)
dim(testdata)
#Support Vector machine
require(e1071)
svm_model <- best.svm(pipeline ~ . , data=traindata, gamma=10^(-6:-1), cost=10^(-1:1))
svm_model
#Error matrix - compare with 25% Test set 
svm_prediction <- predict (svm_model , testdata[,1:3])

cfmatrix <- table(predicted = svm_prediction, true=testdata[,4])
print (cfmatrix)


#train complete data set and compare with original 2011 image

svm_model_fit<- best.svm(pipeline ~ ., data=training_df, gamma=10^(-6:-1), cost=10^(-1:1))

dataframe2010Original <- data.frame(getValues (png1))

names(dataframe2010Original)<- c("r","g","b")

#target map
predict2010 <- predict(svm_model_fit, dataframe2010Original)
png1_class<- ifelse(predict2010 =="P",1,0)
classifiedImage <- png1[[1]]
values(classifiedImage) <- png1_class
