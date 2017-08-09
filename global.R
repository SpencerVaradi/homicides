library(shiny)
library(shinydashboard)
library(shinythemes)
library(dplyr)
library(plotly)
library(leaflet)
library(ggplot2)
library(reshape2)
library(geojsonio)
library(maps)
library(fiftystater)

# Get data
homicides <- readRDS("data/homicides.rds")
# Only care about the US for this
countries <- c("USA", "United States")

sideMenu <- sidebarMenu(
  menuItem("Documentation",tabName = "documentation", icon = icon("book")),
  menuItem("Time Series", tabName = "timeSeries", icon = icon("clock-o")),
  menuItem("Maps", tabName = "maps", icon = icon("map"))
)

# Country Graphs

# Time Series Graphs


# Put together bodies

# tabItems
# docTab
documentation <- div(p("Binge watching 'Criminal Minds' has led me to an interesting body of research utilizing homicide data. While it is rather prelimerary and very good reason has to be provided to gain access to more enriched datasets,"),
                       a("pool of 600k murders (primarily in the US) has been provided by Kaggl", href = 'https://www.kaggle.com/murderaccountability/homicide-reports'),
                       br(),p("This Shiny app allows users to aggregate data and display the results on Leaflet maps and Plotly time series plots. These provide an overview of common trends among these murders. Since some attributes overshadow other elements, some select inputs have been provided to give the user an opportunity to clear out weapons or offendor relationships since those wash out the rest of the results."),p('For more information regarding this data and analysis, please see this presentation and this repository containing the code used in this analysis and application.'),
                       p(' Go to the "Time Series" tab on the left to get started.'))
docTab <- tabItem(tabName = "documentation",
                  fluidRow(
                    box(title = "Documentation", width = 12, solidHeader = TRUE, status = "primary", documentation
                     )))

# mapsTab
mapsTab <- tabItem(tabName = "maps",
                   h2("Maps of Murders (I thought I would have time for this, but I don't. Please enjoy the charts :)"),
                   fluidRow(width = 12,
                    box(width = 12,
                        leafletOutput("weaponMap"))))

# timeSeriesTab
timeSeriesTab <- tabItem(tabName = "timeSeries",
                   h2("How murders changed over time"),
                   # fluidRow(width = 12,
                   #          box( width = 12, title = "Relationship to victim", plotlyOutput("relationshipPlot"))),
                   fluidRow(width = 12,
                            box( width = 12, title = "Weapons used over time", plotlyOutput("weaponPlot")))
                   )
# Whole body
body <- tabItems(
    docTab,
    timeSeriesTab,
    mapsTab
)

