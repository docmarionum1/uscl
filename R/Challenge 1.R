citibikedata <- read.csv("201501-citibike-tripdata.csv", header=TRUE, stringsAsFactors=FALSE)
names(citibikedata)
subscribers <- subset(citibikedata, usertype=='Subscriber')
customers <- subset(citibikedata, usertype=='Customer')

tripduration.sub.sd <- sd(subscribers$tripduration)
tripduration.sub.mean <- mean(subscribers$tripduration)
tripduration.sub.z <- (subscribers$tripduration-tripduration.sub.mean)/tripduration.sub.sd
subNoOutliers <- subset(subscribers, tripduration.sub.z<3)

tripduration.cus.sd <- sd(customers$tripduration)
tripduration.cus.mean <- mean(customers$tripduration)
tripduration.cus.z <- (customers$tripduration-tripduration.cus.mean)/tripduration.cus.sd
cusNoOutliers <- subset(customers, tripduration.cus.z<3)

summary(subscribers$tripduration)
summary(subNoOutliers$tripduration)
summary(customers$tripduration)
summary(cusNoOutliers$tripduration)

par(mfrow=c(1,1))
hist((subNoOutliers$tripduration), col="blue", border="white", breaks=200, xlim=c(60,3200), main="Frequency of Trip Durations (Subscribers)", xlab="Duration in Seconds")

par(mfrow=c(1,1))
hist((cusNoOutliers$tripduration), col="blue", border="white", breaks=200, xlim=c(60,8000), main="Frequency of Trip Durations (Customers)", xlab="Duration in Seconds")

par(mfrow=C(1,1))
boxplot(subNoOutliers$tripduration, horizontal = TRUE, ylim=c(60,3200), log="x", main="Trip Duration (Subscriber)", xlab="Duration in Seconds")

par(mfrow=C(1,1))
boxplot(cusNoOutliers$tripduration, horizontal = TRUE, ylim=c(60,8000), log="x", main="Trip Duration (Customer)", xlab="Duration in Seconds")
