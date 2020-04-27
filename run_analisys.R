library(dplyr)

actdescription <- function(x) {
    #this function takes the activity label and returns the activity string 
    #the purpose is to convert a numeric variable into a descriptive variable
    
    if (x == 1) {
        "WALKING"
    } else if (x == 2) {
        "WALKING UPSTAIRS" 
    } else if (x == 3) {
        "WALKING DOWNSTAIRS"
    } else if (x == 4) {
        "SITTING"
    } else if (x == 5) {
        "STANDING"
    } else if (x == 6) {
        "LAYING"
    }
    
}

extractvector <- function(df,f) {
    #From a data frame given (df) and a function (f), it processes each row with
    #the function given (in this project, mean or sd) and returns a vector whose
    #length is the number of rows of df and each element is the result of f in 
    #each row.
    #eg. extractvector(df, mean) is equivalent to rowMeans(df)

    vector <- numeric(0)
    for (i in 1:nrow(df)) {
        vector <- c(vector, f(as.numeric(df[i,])))
    }
    vector
}

extractdata <- function(instr, estr) {
    #This function extracts the data from a directory (test or train) and returns
    #a data frame (df) with the with the required tidy tidy data from the 
    #directory. 
    #It is useful because the paths are similar excepting the strings 
    #given as arguments (instr: initial path's string, estr: end of path's string),
    #so it exents from typing almost the same code twice.
    
    #The following 2 lines extract vector of subject
    subjectdf <- read.table(paste0(instr,"subject",estr))
    subjectVector <- subjectdf[,1]
    
    #The following 2the activity vector as a desctiptive vector thanks 
    #to the function actdescription
    actdf <- read.table(paste0(instr,"y", estr))
    actVector <- sapply(actdf[,1], actdescription)
    
    #The following 27 code lines in 9 blocks of 3 lines. In each block:
    #1. Extracts the data of one file as a data frame
    #2. Calculates the mean of the rows and stores it in a vector
    #3. Calculates the standard deviation of the rows and stores it in a vector
    body_acc_x_df <- read.table(paste0(instr,"Inertial Signals/body_acc_x", estr))
    body_acc_x_meanVector <- rowMeans(body_acc_x_df)
    body_acc_x_sdVector <- extractvector(body_acc_x_df, sd)
    
    body_acc_y_df <- read.table(paste0(instr,"Inertial Signals/body_acc_y", estr))
    body_acc_y_meanVector <- rowMeans(body_acc_y_df)
    body_acc_y_sdVector <- extractvector(body_acc_y_df, sd)
    
    body_acc_z_df <- read.table(paste0(instr,"Inertial Signals/body_acc_z", estr))
    body_acc_z_meanVector <- rowMeans(body_acc_z_df)
    body_acc_z_sdVector <- extractvector(body_acc_z_df, sd)
    
    body_gyro_x_df <- read.table(paste0(instr,"Inertial Signals/body_gyro_x", estr))
    body_gyro_x_meanVector <- rowMeans(body_gyro_x_df)
    body_gyro_x_sdVector <- extractvector(body_gyro_x_df, sd)
    
    body_gyro_y_df <- read.table(paste0(instr,"Inertial Signals/body_gyro_y", estr))
    body_gyro_y_meanVector <- rowMeans(body_gyro_y_df)
    body_gyro_y_sdVector <- extractvector(body_gyro_y_df, sd)
    
    body_gyro_z_df <- read.table(paste0(instr,"Inertial Signals/body_gyro_z", estr))
    body_gyro_z_meanVector <- rowMeans(body_gyro_z_df)
    body_gyro_z_sdVector <- extractvector(body_gyro_z_df, sd)
    
    total_acc_x_df <- read.table(paste0(instr,"Inertial Signals/total_acc_x", estr))
    total_acc_x_meanVector <- rowMeans(total_acc_x_df)
    total_acc_x_sdVector <- extractvector(total_acc_x_df, sd)
    
    total_acc_y_df <- read.table(paste0(instr,"Inertial Signals/total_acc_y", estr))
    total_acc_y_meanVector <- rowMeans(total_acc_y_df)
    total_acc_y_sdVector <- extractvector(total_acc_y_df, sd)
    
    total_acc_z_df <- read.table(paste0(instr,"Inertial Signals/total_acc_z", estr))
    total_acc_z_meanVector <- rowMeans(total_acc_z_df)
    total_acc_z_sdVector <- extractvector(total_acc_z_df, sd)
    
    df <- data.frame( 
        # once the data is stored in vectors, df can be created
        subject = subjectVector,
        activity = actVector,
        body_acc_x_mean = body_acc_x_meanVector,
        body_acc_x_sd = body_acc_x_sdVector,
        body_acc_y_mean = body_acc_y_meanVector,
        body_acc_y_sd = body_acc_y_sdVector,
        body_acc_z_mean = body_acc_z_meanVector,
        body_acc_z_sd = body_acc_z_sdVector,
        body_gyro_x_mean = body_gyro_x_meanVector,
        body_gyro_x_sd = body_gyro_x_sdVector,
        body_gyro_y_mean = body_gyro_y_meanVector,
        body_gyro_y_sd = body_gyro_y_sdVector,
        body_gyro_z_mean = body_gyro_z_meanVector,
        body_gyro_z_sd = body_gyro_z_sdVector,
        total_acc_x_mean = total_acc_x_meanVector,
        total_acc_x_sd = total_acc_x_sdVector,
        total_acc_y_mean = total_acc_y_meanVector,
        total_acc_y_sd = total_acc_y_sdVector,
        total_acc_z_mean = total_acc_z_meanVector,
        total_acc_z_sd = total_acc_z_sdVector
    )
    df
}

#Main code below
pathtest <- "UCI HAR Dataset/test/" #string of the begining of test directory path, for less typing
pathtrain <- "UCI HAR Dataset/train/" #string or the begining of train directory path, idem
endtest <- "_test.txt" #string of the end of test's files paths
endtrain <- "_train.txt" #string of the end of train's files paths

#In the following 3 lines, test and train are extracted and merged
testdf <- extractdata(pathtest,endtest)
traindf <- extractdata(pathtrain, endtrain)
totaldf <- union(testdf,traindf)

#Step 5 is solved in the following 5 lines. 
tidymeansdata <- totaldf %>% 
    select("subject","activity", contains("mean")) %>%
    arrange(subject) %>%
    group_by(subject, activity) %>%
    summarise_all(mean)

#Required text file is created for submit
write.table(tidymeansdata, "dataset.txt", row.names = FALSE)
