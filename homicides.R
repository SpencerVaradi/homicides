library(ggmap)
library(plyr)
library(reshape2)
homicides <- read.csv("data/homicides.csv", sep= ",", header = TRUE)
names(homicides)
unique()
hist(homicides$Perpetrator.Count)
homicides$cityState <- paste(homicides$City, homicides$State, sep = ", ")
homicides <- merge(homicides, locCoords, by.y = "uniqueLoc", by.x = "cityState", all.x = TRUE)

saveRDS(homicides, "data/homicides.rds")
uniqueLoc <- unique(homicides$cityState)
locCoord <- geocode(uniqueLoc, source = "dsk", output = "more", client = "123", signature = "123")
locCoords <- cbind(uniqueLoc, locCoord)
write.csv(locCoords, "data/locCoords.csv")

# df <- homicides[runif(1000,1,3042),]
freqStateYear <- count(homicides, vars = c("cityState", "Year"))
years <- c("1999","2000")
filteredYear <- freqStateYear[freqStateYear$Year %in% years,]
summed <- aggregate(freq ~ cityState, filteredYear, sum)


countries <- c("USA", "United States")
summed <- merge(summed, locCoords, by.y = "uniqueLoc", by.x = "cityState", all.x = TRUE)
filteredSummed <- summed[summed$country %in% countries,]

circleWeight <- 100
homicideMap <- leaflet(filteredSummed) %>% addTiles() %>%
  addCircles(lng = ~lon, lat = ~lat, weight = 1, radius = ~freq*circleWeight, popup = ~cityState)


sliderInput(inputId = yearRange, "Year Range", min = 1980, max = )


cityPop <- read.csv("data/sub-est2015_all.csv", header = TRUE, sep = ",")
cityPop$cityState <- paste(cityPop$NAME, cityPop$STNAME, sep = ", ")

sum(cityPop$cityState %in% uniqueLoc)
