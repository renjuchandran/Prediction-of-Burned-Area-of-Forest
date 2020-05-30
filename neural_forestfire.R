

fire <- forestfires
fi <- fire[3:31]
View(fi)
library(plyr)
fi$size_category <- as.numeric(revalue(fi$size_category,
                                  c("small"="0", "large"="1")))
attach(fi)

normalise <- function(x) { 
  return((x - min(x)) / (max(x) - min(x)))
}
fire_norm <- as.data.frame(lapply(fi, normalise))

start_train <- fire_norm[1:496, ]
start_test <- fire_norm[497:517, ]

install.packages("neuralnet")
library(neuralnet)
#simple ANN model
start_model <- neuralnet(size_category~.,data = start_train)


plot(start_model)

## Evaluating model performance 
  
  results_model <- NULL

results_model <- compute(start_model, start_test)

str(results_model)
predicted_strength <- results_model$net.result
cor(predicted_strength, start_test$strength)














