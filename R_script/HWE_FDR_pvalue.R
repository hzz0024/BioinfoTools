datum = read.csv(file.choose())
head (datum)
nrow(datum)
pad <-datum[!(datum$R.2=="NaN" | datum$pDiseq=="NaN"),]
nrow(pad)
pad_r2 <-pad[pad$R.2 >= 0.3,]
pad_r2$FDR <-pad_r2$pDiseq
pad_r2 = pad_r2[order(pad_r2$pDiseq),]
pad_r2$FDR <- p.adjust(pad_r2$FDR, method = "BH", n = length(datum$pDiseq))
pad_r2_FDR <-pad_r2[pad_r2$FDR < 0.01,]
write.csv(pad_r2_FDR, "pad_r2_FDR.csv")
write.csv(pad_r2, "pad_r2.csv")

datum1 = read.csv(file.choose())
head (datum1)
nrow(datum1)
SBF <-datum1[!(datum1$R.2=="NaN" | datum1$pDiseq=="NaN"),]
nrow(SBF)
SBF_r2 <-SBF[SBF$R.2 >= 0.3,]
SBF_r2$FDR <-SBF_r2$pDiseq
SBF_r2$FDR <- p.adjust(SBF_r2$FDR, method = "BH", n = length(datum1$pDiseq))
SBF_r2_FDR <-SBF_r2[SBF_r2$FDR < 0.01,]
write.csv(SBF_r2_FDR, "SBF_r2_FDR.csv")
write.csv(SBF_r2, "SBF_r2.csv")

datum = read.csv(file.choose())
head (datum)
nrow(datum)
wal <-datum[!(datum$R.2=="NaN" | datum$pDiseq=="NaN"),]
nrow(wal)
wal_r2 <-wal[wal$R.2 >= 0.2,]
wal_r2$FDR <-wal_r2$pDiseq
wal_r2$BOF <-wal_r2$pDiseq
wal_r2 = wal_r2[order(wal_r2$pDiseq),]
wal_r2$FDR <- p.adjust(wal_r2$FDR, method = "BH", n = length(datum$pDiseq))
wal_r2$BOF <- p.adjust(wal_r2$BOF, method = "bonferroni", n = length(datum$pDiseq))
wal_r2_FDR_0.01 <-wal_r2[wal_r2$FDR < 0.01,]
wal_r2_FDR_0.05 <-wal_r2[wal_r2$FDR < 0.05,]
wal_r2_FDR_0.001 <-wal_r2[wal_r2$FDR < 0.001,]
write.csv(wal_r2_FDR_0.01, "wal_r2_FDR_0.01.csv")
write.csv(wal_r2_FDR_0.05, "wal_r2_FDR_0.05.csv")
write.csv(wal_r2_FDR_0.001, "wal_r2_FDR_0.001.csv")
write.csv(wal_r2, "wal_r2.csv")

SBF <- read.csv(file="SBF_fst.csv", header=TRUE, sep=",")
head (SBF)
nrow(SBF)
SBF = SBF[order(SBF$p_value),]
SBF
SBF$FDR <-SBF$p_value
SBF$FDR <- p.adjust(SBF$FDR, method = "BH", n = length(SBF$p_value))
SBF
write.csv(SBF, "SBF_FDR.csv")

PAD <- read.csv(file="PAD_fst.csv", header=TRUE, sep=",")
head(PAD)
nrow(PAD)
PAD = PAD[order(PAD$p_value),]
PAD
PAD$FDR <-PAD$p_value
PAD$FDR <- p.adjust(PAD$FDR, method = "BH", n = length(PAD$p_value))
PAD
write.csv(PAD, "PAD_FDR.csv")
