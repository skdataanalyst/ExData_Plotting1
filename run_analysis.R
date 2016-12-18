## R script##

dir_path <-"C:/Users/bsr/Documents/R/TestFiles/data/UCI/"
setwd(dir_path)


################## STEP 1 #######################

##### Read the Generic Files           #####
features <- read.table("./features.txt", header=FALSE)
activity <- read.table("./activity_labels.txt", header=FALSE)

##### Read the Train Data              #####
xTrain <- read.table("./train/X_train.txt", header = FALSE)
yTrain <- read.table("./train/y_train.txt", header = FALSE)
subTrain <- read.table("./train/subject_train.txt", header = FALSE)

##### Read the test Data               #####

xTest <- read.table("./test/X_test.txt",header = FALSE)
yTest <- read.table("./test/y_test.txt", header =FALSE)
subTest <- read.table("./test/subject_test.txt", header = FALSE)

##### Set Column names for data frames #####
colnames(xTest) <- features[,2]
colnames(xTrain) <- features[,2]
colnames(yTest)  <- "activityId"
colnames(yTrain) <- "activityId"
colnames(subTrain) <- "subjectId"
colnames(subTest) <- "subjectId"
colnames(activity) <- c("activityId","activityName")
 
##### Bind the Train Data              #####
traindata <- cbind(subTrain,yTrain,xTrain)
##### Bind the Test Data               #####
testdata <- cbind(subTest,yTest,xTest)

##### Combine the Training and Test Data
combineData <- rbind(traindata,testdata)
####### END STEP 1 ########

################### STEP 2 ######################
##### Extract Columns for final data   #####
finalDataInit <- combineData[,c("subjectId","activityId")]
###finalDatamean <- combineData[,grep("mean",colnames(combineData))] ## both mean & meanfreq## 
finalDatamean <- combineData[,grep("mean\\()",colnames(combineData))] ## only selecting mean ##
finalDatastd <- combineData[,grep("std",colnames(combineData))]

##### Create Final Data                #####
finalData <- cbind(finalDataInit,finalDatamean, finalDatastd) 

####### END STEP 2 ########

################### STEP 3 ######################

##### Merge Activity Labels

finalDataMerge <- merge(activity,finalData, by.x = "activityId", by.y = "activityId", all =TRUE)

####### END STEP 3 #######

################### STEP 4 ######################
###### Rename the columns ######
colnameFinal <- colnames(finalDataMerge)
colnameFinal <- gsub("-mean","Mean",gsub("-std","stdDeviation",gsub("\\()","",colnameFinal)))
colnameFinal <- gsub("^f","freq",gsub("^t","time",colnameFinal))

colnames(finalDataMerge) <- colnameFinal

####### END STEP 4 #######

################### STEP 5 ######################
###### Apply the mean for all the columns except first 3 ######
tidyData <- aggregate(finalDataMerge[,4:length(colnames(finalDataMerge))], by = list(activityId = finalDataMerge$activityId, activityName = finalDataMerge$activityName, subjectId = finalDataMerge$subjectId), mean)

###### Write the data to the file ######

write.table(tidyData, file = "./tidydata.txt",row.names = FALSE, sep="\t")

####### END STEP 5 #######

