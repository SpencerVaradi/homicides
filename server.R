
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  # Filter data based on selected controls
  filteredHomicides <- reactive({homicides[
    homicides$Year %in% input$yearRange[1]:input$yearRange[2] &
    !(homicides$Weapon %in% input$rmWeapons) &
    !(homicides$Relationship %in% input$rmRelationships) &
    homicides$Crime.Solved %in% input$solved &
    homicides$country %in% countries
    ,]
  })

  # Leaflet plots
  output$weaponMap <- renderLeaflet({

  })
  #
  # output$relationshipMap <- renderLeaflet({
  #
  # })


  # Plotly time series graphs
  output$weaponPlot <- renderPlotly({
    # filteredHomicides <- homicides
    freqYearWeapon <- melt(table(filteredHomicides()$Year, filteredHomicides()$Weapon))
    names(freqYearWeapon) <- c("Year","Weapon","Frequency")
    weaponggplot <- ggplot() + geom_area(aes(y = Frequency, x = Year, fill = Weapon),
                                         stat = "identity", data = freqYearWeapon) +
      ggtitle("Number of murders commited each year by weapon used")
    ggplotly(weaponggplot)

  })

  output$relationshipPlot <- renderPlotly({
    # filteredHomicides <- homicides
    freqYearRelationship <- melt(table(filteredHomicides()$Year, filteredHomicides()$Weapon))
    names(freqYearWeapon) <- c("Year","Weapon","Frequency")
    relationshipggplot <- ggplot() + geom_area(aes(y = Frequency, x = Year, fill = Weapon), stat = "identity", data = freqYearRelationship) + ggtitle("Number of murders commited each year by relationship to victim")
    ggplotly(relationshipggplot)

  })

})
