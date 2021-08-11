data <- read.csv("data_for_EDA.csv",header=T)
View(data)
data[,"분과"] <- factor(data[,"분과"])

result <- matrix(0,53,2)
for (i in 3:55){
  analysis <- aov(data[,i]~data[,56])
  pval <- round(summary(analysis)[[1]][["Pr(>F)"]][1],3)
  print(paste(colnames(data)[i],pval))
  result[(i-2),1] <- colnames(data)[i]
  result[(i-2),2] <- pval
}

final <- result[order(result[,2]),]
colnames(final) <- c("clubname","pvalue")

write.csv(final,"anova_p.csv")
