# libraries to default lib:
.libPaths()
# install.packages('googleAnalyticsR')


# install.packages('curl')
# http://stackoverflow.com/questions/20671814/non-zero-exit-status-r-3-0-1-xml-and-rcurl
# in terminal: sudo apt-get install libcurl4-openssl-dev libxml2-dev
# install.packages('httr')

library(googleAnalyticsR)


# ADDED cd talonendm; cd R; git add .
# TO COMMIT: git commit -m '170521 Samsung AnalyticsR fixed' talonendm/R/GoogleAnalytics170521.R


# SAVE FILE and Run this command:
# git commit -m '170521 Samsung AnalyticsR fixed' ~/talonendm/R/GoogleAnalytics170521.R
#
# 
# 

# Git not working this way
# a <- system("git commit -m '170521 Samsung AnalyticsR fixed' ~/talonendm/R/GoogleAnalytics170521.R")

# b <- system("git push origin master")
t1 <- try(system("who", intern = TRUE))
