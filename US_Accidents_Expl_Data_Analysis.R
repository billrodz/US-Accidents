# Exploratory Data Analysis
library(tidyverse)
library(ggplot2)

# NOTE: by default reads the down_sampled 200k rows
accidents <- readRDS("Data/sample_USAccidents_June20.rds")

# str(object = accidents)
# summary(object = accidents)

percent_NA <- function(column){ 
  mean( is.na ( column ))
  }

percent_na_vector <- unlist(lapply(accidents, FUN = percent_NA))
sort(percent_na_vector)



accidents$Severity <- as.factor(accidents$Severity)
accidents$Side <- as.factor(accidents$Side)
accidents$City <- as.factor(accidents$City)
accidents$County <- as.factor(accidents$County)
accidents$State <- as.factor(accidents$State)
accidents$Zipcode <- as.factor(accidents$Zipcode)
accidents$Country <- as.factor(accidents$Country)
accidents$Wind_Direction <- as.factor(accidents$Wind_Direction)
accidents$Wind_Direction <- as.factor(accidents$Weather_Condition)

hist(x = accidents$Start_Lat)
hist(x = accidents$Start_Lng)

hist(x = accidents$`Temperature(F)`)

hist(x = accidents$`Humidity(%)`)
barplot(table(accidents$`Humidity(%)`))
hist(x = accidents$`Pressure(in)`, breaks = 10)
barplot(table(accidents$`Pressure(in)`))
hist(x = accidents$`Visibility(mi)`)
barplot(table(accidents$`Visibility(mi)`))

new_plot <- ggplot(data = accidents,mapping = aes(x = Severity, 
                                                       y = Side)) +
  geom_count()

other_plot <- ggplot(data = accidents, mapping = aes(x = Country, 
                                                          y =Severity )) +
  geom_count()

this_plot <- ggplot(data = accidents, mapping = aes(x = Severity, 
                                                         y = Wind_Direction)) +
  geom_count()

one_more_plot <- ggplot(data = accidents, mapping = aes(x = Severity, 
                                                             y = Weather_Condition)) +
  geom_count()

# Removing NAs from dataframe
df_no_na <- na.omit(object = accidents)

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


