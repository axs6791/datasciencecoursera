# Summarized Human Activity Recognition Using Smartphones Dataset

This script takes data from the [Human Activity Recognition Using Smartphones Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip),
and creates a derivative tidy dataset. The new data set is laid out as follows

## Variables

1. Source: A numeric identifier for each one of the individuals that volunteered
   for the study. Values at the time of this commit range from 1-30, but depend
   on the input data.
2. Activity: A string that describes the type of activity. These labels are
   described as part of the source data (activity_labels.txt file). Some
   examples are WALKING and SITTING.
3. The remaining variables are picked up programatically from the source
   dataset. We are interested in variables that are means and standard
   deviations, and we use regular expressions to find such columns. The source
   dataset lists the variable names in the file features.txt.

## Rows

Each row corresponds to the mean of the mean and standard deviation measurments (variables)
for a volunteer performing an activity. For instance, a row may be for individual (source) 13
performing the SITTING activity.

## Script

run_analysis.R acquires the source data, and generates the tidy dataset as described above.
In summary, it perfroms the following steps:
1. Download and decompress the source data.
2. Load test and train dataframes.
3. Compute mean and standad deviation columns, and remove all other columns from
   the test and train dataframes.
4. Join the test and trains dataframes into the whole dataframe.
5. Add meaningful column names to the whole dataframe.
6. Transforms the whole dataframe, by grouping by source and activity, and
   sumarizing all the other variables using the mean() operation.
7. Load the activity labels dataframes, and transforms the activity column from
   integer represenatation to string representation.
8. Write whole dataframe to tidyData.txt

## Output
Running run_analysis.R creates the tidyData.txt data file with the summarized data.

## Codebook
The [codebook](./codebook.md) included in the repo was generated with [dataMaid](https://cran.r-project.org/web/packages/dataMaid/index.html). 
