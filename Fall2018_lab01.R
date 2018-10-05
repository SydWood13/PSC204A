#Paprika J:
#     October 4, 2018

#204A R Lab 1
#Fall 2018


###### <- This is a way to comment your code
# I try to do this a lot in my syntax so you (and I)
# can remember what I wrote the syntax for

2
# 2

2+2
# 2+2

# Whatever is to the right of this on a line will not be
# executed by R

#As you may have noticed, R is a calculator

2 + 2

4 - 2

2 * 3

#It will execute operator commands in each line entered

2==1
2==2
	#Provided they are reasonable/logical

###########################################################

#Some important commands for creating objects in R

#c()	concatenate function

c(1,2,3)
c("a","b","c")

	#It will group a list of items into a vector

#?	help file

?c
 #the question mark before a function
	#will draw up the help information for
	#the function.


?plotmcmc

#Use a double question mark to search keywords
??plotmcmc

#class()	class function

class(c(1,2,3))
class(c("a","b","c"))
	#tells you the class of an object in R

#:

1:5
c(1:5,11:15)
	#tells R to create a vector of numbers from
	#x:y

#####################################################

#Objects in R

#The Vector
	#Ranging from a single unit (e.g., scalar) to a
	#large string of values

c(1:5)
c(1:1000)

#Vectors using c() exist only during execution of
#a line of code containing them
#To store a vector in R, you need to make it an object(give it a name)

myvec1 <- c(1:10)


View(myvec1)

#or

myvec2 = c(1:10)

	# the <- and = assign the value to their right
	# to the named object on their left

myvec1
myvec2

#If you use the same object name, or a function name,
#then the contents of the object will be replaced (ovewritten)

myvec1 <- 1

myvec1
myvec2

	#By using myvec1 as an object name, the information
	#previously housed in myvec1 was replaced

#Now is a good time to mention that R is case sensitive

Myvec1
myVec1
myveC1
myvec1
	#I like to use only lowercase labels because of this
	#and because I'm a lazy (correction: SMART) coder


#The Matrix

#Many outputs will be given to you in matrix format
#Matrices are also required as input for many commands
#A matrix is basically an object consisting of rows and columns
#Each row and column can be treated as a vector, and each unique
#matrix cell can be treated as a scalar
#all of these can be indexed using various approaches

#matrix() is a function to build a matrix

matrix(NA, nrow = 2, ncol = 2)
	#Here we have a 2x2 matrix with NA values
		#NA is R's missing value label

matrix(c(1:4), nrow = 2, ncol = 2)
	#Note that the values 1:4 were filled in by column

matrix(c(1:4), nrow = 2, ncol = 2, byrow = TRUE)
	#by adding the byrow argument and using a value
	#other than the default (i.e., FALSE), the values
	#were filled in by row

#We can save a matrix as an object just like a vector

mymat1 <- matrix(c(1:4), nrow = 2, ncol = 2, byrow = TRUE)
mymat1
	#We can recall our object by entering its name

class(mymat1)
	#We can use the class command to confirm that this
	#object is a matrix

#The reason we have data.frames in addition to matrices:

mymat2 <- matrix(c(c(1:2),c("a","b")),
		ncol = 2, nrow = 2, byrow = FALSE)

mymat2
	#What's off here? ## It's turned 1 and two into characters not integers 

class(mymat2[,1])
class(mymat2[,2])
	#What is the class of the first column character
	#when it clearly has numeric values?
		#why did I put [,1] and [,2] after mymat2?

#Matrices can only contain a single type of data
#If you have numeric and character data combined then R
#will force the numeric data to be character, because
#you can have numeric characters, but you cannot have
#letters as numbers

#as for [,1] & [,2], these are ways of subsetting
#matrix and data.frame values

#[R, C] where R indicates row values and C indicates column values

mymat2[1,1] #Row 1, column 1

mymat2[2,2] #Row 2, column 2

mymat2[,1] #All rows, column 1

mymat2[1,] #Row 1, all columns

	#by placing no value for a row or column, you indicate
	#that you want R to return all row/column values

mymat2[,]
	#which is the same as
mymat2

#Unlike matrices, data.frames can support different types of
#data in different columns - i.e., numeric data in column 1
#and character data in column 2

####################

v1 <- rnorm(n=10,mean=0,sd=1)
v2 <- rnorm(n=10,mean=3,sd=2)
mydf2 <- data.frame(v1,v2)

#When working with data sets (i.e., matrices and data.frames)
#you can get a summary of the data using the summary() function

