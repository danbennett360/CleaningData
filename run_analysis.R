
# Solution to the final project for Getting and Cleaning Data.
#

# constant defiintions
# these are the strings used in processing this task.
#   Some are dependant on the dataset, 
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFileName = "PhoneData.zip"
dataDIR = "data"
midDIR = "UCI HAR Dataset"
subPath = c("test","train")

# build some paths
zipFile = paste(dataDIR,zipFileName,sep="/")

# make a data directory if it does not exist
if(!file.exists(dataDIR)) {
    dir.create(dataDIR)
} else {
   print("The data directory exists, skipping creation")
}

# download the zip file from on line and unzip it
if (!file.exists(zipFile)) {
    # download the file
    download.file(url,destfile=zipFile, method="curl")
    unzip(zipFile,exdir=dataDIR)
} else {
    print ("The file has been downloaded, skipping")
}

# extract the column numbers and names from the features.txt file
#     assume if the name contains the word "mean" or "std" it is a 
#     desired field.
#
# Automating this step is probably not what is wanted, we should
#   consult with the client to see what they are interestd in, but this 
#   will do and we can have some fun playing with R functions too.

featureNames = read.csv(paste(dataDIR,midDIR, "features.txt",sep="/"), sep=" ",
                col.names=c("position","name"), header=FALSE)
featureNames = featureNames[which(grepl("mean|std", featureNames$name)),]

# now fix the names, remove the (), if an -{X|Y|Z} is on the end, change that as well.

featureNames$name = lapply(featureNames$name, gsub,pattern="\\(\\)",replacement="")

#let's kill the -(mean|std) and make it camelCase
featureNames$name = lapply(featureNames$name, gsub,pattern="-mean",replacement="Mean")
featureNames$name = lapply(featureNames$name, gsub,pattern="-std",replacement="Std")

#finally kill all other -
featureNames$name = lapply(featureNames$name, gsub,pattern="-",replacement="")


# now build the labels from the activity_labels.txt file
fileName = paste(dataDIR,midDIR,"activity_labels.txt",sep="/")
activityLabels = read.table(fileName, header=FALSE)
names(activityLabels) = c("value","activityName")

#initialize the final data frame.
#    rbind has a fit otherwise
finalDS = data.frame(matrix(ncol=length(featureNames$name)+2, nrow=0))
names(finalDS) = c("subject", "activity",featureNames$name)

# now load each of the datasets (test,train)
for (name in  subPath) {
     finalName = paste0("X_",name,".txt")
     fileName = paste(dataDIR,midDIR,name,finalName,sep="/")

     # read the X_*.txt dataset
     DSRaw = read.table(fileName, header=FALSE)
     # eliminate the unwanted columns
     DSCut = DSRaw[,featureNames$position]
     #rename the columns.
     names(DSCut) = featureNames$name

     # read in the subject file
     finalName = paste0("subject_",name,".txt")
     fileName = paste(dataDIR,midDIR,name,finalName,sep="/")
     subjects = read.table(fileName, header=FALSE)
     names(subjects) = "subjectID"

     # read in the activity file
     finalName = paste0("y_",name,".txt")
     fileName = paste(dataDIR,midDIR,name,finalName,sep="/")
     action = read.table(fileName, header=FALSE)

     names(action) = "activity"


     # build the total table for this directory
     DSCut = cbind(subjects, action, DSCut)

     # cat this onto the final
     finalDS = rbind(DSCut, finalDS)
}

# build the pivot table for the last part.
summaryDS = aggregate(finalDS, by=list(finalDS$subjectID, finalDS$activity), FUN=mean)

# apply the lables to the activities
summaryDS$activity = factor(summaryDS$activity,levels = activityLabels$value,
                  labels = activityLabels$activityName)

# and drop the two lies added by aggregate
summaryDS = summaryDS[,!(names(summaryDS) %in% c("Group.1", "Group.2"))]


# finally write the table
write.table(summaryDS, file="finalTable.txt", row.name=FALSE)
