getAge <- function(dataset) {
  year <- as.numeric(format(Sys.time(), "%Y"))
  age <- year - as.numeric(dataset$birth.year)
  
  return(age)
}

analysis <- function(dataset, outliers, col="black") {
  
  print(outliers)
  print(summary(dataset$tripduration))
  print(summary(dataset$age))
  
  par(mfrow=c(1,1))
  
  if (outliers) {
    title <- "with Outliers"
    logHist(dataset$age, breaks=50, lwd=10, col=col, xlim=c(16,120), main="Frequency of Trips by Age With Outliers", xlab="Age in Years", ylab="Frequency")
    logHist(dataset$tripduration, breaks=50, lwd=10, col=col, main="Frequency of Trips by Trip Duration With Outliers", xlab="Trip Duration in Seconds", ylab="Frequency")
  } else {
    title <- "without Outliers"
    hist((dataset$age), col=col, border="white", breaks=50, xlim=c(16,60), main="Frequency of Trips by Age Without Outliers", xlab="Age in Years", ylab="Frequency")
    hist((dataset$tripduration), col=col, border="white", breaks=50, xlim=c(60,2500), main="Frequency of Trips by Trip Duration Without Outliers", xlab="Trip Duration in Seconds", ylab="Frequency")
  }
  
  boxplot(dataset$tripduration, horizontal = TRUE, log="x", main=paste("Trip Duration", title), xlab="Duration in Seconds")
  boxplot(dataset$age, horizontal = TRUE, main=paste("Age", title), xlab="Age in Years")
  
  
  
  lm.out <- lm(dataset$tripduration ~ dataset$age)
  print(summary(lm.out))
  #plot(dataset$age, dataset$tripduration, col=col, main=paste("Trip Duration vs Rider Age", title), xlab="Age", ylab="Duration in Seconds")
  abline(lm.out, col="red")
}

removeOutliers <- function(dataset, var) {
  s <- sd(dataset[,var])
  m <- mean(dataset[,var])
  z <- (dataset[,var]-m)/s
  
  noOutliers <- subset(dataset, z<2)
}

logHist <- function(d, breaks, xlim=NULL, lwd=1, col="black", main=NULL, xlab="", ylab="") {
  h <- hist(d, plot=FALSE, breaks=breaks)
  plot(h$counts ~ h$mids, log="y", xlim=xlim, type="h", lend="square", lwd=lwd, col=col, main=main, xlab=xlab, ylab=ylab)
}

citibikedata <- read.csv("2014-07 - Citi Bike trip data.csv", header=TRUE, stringsAsFactors=FALSE)
citibikedata <- subset(citibikedata, birth.year != "\\N")
citibikedata$age <- getAge(citibikedata)
noOutliers <- removeOutliers(citibikedata, "age")
noOutliers <- removeOutliers(noOutliers, "tripduration")


analysis(citibikedata, TRUE, "blue")
analysis(noOutliers, FALSE, "green")
