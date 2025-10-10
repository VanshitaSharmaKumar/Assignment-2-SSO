# 2.1 b

## 1) Load data & create takers^2
sat <- read.table("sat.txt", header = TRUE)
sat$takers2 <- sat$takers^2

## 2) Stepwise model selection (AIC)
# forward (start from intercept)
m0    <- lm(total ~ 1, data = sat)
scope <- ~ expend + ratio + salary + takers + takers2
m_fwd <- step(m0, scope = list(lower = ~1, upper = scope),
              direction = "forward", trace = 0)

# backward (start from full)
m_full <- lm(total ~ expend + ratio + salary + takers + takers2, data = sat)
m_bwd  <- step(m_full, direction = "backward", trace = 0)

cat("this is the summery for fwd")
summery_fwd = summary(m_fwd)

summery_bwd = summary(m_bwd)
print(summery_fwd)
print(summery_bwd)

## 3) Is takers^2 useful? Compare with/without the square
m_nosq <- lm(total ~ expend + takers, data = sat)          # without takers^2
m_sq   <- lm(formula(m_fwd), data = sat)                   # the selected model (with takers^2)

result = AIC(m_nosq); AIC(m_sq) 
cat(result)                                  # lower is better
print(anova(m_nosq, m_sq))                                     # nested F-test
