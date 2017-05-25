# libraries to default lib:
.libPaths()
# [1] "/home/jaakko/R/x86_64-pc-linux-gnu-library/3.2"
# [2] "/usr/local/lib/R/site-library"                 
# [3] "/usr/lib/R/site-library"                       
# [4] "/usr/lib/R/library"  




# t1 <- filter(d7,q26 == 1)



# install.packages('dplyr')
library(dplyr)

# install.packages('data.table')
library(data.table)

# install.packages('rpart')

setwd("/home/jaakko/Documents/2017/avoindata/")

d0 <- read.csv('candidate_answer_data_20170329.csv',sep = ';', stringsAsFactors = F)

d0f <- read.csv('candidate_answer_data_20170329.csv',sep = ';', stringsAsFactors = T)
# d0f <- d1



d1 <- filter(d0f,kunta == 'Kirkkonummi')
d1 <- d0f

head(t(d1[2,]))
d2_c<- as.data.frame(t(d1[1:2,]))


rownames(d2_c)

# 170401: etenkin kuntavaaleissa, FB profiilin perusteella mainostetaan vain tiettyä ehdokasta puolueesta. Nykyisin puolueella melkein koko kirjo ehdokkaita
# puoltaa siis edustuksellista demokratiaa ja puoluekuria vs. jokainen olisi erillinen ehdokas.
d1$ehdokasnumero

d2_176 <- filter(d1,ehdokasnumero %in% c(176,188))
d3<- as.data.frame(t(d2_176)) 


d4 <- d1[,c(1:34)*2+54]

# http://stackoverflow.com/questions/20987295/rename-multiple-columns-by-names

d4b <- d4

colnames(d4) <- paste0("q",c(1:34))
u1 <- unique(d4$q1)
u2 <- as.data.frame(u1)

u2
d5 <- d4

# d5[d5 == "jokseenkin samaa mieltä"] <- "1"
d6 <- d5[!is.na(d5$q33) & d5$q33!="",]
d6 <- d5[!is.na(d5$q2) & d5$q2!="",]

for (i in c(1:34)) {
  d6 <- d6[!is.na(d6[,i]) & d6[,i]!="",]
} 
d7 <- droplevels(d6)
d7$q1

# m1 <- glm(q33 ~ ., data = d7)

# install.packages('randomForest')
library(randomForest)
m2 <- randomForest(q33 ~ ., data=d7, importance=TRUE,
                        proximity=TRUE)


# takes 10 minutes with all data
# down vote
# 
# 
# Based on the discussion in the comments, here's a guess at a potential solution.

# The confusion here arises from the fact that the levels of a factor are an attribute of the variable. Those levels will remain the same, no matter what subset you take of the data, no matter how small that subset. This is a feature, not a bug, and a common source of confusion.
# 
# If you want to drop missing levels when subsetting, wrap your subset operation in droplevels():
# 
# groupA <- droplevels(dataset2[dataset2$order=="groupA",])
# http://stackoverflow.com/questions/13495041/random-forests-in-r-empty-classes-in-y-and-argument-legth-0

# d7 <- droplevels(d6)
# levels(d7$q33)
# levels(d6$q33)
# 
# 
# m2 <- randomForest(q33 ~ ., data=d7, importance=TRUE,
#                    proximity=TRUE)


m2print <- print(m2)

round(importance(m2), 2)


r2 <- round(importance(m2), 2)


r2o <- as.data.frame((names(d4b)))
r2o
t(names(d1))


plot()


install.packages('ggplot2')
library(ggplot)

ggplot(((d7$q23)))
