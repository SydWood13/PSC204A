dir()
hw02data <- read.csv("HW01Data.csv")
View(hw02data)

?hist


hist(hw02data$weight_lbs, col = "deepskyblue", main = "Distribution of Particpant Weights", xlab = "Weight in Pounds")


?plot

?abline

heightdensity <- density(hw02data$height_in)

plot(heightdensity, main = "The Density of Participant Height", xlab = "Hieght in Inches")


abline(v = mean(hw02data$height_in))

abline(v = median(hw02data$height_in), lty = 2)

?summary

hw02data$bmi <- (hw02data$weight_lbs/ (hw02data$height_in^2))* 703

aggregate(bmi~biosex*ed_cmplt, data = hw02data, mean)

aggregate(bmi~biosex*ed_cmplt, data = hw02data, median)

aggregate(bmi~biosex*ed_cmplt, data = hw02data, min)

aggregate(bmi~biosex*ed_cmplt, data = hw02data, max)

aggregate(bmi~biosex*ed_cmplt, data = hw02data, var)
y
condition <- list(hw02data$biosex, hw02data$ed_cmplt)
describeBy(hw02data$bmi, group = condition)

?summarise

descstats <- function(x) c(mean(x), median(x), var(x), min(x), max(x))

aggregate(hw02data$bmi~biosex*ed_cmplt, data = hw02data, descstats)

bmimax <- max(hw02data$bmi)
maxrow <- which(hw02data$bmi == bmimax)
bmimax
maxrow

bmimin <- min(hw02data$bmi)
minrow <- which(hw02data$bmi == bmimin)
bmimin
minrow

hw02data$zbmi <- scale(hw02data$bmi)

zbmimax <- max(hw02data$zbmi)
zmaxrow <- which(hw02data$zbmi == zbmimax)
zbmimax
zmaxrow

zbmimin <- min(hw02data$zbmi)
zminrow <- which(hw02data$zbmi == zbmimin)
zbmimin
zminrow

hw02data$newbmi <- (scale(hw02data$bmi)*15 + 100)

newbmimax <- max(hw02data$newbmi)
newmaxrow <- which(hw02data$newbmi == newbmimax)
newbmimax
newmaxrow

newbmimin <- min(hw02data$newbmi)
newminrow <- which(hw02data$newbmi == newbmimin)
newbmimin
newminrow