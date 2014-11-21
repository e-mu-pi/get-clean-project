source("run_analysis.R")
write.table(data,
            file = "dataForSubmission.txt",
            row.names = FALSE)