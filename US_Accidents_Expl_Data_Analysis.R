# Exploratory Data Analysis
library(tidyverse)
library(dplyr)
library(ggplot2)

exploratory_df <- read_csv(file = "Data/US_Accidents_June20.csv")

str(object = exploratory_df)
summary(object = exploratory_df)

# Dropping col w/ greater than ~500,000 missing observations of the 3.5 million
exploratory_df <- select(.data = exploratory_df, -c("TMC", 
                                                    "End_Lat",
                                                    "End_Lng",
                                                    "Number",
                                                    "Wind_Chill(F)",
                                                    "Wind_Speed(mph)",
                                                    "Precipitation(in)"))

exploratory_df$Severity <- as.factor(exploratory_df$Severity)
exploratory_df$Side <- as.factor(exploratory_df$Side)
exploratory_df$City <- as.factor(exploratory_df$City)
exploratory_df$County <- as.factor(exploratory_df$County)
exploratory_df$State <- as.factor(exploratory_df$State)
exploratory_df$Zipcode <- as.factor(exploratory_df$Zipcode)
exploratory_df$Country <- as.factor(exploratory_df$Country)
exploratory_df$Wind_Direction <- as.factor(exploratory_df$Wind_Direction)
exploratory_df$Wind_Direction <- as.factor(exploratory_df$Weather_Condition)

hist(x = exploratory_df$Start_Lat)
barplot(table(exploratory_df$Start_Lat))
hist(x = exploratory_df$Start_Lng)
barplot(table(exploratory_df$Start_Lng))
hist(x = exploratory_df$`Temperature(F)`)
barplot(table(exploratory_df$`Temperature(F)`))
hist(x = exploratory_df$`Humidity(%)`)
barplot(table(exploratory_df$`Humidity(%)`))
hist(x = exploratory_df$`Pressure(in)`, breaks = 10)
barplot(table(exploratory_df$`Pressure(in)`))
hist(x = exploratory_df$`Visibility(mi)`)
barplot(table(exploratory_df$`Visibility(mi)`))

new_plot <- ggplot(data = exploratory_df,mapping = aes(x = Severity, 
                                                       y = Side)) +
  geom_count()

other_plot <- ggplot(data = exploratory_df, mapping = aes(x = Country, 
                                                          y =Severity )) +
  geom_count()

this_plot <- ggplot(data = exploratory_df, mapping = aes(x = Severity, 
                                                         y = Wind_Direction)) +
  geom_count()

one_more_plot <- ggplot(data = exploratory_df, mapping = aes(x = Severity, 
                                                             y = Weather_Condition)) +
  geom_count()

# Removing NAs from dataframe
df_no_na <- na.omit(object = exploratory_df)

hist(x = df_no_na$Start_Lat)
barplot(table(df_no_na$Start_Lat))
hist(x = df_no_na$Start_Lng)
barplot(table(df_no_na$Start_Lng))
hist(x = df_no_na$`Temperature(F)`)
barplot(table(df_no_na$`Temperature(F)`))
hist(x = df_no_na$`Humidity(%)`)
barplot(table(df_no_na$`Humidity(%)`))
hist(x = df_no_na$`Pressure(in)`, breaks = 10)
barplot(table(df_no_na$`Pressure(in)`))
hist(x = df_no_na$`Visibility(mi)`)
barplot(table(df_no_na$`Visibility(mi)`))

otherer_plot <- ggplot(data = df_no_na, mapping = aes(x = Severity, 
                                                          y = `Visibility(mi)`)) +
  geom_point()

otherest_plot <- ggplot(data = df_no_na, mapping = aes(x = Severity, 
                                                      y = `Visibility(mi)`)) +
  geom_boxplot()

new_plot <- ggplot(data = df_no_na,mapping = aes(x = Severity, 
                                                       y = `Pressure(in)`)) +
  geom_point()

that_plot <- ggplot(data = df_no_na, mapping = aes(x = Severity, 
                                                         y = Wind_Direction)) +
  geom_count()

another_plot <- ggplot(data = df_no_na, mapping = aes(x = `Visibility(mi)`, 
                                                      y = `Humidity(%)`)) +
  geom_point()


