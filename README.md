## Required libraries
There are two required libraries in order to make run_analysis.R work, they
are:

* data.table
* dplyr

So to make absolutely sure that they are installed please run:
* install.packages("data.table")
* install.packages("dplyr")

## Configuring
There are some variables that can be tweaked in order to change some of the
behavior of the program, in particular you can change the data folder, and the
output file.

+ datafolder: Where will the data be downloaded and extracted
+ datazip: The name of the downloaded file
+ outputfile: The name of the output file with the tidy data
+ url: Address of the dataset
+ datafiles: This is the name of the folder where the data is extracted, _I
don't recommend changing this_

All of this files and folder are in a relative path of the current working
directory.

## Execution
When running run_analysis.R the data will be downloaded into datafolder
(only once), and then extracted into datafiles. No further interaction should
be needed, at the end the tidy dataset should be located (_by default_) in
tidydata.csv in the working directory (the output will not be saved in the datafolder)
