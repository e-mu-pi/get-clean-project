#get-clean-project
=================

get-clean-project is the repo for my Course Project for Coursera 
Course Getting and Cleaning Data

# Getting and Cleaning Wearable Computing Data

This repository has R code for retrieving and cleaning data from the Human Activity 
Recognition Using Smartphones Data Set:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Produce Clean Data

The fastest way to produce a clean text file of clean data is to run `writeOut.R`. 
From the R console with you working directory the same as the directory where you 
find this `README`,

    source('writeOut.R')
  
or from the command line

    R -f writeOut.R

That file can be read back into R with

    data <- read.table('dataForSubmission.txt', header=TRUE)
  
Note that `dataForSubmission.txt` is not distributed by this repo, but rather it is created
by `writeOut.R`.

# Is the source data in your working directory?

Probably not. The source data comes zipped, and depending on how you unzip it, 
it could be in your working directory, in a directory in your working directory, 
in a directory inside a directory in your working directory, etc. If you already 
have the data, these scripts might not find exactly which directory you unzipped 
into. The easiest thing to do is allow these scripts to redownload, but if you 
must use what you already downloaded, please define `data_dir` in `retrieveData.R` 
and comment out the line:
    
    data_dir <- get_source_data()

# Run Analysis

The main analysis script is `run_analysis.R`. Source it from R to rerun the analysis and load the results into your workspace. It will download the data for analysis, so make sure you are 
connected to the internet. See the Code Book for an explanation of `run_analysis.R`.

# Retrieve Data

A separate script, `retrieveData.R`, downloads data and loads it into R properly. It does not
clean the data. That is handled in `run_analysis.R`.

# Packages Required

This analysis was done in R 3.1.1 and required the following additional packages:
  
    assertthat 0.1
    BH 1.54.0-5
    DBI 0.3.1
    dplyr 0.3.02
    lazyeval 0.1.9
    magrittr 1.0.1
    plyr 1.8.1
    R6 2.0.1
    Rcpp 0.11.3
    reshape2 1.4
    stringr 1.4
    tidyr 0.1
    
