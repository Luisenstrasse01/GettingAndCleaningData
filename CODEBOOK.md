# Functions

## actdescription

arguments: x(numeric)

return: character

this function takes the activity label and returns the activity string 
the purpose is to convert a numeric variable into a descriptive variable

## extractvector

arguments: df(data frame), f(function)

return: nuemric vector

From a data frame given (df) and a function (f), it processes each row with
the function given (in this project, mean or sd) and returns a vector whose
length is the number of rows of df and each element is the result of f in 
each row.
eg. extractvector(df, mean) is equivalent to rowMeans(df)
    
 
## extractdata

arguments: instr(string), estr(string)

return: data frame

This function extracts the data from a directory (test or train) and returns
a data frame (df) with the with the required tidy tidy data from the 
directory. 
It is useful because the paths are similar excepting the strings 
given as arguments (instr: initial path's string, estr: end of path's string),
so it exents from typing almost the same code twice.


# Main Code

pathtest <- "UCI HAR Dataset/test/" #string of the begining of test directory path, for less typing

pathtrain <- "UCI HAR Dataset/train/" #string or the begining of train directory path, idem

endtest <- "_test.txt" #string of the end of test's files paths

endtrain <- "_train.txt" #string of the end of train's files paths

testdf <- data frame with the data of test

traindf <- data frame with the data of train

totaldf <- data frame with the merged data 

tidymeansdata <- meets the tidy data required in step 5

