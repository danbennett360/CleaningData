# Final Project for Getting and Cleaning Data
## August 2015
## Dan Bennett

## Contents
1. Algorithm 
2. Usage
3. Comments 
4. Project Description (From the assignment)

## Algorithm
* Create a data directory if none exists
* Download the file, if it has not yet been downloaded
* Unzip the file
* Build a list of variable names from the features.txt file, include any variable with the word mean or std
..* NOTE: see comment section below
* Fix the names so they are more user friendly
.. NOTE:: see comment section below
* For each data set (test, train)
** Read in the three files
** Select the appropriate columns from the dataset
** Append subjectID and activity data to this dataset
** Merge this dataset into the final dataset
* Use the aggregate function to complete the final computation
* Save the file

## Usage
Simply running this script will perform all steps needed.  No further input/configuration is required.

This script expects to find the data files in  **data/UCI HAR Dataset** in the current working directory.

To use data from a location other than the subdirectory **data** change the value of *dataDIR* at the top of the script.

If the files are  not in the subdirectory from the zip file (**UCI HAR Dataset**) change the value of m*midDIR*  at the top of the script.

The final results will be stored in *finalTable.txt* in the current working directory.  

## Comments

I decided to automatically include every column which includes the words *mean* or *std*.  As noted in the comments in the script, this is somewhat arbitrary.  The column names to use should either come from the client, or from the creator who has a better idea of how the final data would be used.  I did not include any column with the word *Mean* or *Std* as these appeared to be some other type of statistic.

When creating column names, I removed all dashes, parenthesis.  I also did my best to use camelCase for variable names.   I am a programmer and this is the standard I use.   This method was selected to minimize my errors in producing this project.

## Project Description:
<pre>
The purpose of this project is to demonstrate your ability to collect, work 
with, and clean a data set. The goal is to prepare tidy data that can be used 
for later analysis. You will be graded by your peers on a series of yes/no
questions related to the project. You will be required to submit: 1) a tidy 
data set as described below, 2) a link to a Github repository with your script
for performing the analysis, and 3) a code book that describes the variables,
the data, and any transformations or work that you performed to clean up the 
data called CodeBook.md. You should also include a README.md in the repo with
your scripts. This repo explains how all of the scripts work and how they are
connected.  

One of the most exciting areas in all of data science right now is wearable 
computing - see for example this article . Companies like Fitbit, Nike, and 
Jawbone Up are racing to develop the most advanced algorithms to attract new
users. The data linked to from the course website represent data collected 
from the accelerometers from the Samsung Galaxy S smartphone. A full 
description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


You should create one R script called run_analysis.R that does the following. 
1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names. 
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 </pre>
