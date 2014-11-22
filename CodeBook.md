# Code Book
=========

The raw data comes from 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

After running the `retrieveData.R` script or any of the other scripts (they all call `retrieveData.R`), you will have a local copy of this data set. There is an import README for
the raw data that can be accessed in `data/UCI HAR Dataset/README.txt`. You should read that if you want to understand the data before it passes through `retrieveData.R`.

# Raw Data

After running `retrieveData.R`, you will have `raw_test`, `raw_train`, and `activities` data in
your workspace, as well as `data_dir` where your data was saved.

* `activities` is a a data.frame of a numeric `ActivityCode` matched with an `Activity`
* `raw_train` is data for the training set of data. Each row corresponds to an observation
  of a `subject` performing an activity marked with its `ActivityCode` along with many 
  measurements of the wearable computing sensors. These measurements are explicitly described
  in the previously mentioned `data/UCI HAR Dataset/README.txt`. I could not explain exactly
  what these variables are without plagiarizing that document, so you should just look there.
* `raw_test` has the same variables as `raw_train` but for the test set of subjects.
  
# Run Analysis

These are the steps taken by `run_analysis.R`.

* Merge the training and test data. They are have the same variables for different subjects, 
  and `subject` is already a variable, so we just stack them with `rbind`.
* The measured variables are derived from observation time windows, so each observation 
  corresponds to multiple time readings of sensors. The second step we took was to select
  only the variables that are means (include `mean()` in the variable name) or standard
  deviations (include `std()`). Some might include the `meanFrequency` on the Fourier-transformed
  data; `run_analysis.R` does not do that, but there is a commented out line that can 
  be uncommented to handle that.
* Replace the activity codes in the data with the names of the actual activity by merging with
  the `activities` data.frame on the shared column `ActivityCode`.
* The next step is to make sure the variables have appropriate names. We read in the variable
  names along with the variables themselves at the same point in `retrieveData.R`, so 
  there is nothing to add here. The variables are descriptive of the methods described in
  the source `data/UCI HAR Dataset/README.txt`.
* Finally, we produce a tidy data set that groups by `subject` and `Activity` and reports the
  mean of each of the features in those groups. Note that there could be disagreement about
  whether the columns contain variable values (and hence the data is not tidy).
  For example, it's possible that X, Y, Z can be interpreted as variable values. Thus, a new
  variable (column) Dimension could be added with
  value X, Y, Z, and then the features in a row correspond to a single dimension.
  Similarly, mean() and std() can be put int a variable SummaryType. 
  I haven't done these operations because I see these as measuring essentially different things.
  Is the value of body acceleration in the X direction a separate observation from the 
  acceleration in the Y direction? I think they are not, although I realize that I am not
  an expert on how exactly to interpret the raw data. I think body acceleration, like the
  other variables, is a single entity that must be observed in a triple of (X,Y,X) coordinates.
  They cannot be observed independently of each other. Similarly, taking a mean or a standard
  deviation over the window of observations are not separate observations of the same thing;
  they are measuring essentially different things.
  

# Generating Output

The script `run_analysis.R` can load the data into your workspace. If you want to save it for
later, see `writeOut.R` (although it will regenerate you analysis too). To read it back in
after running `writeOut.R`, call

    data <- read.table('dataForSubmission.txt', header=TRUE)



