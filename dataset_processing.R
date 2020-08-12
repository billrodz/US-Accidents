# Data Pre-Processing ----
  #' We're going to assess data that we want to keep, perform some 
  #' feature engineering and save the dataset for modeling. 

library(lubridate)



accidents <- readRDS("Data/sample_USAccidents_June20.rds")

#' Checking Length of Accidents because documentation states that is 
#' how severity is measured. 

## Length of Accident (minutes)

accidents["Length of Delay (mins)"] <- as.numeric (
  accidents$End_Time - accidents$Start_Time
  )

# ordering by length of delay
accidents <- accidents[order(accidents$`Length of Delay (mins)`,
                             decreasing = TRUE), ]


# Correlation is oddly low, Severity is defined as: 
#' hows the severity of the accident, a number between 1 and 4,
#'  where 1 indicates the least impact on traffic (i.e., 
#'  short delay as a result of the accident) and 4 indicates
#'   a significant impact on traffic (i.e., long delay).

cor(accidents$`Length of Delay (mins)`,accidents$Severity)

# top coding length of delays to 1 entire day 1,440 minutes.
table(accidents$`Length of Delay (mins)` > 1440) 

table(accidents$`Length of Delay (mins)` > 1440)/
  length(accidents$`Length of Delay (mins)`) * 100

1440 -> accidents$`Length of Delay (mins)`[(
  accidents$`Length of Delay (mins)` > 1440)] 

# correlation is still low
cor(accidents$`Length of Delay (mins)`,accidents$Severity)


# Selecting Columns that are available prior to accidents (i.e. for prediction)
# or desired for specific EDA or visualization

desired_columns <- c( 
  "Severity","Start_Lat","Start_Lng",                   
  "City","County", "State", "Zipcode", "Timezone",
  "Temperature(F)","Humidity(%)","Pressure(in)",
  "Visibility(mi)","Wind_Speed(mph)","Precipitation(in)",
 "Weather_Timestamp", "Weather_Condition", "Sunrise_Sunset"
  )

accidents_select <- accidents[ , desired_columns]


# Time Features ---- 

# Function to convert Weather Timestamp to Day of the Week 

# Function to convert Weather Timestamp to Weekday OR Weekend 


# Weather Features ----

# The Weather Condition Column has the following unique words used 
# unique_weathers <- unique(accidents$Weather_Condition)
# weather_individual_words_list <- strsplit(unique_weathers, split = " ")
# weather_individual_words <- unlist(weather_individual_words_list)
# unique_weather_words <- unique(weather_individual_words)
# 
# unique(unlist(strsplit(x = unique(accidents$Weather_Condition),split = " ")))

# Function to identify if "Thunder" is in the Weather Condition 

# accidents[["Thunder"]] <- grepl(pattern =  "thunder|t-storm",
#                                 x = accidents[["Weather_Condition"]],
#                                 perl = TRUE,
#                                 ignore.case = TRUE)

add_thunder <- function(accidents_dataset, 
                        weather_column = "Weather_Condition"){
  #' This function accepts a data frame with a character indicating which 
  #' column is the weather column. It searches the column for 
  #' appearance of Thunder or T-Storm (this also captures "thunderstorm",
  #' "thunderstorms", etc.) Capitalization is ignored. 
  #' It returns the dataset with a new column: "Thunder"
  
  pattern <- "thunder|t-storm"
  thunder_found <- grepl(pattern = pattern,
         x = accidents_dataset[[weather_column]],
         perl = TRUE,
         ignore.case =  TRUE)
  
  accidents_dataset[["Thunder"]] <- as.numeric(thunder_found)
  return(accidents_dataset)
  
  }

accidents <- add_thunder(accidents)

# Function to identify if "Rain" is in the Weather Condition 

# Function to identify if "Snow" is in the Weather Condition

# NOTE: Some columns will be removed in modeling and haven't been engineered

# Alter Severity to be binary - < 3 or 3+ (call it Low and High) 
  # MAKE SURE the levels are Low = 0, and High = 1 !!!! 

# SAVE THE FINAL DATASET - accidents_for_modeling
