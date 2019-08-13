## R workshop in one day
## 1. general regression
datum = read.csv(file.choose())
# print the head of datum
head(datum)
plot(Biomass~Rainfall,data=datum)
results=lm(Biomass~Rainfall,data=datum)
summary(results)
anova(results)
confint(results)
CI=3.424041-3.1642
CI
# Exercise 1
a1= read.csv(file.choose())
head(a1)
plot(WolfSpiders~PreySpiders,data=a1)
result1=lm(WolfSpiders~PreySpiders,data=a1)
summary(result1)
confint(result1)
# We found that for each 1 spider/sq. meter increase in prey spiders, there was a 1.50 (+/- 0.94; +/- 95% C.I.) spiders/sq. meter increase in wolf spiders (p = 0.0026; r2 = 0.22).
## t-test
datum = read.csv(file.choose())
plot(Mass~Sex,data=datum)
results=t.test(Mass~Sex,data=datum, var.equal=TRUE)
summary(results)
results
slope=0.9806912-0.8023194
slope
results=lm(Mass~Sex,data=datum)
summary(results)
## ANOVA
datum = read.csv(file.choose())
head(datum)
plot(Mass~Sex,data=datum)
results3=aov(Mass~Sex,data=datum)
summary(results3)
results3lm=lm(Mass~Sex,data=datum)
results3lm
summary(results3lm)
#change the reference group, former one is the female, now is Herm
results4=lm(Mass~relevel(Sex,ref="Herm"),data=datum)
summary(results4)
## PostHoc 
TukeyHSD(results3)
TukeyHSD(aov(Mass~Sex,data=datum))
## FDroptest
datum = read.csv(file.choose())
plot(Biomass~Cows,data=datum)
results=lm(Biomass~Cows,data=datum)
summary(results)
results2=lm(Biomass~as.factor(Cows),data=datum)
summary(results2)
anova(results2,results)
# check record min 40 - 50
## swaping
datum = read.csv(file.choose())
head(datum)
plot(Size~Age,data=datum)
plot(Size~Sex,data=datum)
results=lm(Size~Age,data=datum)
summary(results)
results=lm(Size~Sex,data=datum)
summary(results)
results=lm(Size~Sex+Age,data=datum)
summary(results)
##interaction
datum = read.csv(file.choose())
head(datum)
plot(Size~Age,data=datum)
results=lm(Size~Age+Sex+Age:Sex, data=datum)
summary(results)
resultsFemale=lm(Size~Age,data=datum,subset=c(Sex == "Female"))
summary(resultsFemale)
resultsMale=lm(Size~Age,data=datum,subset=c(Sex == "Male"))
summary(resultsMale)
#a2
datum = read.csv(file.choose())
head(datum)

#mixed effects
datum=read.csv(file.choose()) 
head(datum)
results=lm(Biomass~Treatment, data=datum)
summary(results)
library(nlme)
results2=lme(Biomass~Treatment,data=datum,random = (~1|Field))
summary(results2)
t.test(Biomass~Treatment,paired=TRUE,data=datum,var.equal=TRUE)
datum=read.csv(file.choose())
head(datum)
results=lm(Size~Age+Sex,data=datum)
anova(results)
summary(results)
results=lme(Size~Age+Sex,data=datum,random=~1|Individual)
anova(results)
summary(results)


datum = read.csv(file.choose())
plot(q_value~snp,data=datum)
plot(q_value~species,data=datum)
results=lm(q_value~snp,data=datum)
summary(results)
results
results3=aov(q_value~snp,data=datum)
summary(results3)
pairwise.t.test(datum$q_value,datum$snp)  #, p.adj = "holm")
## ANOVA
datum = read.csv(file.choose())
head(datum)
plot(q_value~SNP,data=datum)
results3=aov(q_value~SNP,data=datum)
summary(results3)
results3lm=lm(q_value~SNP,data=datum)
results3lm
summary(results3lm)
