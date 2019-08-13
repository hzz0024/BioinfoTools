source('./plot_R.r')
plot_bayescan("WAL_40_3189_fst.txt",FDR=0.05)
mydata=read.table("WAL_40_3189.sel",colClasses="numeric")
parameter="Fst1"
plot(density(mydata[[parameter]]), xlab=parameter, main=paste(parameter,"posterior distribution"))
plot_bayescan("WAL_62_3233_fst.txt",FDR=0.05)
plot_bayescan("output_fst.txt",FDR=0.05)
