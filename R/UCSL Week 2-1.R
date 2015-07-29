### Urban Skills Computing Lab (USCL) -  Summer 2015 
### WEEK #2 R Script: Hypothesis Testing & Statistical Significance
###  
###  Created:J.C. Bonilla; jb3379@nyu.edu
###
##########################################

#Normal Distribution in R

# First,create a sequence of values from -4 to 4
xseq<-seq(-4,4,0.01)
#Then calculate densities function with dnorm() with intervals of 0.1 over the x-sequence. 
densities<-dnorm(xseq, 0,1)
plot(xseq, densities, type="l")

#distributions with different means and standard deviations
densities<-dnorm(xseq, 0,1)
densities1<-dnorm(xseq, 1,1)
densities2<-dnorm(xseq, 1,2)
densities3<-dnorm(xseq, 2,3)

#ploting all distributions and observe how the distribution needs plotting recalibration
par(mfrow=c(2,2)) 
plot(xseq, densities, type="l")
plot(xseq, densities1, col="red", type="l")
plot(xseq, densities2, col="green", type="l")
plot(xseq, densities3, col="blue", type="l")

#Lets fit a dnorm with mean = 70, and stand dev = 50

#dnorm should be centered around mean =70 and 4 sd away from the mean as follows
par(mfrow=c(1,2)) 
xseq1<- seq(-0,300,0.1)
xseq2<- seq(-130,270,0.1)
densities1<-dnorm(xseq1, 70,50)
densities2<-dnorm(xseq2, 70,50)
plot(xseq1, densities1, type="l")
plot(xseq2, densities2, type="l")


#This can be calculated as a formula depending on your mean and sd
mean = 33
sd = 14
xseq<- seq(-(4*sd-mean),4*sd+mean)
densities<-dnorm(xseq, mean,sd)
plot(xseq, densities, type="l")


###COMPUTING NORMAL DISTRIBUTION FROM DATA

# loading data from .csv file:
citibikedata<- read.csv("~/Dropbox/USCL/Data/Citi Bike Clean Data.csv", header=TRUE,
                        stringsAsFactors=FALSE)

#checking for size and dimensions of csv file loaded.
dim(citibikedata)

#creating a subset for tripduration less than 1hr

newdata <- subset(citibikedata, tripduration<3600)

dim(newdata)
summary(newdata$tripduration)

x<-newdata$tripduration
mean1=mean(x)
sd1 = sd(x)

#computing normal distribution with newdata
hist(x, breaks=100, probability=TRUE)
#generates a sequence from -4 stad.dev to +4 stad.dev from computed mean()
xfit<-seq(-(4*sd1-mean1),(4*sd1+mean1)) 

#generates density funcion for a normal distribution ~N(mean, sd)
yfit<-dnorm(xfit,mean=mean1,sd=sd1)   
lines(xfit, yfit, col="blue", lwd=2)

#calibrating the plot for the left tail of the normal distribution
xfit.left <- -(4*sd1-mean(x))
xfit.right <- (4*sd(x)+mean(x))

hist(x, breaks=100, probability = TRUE, col = "gray", xlab="Trip Duration < 1hr",xlim=c(-1500,3600), main="Histogram with Normal Curve")
xfit<-seq(-(4*sd(x)-mean(x)),(4*sd(x)+mean(x))) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
lines(xfit, yfit, col="blue", lwd=2)



# Statistical Tests
newdata <- subset(citibikedata, tripduration<3600)
x<-newdata$tripduration
mean1=mean(x)
sd1 = sd(x)

# z-score
z <- (x-mean1)/sd1

# t-score
t.test(x)

#f-score between all tripdurations and trips<1hr.  1hr trip and all trips have the same variance?
var.test(x, citibikedata$tripduration) 

# ANOVA for dependent variable (tripduration) as function (tilde symbol "~") of birth.year 
boxplot(newdata$tripduration ~ newdata$gender)
anova <- aov(formula = tripduration ~ gender, data = newdata)
summary(anova)

