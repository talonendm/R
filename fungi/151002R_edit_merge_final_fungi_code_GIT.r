
# ...

# ******************************************************************************** 5) KUVIEN AVAUS

# kuvat <- list.files(R.home())
kuvat <- list.files('C:/Users/JT5/Pictures/2015-09-22 _')
#kuvat2 <- as.data.frame(kuvat)
#kuvat2
kuvat3 <- as.data.frame(sapply(kuvat, function(x) gsub("#...\\.JPG", "", x)))
head(kuvat3)
kuvat3
kuvat3$file <- kuvat
names(kuvat3)[2] <- 'file'
names(kuvat3)[1] <- 'la'
head(kuvat3)

# poistetaan _ viivat nimistä, ennen yhdistämistä
kuvat3$la <- gsub("_"," ",kuvat3$la)
kuvat3 

# FI nimen mukaan näin:
kuvat4 <- kuvat3
names(kuvat4)[1] <- 'fi'
head(kuvat4,5)

# ******************************************************************************** 5.1) KUVADATAN YHDISTYS DATAAN

# kaikki kuvat, myös ne joita ei tunnistettu
# 
dataF5_allpics <- merge(kuvat3 ,dataF3 ,by = "la", all.x = TRUE)  # KUVA ALL
dataF5_alldata <- merge(kuvat3 ,dataF3 ,by = "la", all.y = TRUE)  # DATA ALL
# dataF5_1 <- dataF3
# sienet, jotka on tunnistettu - aluksi tämä.. INNER JOIN, ELI KUVALLISET VAAN MESSSIIN



dataF5_1 <- merge(kuvat3 ,dataF3 ,by = "la")
dataF5_1

dataF5_1_by_FI <- merge(kuvat4 ,dataF3 ,by = "fi")
dataF5_1_by_FI


dataF5_2<- dataF5_1

dataF5_2<- rbind(dataF5_1,dataF5_1_by_FI)
dataF5_2

# ******************************************************************************** 6) Basic statistics

dataF6 <- dataF5_2
head(dataF6)
# toimii: mutta tyylikkäämmin tossa alla
# dataF6$taste <- (dataF5_2$maku + dataF5_2$Kmaku)/2;

# ei näin!
# dataF6$taste_range <- range(dataF5_2$maku , dataF5_2$Kmaku, na.rm = FALSE) # tää voi na.rm voi olla hyödyllinen
# apply(test[,c(1,2)], 1, function(x) mean(x) )

dataF6$taste_ma <- apply(dataF6[,c('maku','Kmaku')], 1, function(x) mean(x,na.rm = TRUE) )
dataF6$taste_ma2 <- round((dataF6$taste_ma + 0)/3*9) - 2*is.na(dataF6$Kkauppasieni) +1
dataF6$taste_std <- apply(dataF6[,c('maku','Kmaku')], 1, function(x) sd(x,na.rm = TRUE) )
head(dataF6,20)

dataF6

setwd('C:/Dropbox/2015processing/data_processed_final')
write.csv(dataF6, file = "fungiRpicsDataIn15XXXX.csv") # write.csv(dataF6, file = "fungiRpicsDataIn151002.csv")
write.csv(dataF5_allpics, file = "fungiRallpicsIn15XXXX.csv") # write.csv(dataF5_allpics, file = "fungiRallpicsIn151002.csv")
write.csv(dataF5_alldata, file = "fungiRallDataIn15XXXX.csv") # write.csv(dataF5_alldata, file = "fungiRallDataIn151002.csv")

