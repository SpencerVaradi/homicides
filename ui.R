
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

dashboardPage(
  # Application title
  dashboardHeader(title = "US Murders"),
  dashboardSidebar(
    sideMenu,
    # Controls
    sliderInput("yearRange", "Year Range", min = range(homicides$Year)[1], max = range(homicides$Year)[2], value = c(range(homicides$Year)[1], max = range(homicides$Year)[2]), sep = "", step = 1),
    p("Looks like a wash? Pick some values to remove from analysis:"),
    selectizeInput("rmWeapons", label = "Remove Weapons", choices = unique(homicides$Weapon), multiple = TRUE),
  selectizeInput("rmRelationships", label = "Remove Relationships", choices = unique(homicides$Relationship), multiple = TRUE),
  checkboxGroupInput("solved", "Solved", choices = unique(homicides$Crime.Solved), selected = unique(homicides$Crime.Solved))),

    # Show a plot of the generated distribution
    dashboardBody(
      body
    )
  )
