# Rebalance Model 

# Small Logistic Regression Model

library(caret)

# Importing Data 

processed_accidents <- readRDS(file = "Data/processed_accidents.rds")

# Check Severity Binary Column for class bias

table(processed_accidents$Severity_Binary)

# Quite unbalanced data with 193679 accidents of low severity and 6321 
# accidents of high severity 

# NOTE Changed Severity to be 3 or 4 instead of just 4. 
# NEW balance: 63,130 vs 136870. 

processed_accidents$Severity_Binary <- as.factor(
  processed_accidents$Severity_Binary)


feature_selected_accidents <- processed_accidents[
  ,c("Start_Lat", "Weather_Weekday_Weekend","Thunder","Rain","Snow",
     "Severity_Binary")]

feature_selected_accidents$Start_Lat <- as.numeric(
  feature_selected_accidents$Start_Lat)
feature_selected_accidents$Weather_Weekday_Weekend <- factor(
  x = feature_selected_accidents$Weather_Weekday_Weekend,
  levels = c("Weekday","Weekend"))

set.seed(4)
training_index <- sample(1:nrow(feature_selected_accidents),
                        size = floor(0.7*nrow(feature_selected_accidents)),
                        replace = FALSE)

training_data <- feature_selected_accidents[training_index, ]
test_data <- feature_selected_accidents[-training_index, ]

# NOTE: only 4,425 High Severity cases out of 140,000
# Will oversample these to match 135,575 non-severe.

# NOTE: with re-do to 3 and 4, now it is 44419 (1) to 95581 (0)
table(training_data$Severity_Binary)

oversample_1_index <- sample(1:nrow(
  training_data[training_data$Severity_Binary == 1, ]))

train_1 <- training_data[training_data$Severity_Binary == 1, ][oversample_1_index, ]

training_data_balanced <- na.omit( 
  rbind(train_1, 
        training_data[training_data$Severity_Binary == 0, ]))

log_model <- glm(formula = Severity_Binary ~ Snow + 
      Rain + Thunder + Weather_Weekday_Weekend + Start_Lat, 
    family = binomial(link = "logit"), 
    data = training_data_balanced)

test_data_na_omitted <- na.omit(test_data)
log_pred <- predict.glm(object = log_model, newdata = test_data_na_omitted,
                        type = "response")

truly_severe <-  test_data_na_omitted$Severity_Binary 
predicted_severe <- as.factor( as.numeric ( log_pred > 0.3) )

confusionMatrix(data = predicted_severe, reference = truly_severe)
