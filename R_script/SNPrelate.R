install.packages("devtools")
install.packages("backports")
install.packages("blue")
library("devtools")

install_github("zhengxwen/gdsfmt")
install_github("zhengxwen/SNPRelate")
library(gdsfmt)
library(SNPRelate)
snpgdsSummary(snpgdsExampleFileName())
(genofile <- snpgdsOpen(snpgdsExampleFileName()))
get.attr.gdsn(index.gdsn(genofile, "snp.chromosome"))
# Take out genotype data for the first 3 samples and the first 5 SNPs
(g <- read.gdsn(index.gdsn(genofile, "genotype"), start=c(1,1), count=c(5,3)))
pop <- read.gdsn(index.gdsn(genofile, path="sample.annot/pop.group"))
table(pop)


#HWE test
#warrior
vcf.fn <- "./wal_warrior.recode.vcf"
snpgdsVCF2GDS(vcf.fn, "warrior.gds", method="biallelic.only", snpfirstdim=TRUE)
snpgdsSummary("warrior.gds")
(genofile <- snpgdsOpen("warrior.gds"))
read.gdsn(index.gdsn(genofile, "sample.id"))
read.gdsn(index.gdsn(genofile, "snp.rs.id"))
read.gdsn(index.gdsn(genofile, "genotype"))
p <- snpgdsHWE(genofile, sample.id=NULL, snp.id=NULL, with.id=FALSE)
write.csv(p, "warrior_p.csv")
plot(-log10((1:length(p))/length(p)), -log10(p[order(p)]),
     xlab="-log10(expected P)", ylab="-log10(observed P)", main="QQ plot")
abline(a=0, b=1, col="blue")
#Coosa
vcf.fn <- "./wal_coosa.recode.vcf"
snpgdsVCF2GDS(vcf.fn, "coosa.gds", method="biallelic.only", snpfirstdim=TRUE)
snpgdsSummary("coosa.gds")
(genofile <- snpgdsOpen("coosa.gds"))
read.gdsn(index.gdsn(genofile, "sample.id"))
read.gdsn(index.gdsn(genofile, "snp.rs.id"))
read.gdsn(index.gdsn(genofile, "genotype"))
p <- snpgdsHWE(genofile, sample.id=NULL, snp.id=NULL, with.id=FALSE)
write.csv(p, "coosa_p.csv")
plot(-log10((1:length(p))/length(p)), -log10(p[order(p)]),
     xlab="-log10(expected P)", ylab="-log10(observed P)", main="QQ plot")
abline(a=0, b=1, col="blue")
#Erie
vcf.fn <- "./wal_erie.recode.vcf"
snpgdsVCF2GDS(vcf.fn, "erie.gds", method="biallelic.only", snpfirstdim=TRUE)
snpgdsSummary("erie.gds")
(genofile <- snpgdsOpen("erie.gds"))
read.gdsn(index.gdsn(genofile, "sample.id"))
read.gdsn(index.gdsn(genofile, "snp.rs.id"))
read.gdsn(index.gdsn(genofile, "genotype"))
p <- snpgdsHWE(genofile, sample.id=NULL, snp.id=NULL, with.id=FALSE)
write.csv(p, "erie_p.csv")
plot(-log10((1:length(p))/length(p)), -log10(p[order(p)]),
     xlab="-log10(expected P)", ylab="-log10(observed P)", main="QQ plot")
abline(a=0, b=1, col="blue")
# LD
vcf.fn <- "./wal_mis_he.recode.vcf"
snpgdsVCF2GDS(vcf.fn, "test.gds", method="biallelic.only", snpfirstdim=TRUE)
snpgdsSummary("test.gds")
(genofile <- snpgdsOpen("test.gds"))
read.gdsn(index.gdsn(genofile, "sample.id"))
read.gdsn(index.gdsn(genofile, "snp.rs.id"))
read.gdsn(index.gdsn(genofile, "genotype"))
SNP_ID<-read.gdsn(index.gdsn(genofile, "snp.rs.id"))
write.csv(SNP_ID, "LD.csv")
#read.gdsn(index.gdsn(genofile, "snp.id"))
set.seed(1000)
snpset <- snpgdsLDpruning(genofile,sample.id=NULL, snp.id=NULL, maf=NaN, autosome.only=FALSE, missing.rate=NaN,method=c("r"), slide.max.bp=500000L,
                          slide.max.n=NA, ld.threshold=0.2, start.pos=c("random"),
                          num.thread=1L, verbose=TRUE)
snpset
snp.id <- unlist(unname(snpset))
snp.id
write.csv(snp.id, "LD_list.csv")
