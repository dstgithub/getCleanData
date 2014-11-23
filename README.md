getCleanData
============

for course

Introduction

This repository contains the work for the course project. 

Raw data

The features (561 columns) are unlabeled in the X_test.txt. The activity labels are in the Y_test.txt file. The test subjects are in the subject_test.txt file.

The same features are for the training set.

About the script and the tidy dataset

run_analysis.R merges the test and training sets together. Prerequisites for this script:

After merging testing and training, labels are added and only columns that have to do with mean and standard deviation are kept.

The .R script will create a tidy data set containing the means of all the columns per test subject and per activity.
This tidy dataset will be written to a tab-delimited file called tidyData.df.txt.

About the Code Book

The CodeBook.md file explains the transformations performed and the resulting data and variables.
