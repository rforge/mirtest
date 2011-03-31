if(!("roxygen" %in% installed.packages()[,1])) install.packages("roxygen",repos="http://cran.r-project.org")
library(roxygen)
package.skeleton("miRtest",code_files="miRtest.R",force=TRUE)



