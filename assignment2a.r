# Exercise 2.1 a

# We first will start with the full multi-regression model
library(ggplot2)
library(modelsummary)
sat = read.delim("sat.txt", header=TRUE, sep = "", stringsAsFactors = FALSE)

# Multiple Linear Regression
model_full <- lm(total ~ expend + ratio + salary + takers, data=sat)
print(summary(model_full))
print(AIC(model_full))

# Step-up Method: we will first start with no predictors and add variables one by one based on the lowest AIC
model_StepUp <- lm(total ~ expend + takers, data=sat)
print(summary(model_StepUp))
print(AIC(model_StepUp))
# AIC = 494.8

# Step-down Method: we start from the full model and iteratively remove variables that worsen AIC the least.
model_StepDown <- lm(total ~ expend + takers, data=sat)
print(summary(model_StepDown))
print(AIC(model_StepDown)) # result = 494.8

# Visualising the models
hist(model_full$residuals, main="Histogram of residuals", xlab="Residuals", col="lightgreen", border="black")
qqnorm(model_full$residuals, main="Q-Q plot of residuals")
qqline(model_full$residuals, col="red")

# # making results into tables:
# result_table = modelsummary(list(
#     "model_full_AIC" = AIC(model_full),
#     "model_StepDown_AIC" = AIC(model_StepDown),
#     "model_StepUp_AIC" = AIC(model_StepUp),
# ), 

# statistic = "({std.error})",      # show SEs in parentheses
#   stars = TRUE,                      # significance stars
#   gof_map = list(                    # control bottom GOF rows
#     list("raw"="nobs", "clean"="N", "fmt"=0),
#     list("raw"="r.squared", "clean"="R²", "fmt"=3),
#     list("raw"="adj.r.squared", "clean"="Adj. R²", "fmt"=3),
#     list("raw"="AIC", "clean"="AIC", "fmt"=1),
#     list("raw"="BIC", "clean"="BIC", "fmt"=1)
#   )
# )
