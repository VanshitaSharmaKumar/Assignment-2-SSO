# -----------------------------

sat = read.delim("sat.txt", header=TRUE, sep = "", stringsAsFactors = FALSE)
head(sat)

trees = read.table("treeVolume.txt", header = TRUE, sep = "\t")
trees$type = factor(trees$type)
head(trees)

# -----------------------------

# Exercise 2.1d

sat$takers2 = sat$takers^2
model_best = lm(total ~ takers + takers2 + expend, data = sat)

state = data.frame(
  expend=5,
  ratio=20,
  salary=36.000,
  takers=25,
  takers2=25^2
)

predict(model_best, newdata = state, interval = "prediction", level = 0.95)

predict(model_best, newdata = state, interval = "confidence", level = 0.95)

# -----------------------------

# Exercise 2.2a

model_a = lm(volume~type, data = trees)
anova(model_a) 

## H0: The volume means of both types are the same 
## p > 0.05, hence, H0 is not rejected and we do not reject the hypothesis that the volume means of both tree types are the same. 
## Hence, we do not reject that the tree type influences the volume, regardless of the diameter and height.

mean(trees$volume[trees$type=="beech"])
mean(trees$volume[trees$type=="oak"])

## An oak is more voluminous than a beech.
## The estimated volume for a beech is 30.17, and for an oak 35.25

# -----------------------------
  
# Exercise 2.2c

# The volume of a cilinder is calculated as follows: V = pi*r^2*H

trees$calc_vol = pi*((trees$diameter/2)^2)*trees$height
model_c = lm(volume ~ calc_vol + type, data = trees)

summary(model_c)
anova(model_c)

# As p <= 0.05, this yields a better result
