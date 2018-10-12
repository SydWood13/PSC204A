dir()
hw01data <- read.csv("HW01Data.csv")


View(hw01data)

#What are the deminsions? 

nrow(hw01data)
ncol(hw01data)

###or

dim(hw01data)

# what types are each column? 

class(hw01data[,1])
class(hw01data[,2])
class(hw01data[,3])
class(hw01data[,4])
class(hw01data[,5])
 
##or 

sapply(hw01data, class)


# how many in the class where female and how many were male?

table(hw01data$biosex)
 

# what is the frequency of each completed education level? 

table(hw01data$ed_cmplt)



# How many males are taller than 72in? what are the row numbers?

rtallmales <- which(hw01data$biosex == "MALE" & hw01data$height_in > 72)

rtallmales

length(rtallmales)


#average age based on college attainment:

by(hw01data$age_yr, hw01data$ed_cmplt, mean)


#or

aggregate(age_yr~ed_cmplt, data = hw01data, mean)


#average age of P by education achievemet and biological sex 

aggregate(age_yr~ed_cmplt*biosex, data = hw01data, mean)

#Create BMI variable 

hw01data$bmi<- (hw01data$weight_lbs/(hw01data$height_in^2)) * 703

#average bmi for men and women
aggregate(bmi~biosex, data = hw01data, mean)

#Categorize men and women according to the index

hw01data$class[hw01data$bmi <= 18.5] <- "Underweight"
hw01data$class[hw01data$bmi > 18.5 & hw01data$bmi <= 25] <- "Normal/Healthy"
hw01data$class[hw01data$bmi > 25 & hw01data$bmi < 30] <- "Overweight"
hw01data$class[hw01data$bmi >= 30] <- "Obese"

table(list(hw01data$biosex, hw01data$class))
                 