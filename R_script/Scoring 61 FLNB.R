#Scoring FL/NB 61 SNP

#Read into the reference and your sample files
ref61snp <- read.csv(file="ref61snp.csv")
tn <- read.csv(file="tn.csv", na.string="")

#Change the length of your samples
length_samples <- 100
out <- vector(mode="list", length=length_samples)

#For loop to calculate FL/NB/HE
for (i in 1:length_samples) {
  
  northern <- sum(as.character(ref61snp[,3])==as.character(tn[,i]), na.rm=TRUE)
  florida <- sum(as.character(ref61snp[,2])==as.character(tn[,i]), na.rm=TRUE)
  total <- sum(!is.na(tn[,i]))
  he1 <- paste(ref61snp[,2], ref61snp[,3], sep="")
  he2 <- paste(ref61snp[,3], ref61snp[,2], sep="")
  he1calc <- sum(he1==as.character(tn[,i]), na.rm=TRUE)
  he2calc <- sum(he2==as.character(tn[,i]), na.rm=TRUE)
  hetot <- sum(he1calc+he2calc, na.rm=TRUE)
  
  NB <- ((northern+(0.5*hetot))/total*100)
  FL <- ((florida+(0.5*hetot))/total*100)
  HE <- ((hetot/total)*100)
  HOMO <- (100-HE)
  
  out[[i]] <- data.frame(FL_Markers= florida, NB_Markers= northern, HE_Markers= hetot, TS=total, FL=FL, NB=NB, Hetero=HE, Homo=HOMO)
  
}

#Store variable as your data
tnresults <- do.call(rbind, out)

#Write the data into a csv file
write.csv(tnresults, file="tn_LMB2017.csv", row.names = TRUE)
