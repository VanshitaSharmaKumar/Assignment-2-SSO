# packages
library(MASS)         # stepAIC
library(dplyr)
sat = read.delim("sat.txt", header=TRUE, sep = "", stringsAsFactors = FALSE)
names(sat)[1] = "state"

# create quadratic term
sat = mutate(sat, takers2 = takers^2)

# full & null models for stepwise search (include hierarchy: takers2 with takers)
full_b  <- lm(total ~ expend + ratio + salary + takers + takers2, data = sat)
null_b  <- lm(total ~ 1, data = sat)

# Forward selection
step_up_b <- stepAIC(
  null_b,
  scope = list(lower = ~1, upper = ~ expend + ratio + salary + takers + takers2),
  direction = "forward",
  trace = FALSE
)

# Backward elimination
step_dn_b <- stepAIC(
  full_b,
  direction = "backward",
  trace = FALSE
)

step_up_b$call
step_dn_b$call
AIC(step_up_b); AIC(step_dn_b)
summary(step_up_b)

# Interpretation: After allowing curvature, participation has a convex relation with total SAT: scores drop as participation rises, but the decline tapers off at higher rates. Expenditure remains positively associated.