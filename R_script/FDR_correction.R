n <- 40
p <- runif(n, 0, 1)
p
adjusted.p <- p.adjust(p, "fdr")
adjusted.p
id <- order(p)
tmp <- p[id]
(q <- tmp*n/(1:n))
new.q <- rev(cummin(rev(q)))
new.q[order(id)]
adjusted.p

p1 <- read.csv(file="p1.csv",head=TRUE,sep=",")
p1$p1
p1=as.numeric(unlist(p1))
adjusted.p1 <- p.adjust(p1, "fdr", 9918)
adjusted.p1
id <- order(p1)
tmp <- p1[id]
(q <- tmp*n/(1:n))
new.q <- rev(cummin(rev(q)))
new.q[order(id)]
adjusted.p1