summary(mydf2)

#You can also get frequencies for values

table(mydf2[,1])
	#the top row is the value in the vector and the bottom row is
	#the frequency of that value

table(mydf2[,2])

#You can also ask for some of this information more directly using
#the sapply() function
#sapply() will look through the vectors in a matrix or data.frame and
#apply a function iteratively

sapply(mydf2, class)
	#here, sapply applied the class() function to each column in
	#the data.frame we've been working with and reported
	#each columns class
	#there are other apply statements we will work with
?sapply()
##############################################################

#Often data.frames/matrices (i.e., data sets) will have some sort
#of labeling

names(mydf2)
	#or
colnames(mydf2)

#both functions tell us the column names for the data set
#we can change these names too

colnames(mydf2) <- c("num1","num2")
colnames(mydf2)

#Also, you can reference columns by their names

mydf2[,1][1:5] #Gives us column one, however, we can ask for it by name

mydf2$num1[1:5]
mydf2[,"num1"][1:5]
mydf2[,'num2'][1:5] #As along as you are consistent, either "" or '' work

#You can also add columns to your data.frame using column names

set.seed(925)
mydf2$male <- sample(x=c(0,1), size=dim(mydf2)[1], replace = TRUE)

mydf2$male[1:5]
table(mydf2$male)
	#set.seed is useful for being able to replicate "random"
	#processes such as draws or samplings.
	#sample, function that will randomly draw values from an
	#object
	#dim, reports dimensions of matrix or data.frame
#########################################################

#Logical operators and such

#One of the main things I use R for is organizing data

#which() is a function where you ask which cases in a vector
#satisfy some condition, typically using a logical operator
	# Some common operators are:
	# x == y, x is equal to y
	# x != y, x is not equal to y
	# x > y, x is greater than y
	# x < y, x is less than y
	# x >= y, x is greater than or equal to y
	# x <= y, x is less than or equal to y
	# & one logical condition and another
	# | one logical condition or another

which(mydf2[,3] == 1)[1:5] #which male is equal to 1 shows us the row number
which(mydf2[,3] != 1)[1:5] #which male is not equal to 1
	#Returns the indexes (row numbers) that meet these criteria
	#We can use these row numbers to select rows
	#that meet our criteria

mydf2[which(mydf2[,3] == 1),] #this returns only rows where male = 1

#Consider the by() function
#This function applies a function to a column based on its relation
#to corresponding values in another column

by(mydf2$num1, mydf2$male, table)
	#based on whether male = 0 or 1

##########################################################

#Describing data

#We've already talked about how to get data frequencies; i.e., table()

#Gettings means using mean()

mean(mydf2[,1]) #same as mean(mydfs$num1)
mean(mydf2[,2])

#And we can combine previous commands with these

by(mydf2$num1, mydf2$male, mean)

View(mydf2)
##################################################################


#Where's my data?

#Some people hate R because they are used to seeing their data
	#e.g., Excel, SPSS

#Programs do exist that will allow you to edit your data manually
#If using R studio, then you can also use the following command to look
#at your data
#HOWEVER you will not be able to see everything this way if your 
#dataset is large

View(mydf2)

#Or to summarize your dataset:

summary(mydf2)

#When working with large data sets it is difficult to find specific
#values or cases, and likely you will miss some

#Therefore, it's better to simply use operators to do your work for you

#For example, we know there are NA values in the num1,

mydf2[c(3,6),1] <- NA

#because we put some there!
#What if we wanted to know which cases had those NA values?

#is.na() is a function that will return a TRUE/FALSE report for each case
#evaluated with respect to whether a case is an NA value

is.na(mydf2$num1)
	#There are a lot of values, but TRUE values mean the value
	#is NA, and FALSE values mean the value is not NA
	#We can use the which function to sort these

which(is.na(mydf2$num1) == TRUE)
mydf2[which(is.na(mydf2$num1) == TRUE),]

#this is the same as if we figured out the row numbers
#and called them specifically using c()

mydf2[c(3,6),]

#R stores "TRUE" responses as 1's, which can sometimes be useful
sum(is.na(mydf2$num1))
#lets me know that there are 2 missing values

#Another way to deal with NA values

mean(mydf2[,'num1'])

#Cannot compute the mean because NA is a missing
#value, but R doesn't know what to do with those

mean(mydf2[,'num1'], na.rm = TRUE)

#na.rm tells R to ommit rows with NA values for the
#variable num1

#This same procedure can be written a few different ways

mean(mydf2$num1, na.rm = TRUE)

