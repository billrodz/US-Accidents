# Small Logistic Regression Model

library(caret)

# Importing Data 

processed_accidents <- readRDS(file = "Data/processed_accidents.rds")

# Check Severity Binary Column for class bias

table(processed_accidents$Severity_Binary)

# Quite unbalanced data with 193679 accidents of low severity and 6321 
# accidents of high severity 

processed_accidents$Severity_Binary <- as.factor(processed_accidents$Severity_Binary)

# Create Training Data


input_ones <- processed_accidents[processed_accidents$Severity_Binary == 1, ]
input_zeros <- processed_accidents[processed_accidents$Severity_Binary == 0, ]

#Set seed for reproducibility
set.seed(seed = 10)

input_ones_training_rows <- sample(1:nrow(input_ones), 
                                   floor ( 0.7*nrow(input_ones)) )
input_zero_training_rows <- sample(1:nrow(input_zeros), 
                                   floor ( 0.7*nrow(input_ones)))

training_ones <- input_ones[input_ones_training_rows,]
training_zeros <- input_zeros[input_zero_training_rows,]
training_data <- rbind(training_ones, training_zeros)

# Create Test Data

test_ones <- input_ones[-input_ones_training_rows,]
test_zeros <- input_zeros[-input_zero_training_rows,]
test_data <- rbind(test_ones, test_zeros)

# Determine input variables
# Using random forest?? 
# Using Information values??


# Logistic Regression Model 
logit_mod <- glm(formula = Severity_Binary ~ Snow + 
                   Rain + Thunder + Weekday_of_Weather, 
                 family = binomial(link = "logit"), 
                 data = 
                   na.omit(
                     training_data[ , c("Weekday_of_Weather", "Thunder",
                                      "Rain", "Snow", "Severity_Binary" ) ])
                 )


# Predicted Scores
predicted <- plogis(predict(logit_mod, test_data))
predicted_severity <- predict.glm(object = logit_mod,
                                  newdata = 
                                    na.omit(
                                      test_data[ , 
                                                 c("Weekday_of_Weather",
                                                   "Thunder",
                                                   "Rain",
                                                   "Snow", 
                                                   "Severity_Binary" ) ]),
                                  type = "response")
predicted_severity_binary <- as.numeric(predicted_severity > 0.5)
predicted_severity_binary <- factor(predicted_severity_binary, levels = c(0,1))
true_severity <-  na.omit(
  test_data[ , c("Weekday_of_Weather",
               "Thunder",
               "Rain",
               "Snow", 
               "Severity_Binary") ])
true_severity <- true_severity$Severity_Binary

# Create Confusion Matrix

confusionMatrix(predicted_severity_binary, true_severity)

