install.packages("export")
datum = read.csv(file.choose())
setwd("D:/Dropbox/Ryan/Walleye GBS/Walleye manuscript/Data/Final_results/SNP_selection")
my_hist=hist(datum$Fst,
     main="Frequency distribution of FST estimates for 1,842 SNPs",
     xlab="FST",
     xlim=c(0,1),
     breaks=20,
     ylab="Number of SNPs",
     ylim=c(0,400),
     col="#c7c7c7"
     )
abline(v=0.001, col="orange")
abline(v=0.8222, col="green")
abline(v=0.1120, col="blue")
abline(v=0.3782, col="blue")


library(export)
graph2ppt(file="Fst.pptx",width=7,height=5)

## plotting the delta K
library(export)
library(ggplot2)
df2 <- read.csv("Delta_K.csv")
df2
# Line plot with multiple groups
p<-ggplot(df2, aes(x=K, y=N, group=Group)) +
  geom_line(aes(color=Group))+
  geom_point(aes(color=Group))+
  scale_x_continuous(breaks=c(2,3,4,5,6,7,8,9),labels = c("2","3","4","5","6","7","8","9"))+
  scale_color_manual(values=c("darkviolet", "skyblue2", "royalblue2")) + theme_set(theme_classic(base_size = 20))+
  xlab("K") + ylab("Delta K")+
  theme(legend.position = c(0.8, 0.5))+
  theme(legend.title = element_blank())
p

library(export)
graph2ppt(file="Delta K",width=8,height=5)
