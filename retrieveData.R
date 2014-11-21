
get_source_data <- function() {
  data_dir <- "data"
  if ( !file.exists(data_dir) ) {
    dir.create(data_dir)
  }
  data_dir <- file.path(".",data_dir)
  
  file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  file_name <- "UCI_HAR_Dataset"
  dir_name <- "UCI HAR Dataset"
  file_name_zip <- paste(file_name,'zip',sep='.')
  file_name_zip <- file.path(data_dir,file_name_zip)
  if ( !file.exists(file_name_zip) ) {
    if ( .Platform$OS.type == 'windows'  ) {
      download.file( file_url, destfile = file_name_zip)
    }
    else {
      download.file( file_url, destfile = file_name_zip, method='curl')
    }
    dateDownloaded <- date()
    print(dateDownloaded)
  }
  unzipped_dir <- file.path( data_dir, dir_name)
  if ( !file.exists(unzipped_dir) ) {
    unzip(file_name_zip, exdir = data_dir)
  }
  #print(list.files(unzipped_dir,recursive = TRUE))
  unzipped_dir
}

load_subject <- function(subject_file) {
  data <- read.table(subject_file,col.names="subject")
}

load_features <- function(feature_file) {
  data <- read.table(feature_file,
                     col.names=c("row","feature"), 
                     row.names=1,
                     stringsAsFactors=FALSE)
}

load_X <- function(X_file, data_dir) {
  feature_file <- file.path(data_dir, 'features.txt')
  features <- load_features(feature_file)
  data <- read.table(X_file, col.names = features$feature)
}

load_y <- function(y_file) {
  read.table(y_file, col.names = "Activity")
}

load_inertia <- function( type, inertia_parent_dir ) {
  inertia_dir <- file.path( inertia_parent_dir, "Inertial Signals")
  signal_types <- c("body_acc","body_gyro","total_acc")
  axes <- c("x","y","z")
  obs_per_window <- 1:128
  vars <- as.vector(outer(signal_types, axes, paste, sep="_"))
  vars_by_window <- lapply(vars, function(x) paste(x,obs_per_window,sep="_"))
  files <- paste0(vars,'_',type,'.txt')
  file_paths <- file.path( inertia_dir, files)
  #dirty looping...couldn't figure out how to handle vars_by_window in (*)apply
  for ( i in 1:length(files) ) {
    if ( i == 1 ) {
      data <- read.table( file_paths[i], col.names=vars_by_window[[i]] )
    }
    else {
      data <- cbind( data, read.table( file_paths[i], col.names=vars_by_window[[i]]))
    }
  }
  data
}

load_data <- function(type, data_dir) {
  #load type data from type subdirectory of data_dir
  sub_dir <- file.path(data_dir,type)
  
  subject_file <- file.path( sub_dir, paste0('subject_', type, '.txt') )
  X_file <- file.path(sub_dir, paste0('X_', type, '.txt') )
  y_file <- file.path( sub_dir, paste0('y_',type,'.txt') )
  
  subject <- load_subject(subject_file)
  X <- load_X(X_file, data_dir)
  y <- load_y(y_file)
  
  inertia <- load_inertia( type, sub_dir )

  cbind(subject,X,y,inertia)
}

load_test <- function(data_dir) {
  data <- load_data("test", data_dir)
}

load_train <- function(data_dir) {
  data <- load_data("train", data_dir)
}

load_activities <- function(data_dir) {
  activity_file <- file.path( data_dir, 'activity_labels.txt')
  data <- read.table(activity_file,col.names=c("ActivityCode","Activity"))
}

data_dir <- get_source_data()
# load the data...still not tidy though
raw_test <- load_test(data_dir)
raw_train <- load_train(data_dir)

activities <- load_activities(data_dir)