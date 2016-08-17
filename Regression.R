# Author -> Vaibhavi Awghate (vna4493)
# This script performs linear and logistic regression on whole datasets and highly correlated features.

setwd("C:/Users/Vaibhavi/Documents/Spring 16/IS/project")
getwd()
#loading the data
#obj <- read.csv("IF1-FEB22-detailed.csv", header=T)
#str(obj)
#obj_linear <- read.csv("bank-additional-full.csv", header=T)

#removing column Year and Class
#obj_linear = obj[-1]
#obj_linear = obj_linear[-7]

#Get training data ad testing data
#data_size <- floor(0.80 *nrow(obj_linear))
#set.seed(123)
#train_index = sample(seq_len(nrow(obj_linear)), size = data_size)

#training_data = obj_linear[train_index, ]
#testing_data = obj_linear[-train_index, ]
#str(obj_linear)
#Linear regression on whole dataset
#lr = lm( Interfacial.Tension..mN.m. ~. , data = training_data)
#summary(lr)

#pr = predict(lr, data = testing_data)
#summary(pr)
input_data <- read.csv("bank-additional-full.csv")
#View(input_data)
#input_data$age <- NULL

data_size <- floor(0.80 *nrow(input_data))
set.seed(123)
train_index = sample(seq_len(nrow(input_data)), size = data_size)
train_input_data = input_data[train_index, ]
test_input_data <- input_data[-train_index, ]

#Getting correlation matrix on data
train_input_data$job = as.numeric(train_input_data$job)
train_input_data$marital = as.numeric(train_input_data$marital)
train_input_data$education = as.numeric(train_input_data$education)
train_input_data$default = as.numeric(train_input_data$default)
train_input_data$housing = as.numeric(train_input_data$housing)
train_input_data$loan = as.numeric(train_input_data$loan)
train_input_data$contact = as.numeric(train_input_data$contact)
train_input_data$month = as.numeric(train_input_data$month)
train_input_data$day_of_week = as.numeric(train_input_data$day_of_week)
train_input_data$poutcome = as.numeric(train_input_data$poutcome)
train_input_data$y = as.numeric(train_input_data$y)
mcor = cor(train_input_data)
mcor

#getting highly correlated attributes
highly_related <- c()
j <- 20
for (i in 1:20)
  {
  if (abs(mcor[j,i]) > 0.5)
    {
      highly_related <- c(highly_related, (colnames(input_data[i])))
    }
}
highly_related

#linear regression on highly correlated features
form = as.formula(paste("Interfacial.Tension..mN.m. ~" , paste(highly_related, collapse = "+")))
lr_related = lm(form, data = training_data)
summary(lr_related)

#prediction on testing data
pr_related = predict(lr_related, testing_data)
summary(pr_related)


#Logistic regression on whole data set
library(nnet)
#removing column Year and Interfacial.Tension..mN.m.
obj_log = obj[-1]
obj_log = obj_log[-6]
obj_log$Class = as.numeric(obj_log$Class)
data_size <- floor(0.80 *nrow(obj_linear))
set.seed(123)

#getting training and testing data
train_index_log = sample(seq_len(nrow(obj_log)), size = data_size)
training_data_log = obj_log[train_index_log, ]
testing_data_log = obj_log[-train_index_log, ] 
log_r = multinom( Class ~. , data = training_data_log)
summary(log_r)

#predict values on testing data
pr_log = predict(log_r, testing_data_log, "probs")
summary(pr_log)
plot(pr_log)

#Finding correlated features on dataset
log_cor = cor(training_data_log)
summary(log_cor)

highly_related_log <- c()
j <- 6
for (i in 1:5)
{
  if (abs(log_cor[j,i]) > 0.5)
  {
    highly_related_log <- c(highly_related_log, (colnames(obj_log[i])))
  }
}

#Multinomial regression on highly related features
form = as.formula(paste("Class ~.", paste(highly_related_log, collapse = "+")))
log_related = multinom( form , data = training_data_log)

#predicting values on testing data
pr_log_related = predict(log_related, testing_data_log)
summary(pr_log_related)
plot(pr_log_related)

#Finding roc curve
pr_log_related = order(pr_log_related)
roc_log <- roc(Class ~ pr_log_related, data = testing_data_log)
plot(roc_log)

#finding Confusion Matrix
confusionMatrix(testing_data_log$Class, sample(testing_data_log$Class))
