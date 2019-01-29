setwd("E:/UTD Spring 2018/Course Content/Data Visualization/Data Sets/Prapti/Data Set/Extra file")
library(readxl)

person <- read.csv("person_extract.csv")
head(person)
personrand <- person

# rand <- runif(nrow(person))

# personrand <- person[order(rand), ]
head(personrand)

# personrand <- personrand[1:5000,]

# mean rest_use
# meanrest_use<- sum(na.omit(person$REST_USE))/length(na.omit(person$REST_USE))
# meanrest_use

# put age as meanage for the empty cells
# person$REST_USE[is.na(person$REST_USE)] <- meanrest_use
# View(person)
# person$REST_USE<- round(person$REST_USE)






# make age as categorical variable
personrand$AgeCat[personrand$AGE >= 0 & personrand$AGE <= 16 ] <- "0-16"
personrand$AgeCat[personrand$AGE >= 17 & personrand$AGE <= 32 ] <- "17-32"
personrand$AgeCat[personrand$AGE >= 33 & personrand$AGE <= 48 ] <- "33-48"
personrand$AgeCat[personrand$AGE >= 49 & personrand$AGE <= 64 ] <- "49-64"
personrand$AgeCat[personrand$AGE >= 65 ] <- "65 and Above"

personrand.scaled <- scale(data.frame(personrand$AGE,personrand$DRINKING, personrand$DRUGS))
colnames(personrand.scaled)
totwss <- vector()
btwss <- vector()

for (i in 2:15){
  set.seed(1234)
  temp <- kmeans(personrand.scaled, centers = i)
  totwss[i] <- temp$tot.withinss
  btwss[i] <- temp$betweenss
}

plot(totwss,xlab = "Number of clusters", type = "b", ylab = "Total within Sum of Square")
plot(btwss,xlab = "Number of clusters", type = "b", ylab = "Total within Sum of Square")

person_updated <- personrand


write.csv(person_updated, file = "person_updated.csv")

# install.packages("Rserve")
library(Rserve)
Rserve()

