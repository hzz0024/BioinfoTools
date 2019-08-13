reps = c("neutral_genetic/mutationKAM/",
         "neutral_genetic/mutationSSM/")
for(rep in reps){
  setwd(rep);
  myfile<-"simulation_mean.txt"
  sim_stat<-read.table(myfile,h=T)
  mutation.model <- substr(rep,nchar(rep)-3,nchar(rep)-1)
  # Plotting number of alleles and heterozygosity over time
  par(mfrow=c(1,2),oma=c(0,0,2,0))
  plot(sim_stat$generation, sim_stat$n.adlt.nbAll, type='l',
       xlab="generation", ylab="nb. of alleles")
  plot(sim_stat$generation, sim_stat$n.adlt.ho, type="l", 
       xlab="generation", ylab="observed heterozygosity", 
       ylim=c(0,1))
  title(mutation.model, outer=TRUE)
  
  setwd("../..")
}

reps = c("WAL_neutral_50/")
for(rep in reps){
  setwd("D:/Dropbox/Ryan/Walleye GBS/Walleye manuscript/Data/Formal_quantinemo/WAL_1");
  myfile<-"simulation_mean.txt"
  sim_stat<-read.table(myfile,h=T)
  #mutation.model <- substr(rep,nchar(rep)-3,nchar(rep)-1)
  # Plotting number of alleles and heterozygosity over time
  par(mfrow=c(2,2),oma=c(0,0,2,0))
  plot(sim_stat$generation, sim_stat$n.adlt.ho, type="l", 
       xlab="generation", ylab="Observed heterozygosity", 
       ylim=c(0,0.08))
  plot(sim_stat$generation, sim_stat$n.adlt.nbFixLoc, type='l',
       xlab="generation", ylab="Number of fixed loci",
       ylim=c(0,1000))
  title("walleye_1", outer=TRUE)
  
  setwd("../..")
}