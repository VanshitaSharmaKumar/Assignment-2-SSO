# Exercise 2.1 a

# We first will start with the full regression model
library(ggplot2)
sat = read.delim("sat.txt", header=TRUE, sep = "", stringsAsFactors = FALSE)

# Multiple Linear Regression
model_full <- lm(total ~ expend + ratio + salary + takers, data=sat)
print(summary(model_full))
print(AIC(model_full))

hist(model_full$residuals, main="Histogram of residuals", xlab="Residuals", col="lightgreen", border="black")
qqnorm(model_full$residuals, main="Q-Q plot of residuals")
qqline(model_full$residuals, col="red")