attach(mydf2)
mean(num1, na.rm = TRUE)
detach(mydf2)


#attach() and detach() and ls()
#ls() lists all objects in the global R environment

ls()

#note that num1 and num2 do not appear in the global
#R environment, they are in mydf2

num1
num2

attach(mydf2)
ls()

#num1 and num2 are still missing, but

num1
num2

#we can now call them directly rather than referencing
#the object they are a part of

detach(mydf2)
num1
num2

#detach() simply reverses attach()


#############################################################

#Are you ready to start working with data?

#What else do you need to know to start?

print("How do I import data?")

file.choose()

#Several options for importing data
#You will, hopefully, mostly do so using read.csv() or read.table()

#Download the lab1data.csv and lab1data.txt documents before proceeding

#To read in data, you need to tell R where to get it and how
#sometimes it helps to orient your console to the data's location
#but first, where is the console now?

getwd()
	#This tells you what directory R's console is presently
	#in

dir()
	#lists all the contents of the present directory

#Make sure the files lab1data files are in a directory you want to access
#then either use setwd() or include the full path to the files
#when using the read.csv and read.table commands

setwd("/Users/sydneywood/Desktop/Psc204A")

	#This is for my laptop, you'll need to enter different directory
	#informaton
	#The console is now in the specified directory

#NOTE: If you are using a PC, the file path might look a little different from mine:
#      e.g., "c:/users/jeg/my documents/ucdavis/ta/2015fall/labs/lab01"
# If you have trouble setting your working directory, sometimes replacing 
# the forwardslashes (/) with backslashes (\) helps

getwd()

	#and we can see what's in here

dir()

	#there are my target files
democ <- read.csv("lab1data.csv", header = TRUE)

View(democ)

	#I am requesting the target file, and indicating that the
	#first line of the file is a header
	#you should confirm this first, but in class we'll
	#assume there is always a header

demot <- read.table("lab1data.txt", header = TRUE)



# Big Five and Subjective Well-Being data
# Subset of data from Sun, Kaufman, & Smillie 
# (2017, Sample 1, http://doi.org/10.1111/jopy.12301)
# Modification: Inserted missing values and added marital
#               status variable for demonstration
             
head(democ)
head(demot)





#I can also read these files in without changing my working directory
#and by using the full file path in the read.csv/table command

democ <- read.csv(
"/Users/jiangrui/Box Sync/PSC 204A/Fall 2018/2018 Homeworks/Hw01/lab1data.csv", 
	header = TRUE)

###let's do some practice with this data set!

#how many participants in the data set are males? How about the females?

table(democ$gender)

# what is the frequency of marriage status (e.g., married, single) in the data set?

table(democ$marriage)


# In this data set, how many females have life satisfication score (i.e.,ls) lower than 2?
#What are their row numbers in the data set?
r = democ[which(democ$gender == "female" & democ$ls < 2),]

r
#how many in total?
nrow(r)


#What is the average score of life satisfication based on their marriage status
#and their gender? 

aggregate(ls~marriage*gender, data=democ, mean)

#or 

#by(democ$ls, list(democ$marriage,democ$gender), mean)

# let's do something fun here!
# Assuming that the formula for happiness is as follows:
# {(positive effective + life satisfication)*extroversion - negative effective * neuroticism}
# Our task is to create a new variable in the data frame called happiness based on the formula. 
# and place these values in the happiness column of the data frame. 

democ$happiness<-((democ$pa+democ$ls)*democ$e - democ$ls*democ$n)
head(democ)

#Calculate the average happiness for men and for women
aggregate(happiness~gender,data=democ,mean)

##let's take a look of the distribution of the happiness!
hist(democ$happiness)
summary(democ$happiness)

##let's categorize the happiness level based on the value!
# A social psychologist has found that persons with a happiness score below 50 are unhappy, 
# with a happiness score 50 to 150 are under the normal happiness level,
# with a happiness score 150 to 200 are happier than average,
# with a happiness score above 200 are extremely happy.
# so how do we categorize their happiness level based on their score ?

democ$class[democ$happiness<50] <- "unhappy"
democ$class[democ$happiness > 50 & democ$happiness < 150] <- "happy"
democ$class[democ$happiness > 150 & democ$happiness < 200] <- "happier"
democ$class[democ$happiness >= 200] <- "extremely happy"
table(list(democ$gender,democ$class))


########################################


#Feel free to use the remainder of lab to do the homework.
#If you have problems let me know and I can come over and help
#If you have any other questions, please feel free to come up and ask
