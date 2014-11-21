source("run_analysis.R")
write.table(tidy_data,
            file = "dataForSubmission.txt",
            row.names = FALSE)