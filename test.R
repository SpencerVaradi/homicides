m <- leaflet(states)
mapStates <- map("state", region = c('alaska'), fill = TRUE, plot = FALSE)
leaflet(data = mapStates) %>%addTiles() %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)

filteredHomicides <- function(){homicides}
freqStateWeapon <- melt(table(filteredHomicides()$State, filteredHomicides()$Weapon))
names(freqStateWeapon) <- c("State","Weapon","Frequency")
dcast(freqStateWeapon, State + Weapon ~ Frequency, sum)
maxMurders <- aggregate(Frequency ~ State, data = freqStateWeapon, max)
maxMurders <- merge(maxMurders, freqStateWeapon, by = c("State","Frequency"))



names(freqYearWeapon) <- c("Year","Weapon","Frequency")

leaflet
