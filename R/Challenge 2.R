citibikedata <- read.csv("Citi Bike Clean Data.csv", header=TRUE, stringsAsFactors=FALSE)
tripduration <- citibikedata$tripduration

#Statement 1
wilcox.test(citibikedata$tripduration, mu=15*60, alternative="less",conf.level=.99)$p.value


overtime <- subset(citibikedata, citibikedata$tripduration >= 45*60)

#statement 2
twoH <- 120*60
#gte <- subset(overtime, overtime$tripduration >= twoH)$tripduration
#lt <- subset(overtime, overtime$tripduration < twoH)$tripduration
#binom.test(c(length(gte), length(lt)), p=0.5, alternative="two.sided")
wilcox.test(overtime$tripduration, mu=twoH, alt="two.sided", conf.level=.99)$p.value
logHist((overtime$tripduration), col="blue", breaks=50, lwd=8, main="Frequency of Overtime Trips by Trip Duration", xlab="Trip Duration in Seconds", ylab="Frequency")


#Statement 3
boxplot(overtime$tripduration ~ overtime$gender)
anova <- aov(formula = tripduration ~ gender, data = overtime)
summary(anova)

#Can't support the claim that men are more likely to incur overtime than women.  