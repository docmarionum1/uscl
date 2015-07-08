### Urban Skills Computing Lab (USCL) -  Summer 2015 
### WEEK #1 R Script: Descriptive & Summary Statistics
###  
###  Created:J.C. Bonilla; jb3379@nyu.edu
###
##########################################


# loading data from .csv file:
citibikedata<- read.csv("201501-citibike-tripdata.csv", header=TRUE,
                        stringsAsFactors=FALSE)

#checking for size and dimensions of csv file loaded.
dim(citibikedata)  

#exploring headers in the .csv file.  This should match the headers in your .csv file
names(citibikedata)

#COMPUTING Z-SCORE
tripduration.sd <- sd(citibikedata$tripduration)
tripduration.mean <- mean(citibikedata$tripduration)
z <- (citibikedata$tripduration-tripduration.mean)/tripduration.sd

#creating subsets of data by Z value (3, 2, and 1 standard dev)
bikedata.z3 <- subset(citibikedata, z<3)
bikedata.z2 <- subset(citibikedata, z<2)
bikedata.z1 <- subset(citibikedata, z<1)

# Computing same calculation for data without outliers
dim(citibikedata)
summary(citibikedata$tripduration)
sd(citibikedata$tripduration)

dim(bikedata.z3)
summary(bikedata.z3$tripduration)
sd(bikedata.z3$tripduration)

dim(bikedata.z2)
summary(bikedata.z2$tripduration)
sd(bikedata.z2$tripduration)

dim(bikedata.z1)
summary(bikedata.z1$tripduration)
sd(bikedata.z1$tripduration)

#plotting histograms
par(mfrow=c(4,1)) 
hist((citibikedata$tripduration), col="blue",border="white")
hist((bikedata.z3$tripduration), col="red",border="white")
hist((bikedata.z2$tripduration), col="red",border="white")
hist((bikedata.z1$tripduration), col="red",border="white")

# Calibrating plots 
par(mfrow=c(4,1)) 
hist((citibikedata$tripduration), col="blue",border="white", breaks=300, xlim=c(0,2500))
hist((bikedata.z3$tripduration), col="red",border="white", breaks=100, xlim=c(0,2500))
hist((bikedata.z2$tripduration), col="red",border="white", breaks=50, xlim=c(0,2500))
hist((bikedata.z1$tripduration), col="red",border="white", breaks=50, xlim=c(0,2500))

# Calibrating plots to observe tails
par(mfrow=c(4,1)) 
hist((citibikedata$tripduration), col="blue",border="white", breaks=300, xlim=c(1500,3000), ylim=c(0,100))
hist((bikedata.z3$tripduration), col="red",border="white", breaks=100, xlim=c(1500,3000), ylim=c(0,100))
hist((bikedata.z2$tripduration), col="red",border="white", breaks=50, xlim=c(1500,3000), ylim=c(0,100))
hist((bikedata.z1$tripduration), col="red",border="white", breaks=50, xlim=c(1500,3000), ylim=c(0,100))

#plotting box plots
par(mfrow=c(4,1)) 
boxplot(citibikedata$tripduration, horizontal = TRUE, col="yellow")
boxplot(bikedata.z3$tripduration, horizontal = TRUE, col="red")
boxplot(bikedata.z2$tripduration, horizontal = TRUE, col="green")
boxplot(bikedata.z1$tripduration, horizontal = TRUE, col="blue")

#plotting box plots with range from 0 to 2500
par(mfrow=c(4,1)) 
boxplot(citibikedata$tripduration, horizontal = TRUE, col="yellow", ylim=c(0,2500))
boxplot(bikedata.z3$tripduration, horizontal = TRUE, col="red", ylim=c(0,2500))
boxplot(bikedata.z2$tripduration, horizontal = TRUE, col="green", ylim=c(0,2500))
boxplot(bikedata.z1$tripduration, horizontal = TRUE, col="blue", ylim=c(0,2500))

#plotting box plots with log scale
par(mfrow=c(4,1)) 
boxplot(citibikedata$tripduration, horizontal = TRUE, col="yellow", log = "x", ylim=c(50,20000))
boxplot(bikedata.z3$tripduration, horizontal = TRUE, col="red", log = "x", ylim=c(50,5000))
boxplot(bikedata.z2$tripduration, horizontal = TRUE, col="green", log = "x", ylim=c(50,5000))
boxplot(bikedata.z1$tripduration, horizontal = TRUE, col="blue", log = "x", ylim=c(50,5000))