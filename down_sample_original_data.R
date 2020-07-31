# This is a load-prep script, it reads the data and writes it to a faster 
# to load .rds object to preserve the raw form, while making full-reruns faster. 
library(tidyverse)

set.seed(4)
exploratory_df <- read_csv(file = "Data/US_Accidents_June20.csv")
sample_size <- 200000
sample_selection <- sample(1:nrow(exploratory_df),
                          size = sample_size,replace = FALSE)

saveRDS(object = exploratory_df[sample_selection, ],
        file = "Data/sample_USAccidents_June20.rds")
