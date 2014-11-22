library(dplyr)
library(tidyr)
# Load data -----------
# creates raw_test and raw_train data 
# also loads activities data.frame with codes/names of activities
source("retrieveData.R")

# Merge test and train data -----

merged_data <- rbind(raw_test, raw_train)

# Extract only measurements on mean and standard deviation ----

mean_stddev_cols <- grepl("mean[^F]|std",names(merged_data))
# If you want meanFreq in addition to mean, uncomment this line
#mean_stddev_cols <- which(grepl("mean|std",names(merged_data))) 
non_measurement_cols <-  names(merged_data) %in% c("Activity","subject")
mean_stddev <- merged_data[,mean_stddev_cols|non_measurement_cols]

# Rename activities -------

#recall activities data.frame loaded by retrieveData.R
# merge on shared ActivityCode variable
add_activity_name <- merge(mean_stddev,activities)
named_activities <- add_activity_name %>% select(-ActivityCode)
  
# Relabel variables -----

#I think my variable names are already pretty informative, for example, run:
# print(names(named_activities))
# See the work done to get that in retrieveData.R

# Make tidy data of average of each variable for each activity and subject -----

tidy_data <- named_activities %>% group_by(subject,Activity) %>% summarise_each(funs(mean))
