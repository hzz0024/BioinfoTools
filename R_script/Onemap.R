install.packages("devtools")
library(devtools)
source("https://bioconductor.org/biocLite.R")
biocLite("Rhtslib")
biocLite("zlibbioc")
install_github("augusto-garcia/onemap")
system.file(package = "onemap")

library(tcltk)
library(tkrplot)
library(ggplot2)
library(onemap)
onemap::vcf2raw

onemap::vcf2raw(input = "F_family_1.recode.vcf.gz", output = "family_1_linkage.raw", cross = "outcross", parent1 = "GALMB16", parent2 = "GALMB9")
onemap::vcf2raw(input = "F_family_2.recode.vcf.gz", output = "family_2_linkage.raw", cross = "outcross", parent1 = "GALMB7", parent2 = "GALMB5")
onemap::vcf2raw(input = "F_family_3.recode.vcf.gz", output = "family_3_linkage.raw", cross = "outcross", parent1 = "GALMB1", parent2 = "GALMB3")

gc()
setwd("/gpfs01/home/hzz0024/LMB_linkage_map/onemap")
family_1<-read_onemap(".","family_1_linkage.raw")
save.image("family_1.Rdata")
twopts<-rf_2pts(family_1, LOD=8, max.rf=0.35)
print(twopts)
mark.all<-make_seq(twopts, "all")
marker_type(mark.all)
LGs<-group(mark.all)
print(LGs, detailed=FALSE)
LGs

family_2<-read_onemap("D:/Dropbox/Personal_research/LMB_GBS_sex/LMB_linkage_map","family_2_linkage.raw")
save.image("family_2.Rdata")
twopts<-rf_2pts(family_2, LOD=8, max.rf=0.35)
print(twopts)
mark.all<-make_seq(twopts, "all")
marker_type(mark.all)
LGs<-group(mark.all)
print(LGs, detailed=FALSE)
LGs

family_3<-read.outcross(file="family_3.txt")
save.image("family_3.Rdata")
twopts<-rf.2pts(family_3, LOD=6, max.rf=0.35)
print(twopts)
mark.all<-make.seq(twopts, "all")
marker.type(mark.all)
LGs<-group(mark.all)
print(LGs, detailed=FALSE)
LGs

save.image("family1_test.LGs.Rdata")
set.map.fun(type="kosambi")
LG1<-make.seq(LGs, 1)
LG2<-make.seq(LGs, 2)
LGs
LG1

marker.type(LG2)
LG2 <- make.seq(LGs, 2)
LG2.rcd <- rcd(LG2)
LG2.final
