# Logistic Regression
x_train <- read.csv("X_train.csv",header=T)
x_test <- read.csv("X_test.csv",header=T)
y_train <- read.csv("y_train.csv",header=T)
y_test <- read.csv("y_test.csv",header=T)
x_train <- x_train[,2:61]
x_test <- x_test[,2:61]

train <- cbind(x_train,y_train[,2])
test <- cbind(x_test,y_test[,2])
colnames(train)[61] <- "y"
colnames(test)[61] <- "y"

library(nnet)
lr <- multinom(y ~ ., data=train,MaxNWts = 10000)
s <- summary(lr)
write.csv(round(t(s$coefficients),3), "coef.csv")

z <- s$coefficients/s$standard.errors
p <- (1 - pnorm(abs(z), 0, 1)) * 2
write.csv(round(p,3),"p_value.csv")

ml_logit_prey <- predict(ml_logit, newdata = ctgs_tst)
y_pred <- predict(lr, newdata=test)

# test accuracy
sum(y_test[,2] == y_pred)/32

# train accuracy
y_pred2 <- predict(lr, newdata=train)
sum(y_train[,2] == y_pred2)/126
