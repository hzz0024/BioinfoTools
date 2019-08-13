mydata <- mtcars[, c(1,3,4,5,6,7)]
head(mydata)
cormat <- round(cor(mydata),2)
head(cormat)
library(reshape2)
melted_cormat <- melt(cormat)
head(melted_cormat)
library(ggplot2)
ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile()
# Get lower triangle of the correlation matrix
get_lower_tri<-function(cormat){
  cormat[upper.tri(cormat)] <- NA
  return(cormat)
}
# Get upper triangle of the correlation matrix
get_upper_tri <- function(cormat){
  cormat[lower.tri(cormat)]<- NA
  return(cormat)
}
upper_tri <- get_upper_tri(cormat)
upper_tri

lower_tri <- get_lower_tri(cormat)
lower_tri

rotate = t(apply(lower_tri, 2, rev))
rotate
# Melt the correlation matrix
library(reshape2)
melted_cormat <- melt(rotate, na.rm = TRUE)
# Heatmap
library(ggplot2)
ggplot(data = melted_cormat, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Pearson\nCorrelation") +
  theme_minimal()+ 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                   size = 12, hjust = 1))+
  coord_fixed()+
  geom_text(aes(Var2, Var1, label = value), color = "black", size = 4) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank(),
    legend.justification = c(1, 0),
    legend.position = c(0.6, 0.7),
    legend.direction = "horizontal")+
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                               title.position = "top", title.hjust = 0.5))


###############################read data test

d1<-read.csv("WAL605_SNP68.csv", row.names = 1, header= TRUE)
d1<-read.csv("WAL605_SNP68_hudson.csv", row.names = 1, header= TRUE)
d <- round((d1),2)
as.matrix(d)
# Get lower triangle of the correlation matrix
get_lower_tri<-function(d){
  d[upper.tri(d)] <- NA
  return(d)
}
# Get upper triangle of the correlation matrix
get_upper_tri <- function(d){
  d[lower.tri(d)]<- NA
  return(d)
}
upper_tri <- get_upper_tri(d)
upper_tri
lower_tri <- get_lower_tri(d)
lower_tri
rotate1 = t(apply(upper_tri, 2, rev))
rotate1
rotate2 = t(apply(rotate1, 2, rev))
rotate2
rotate = t(apply(rotate2, 2, rev))
rotate
# Melt the correlation matrix
library(reshape2)
melted_d <- melt(rotate, na.rm = TRUE)
# Heatmap
library(ggplot2)
ggplot(data = melted_d, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "blue", high = "grey40", mid = "white", 
                       midpoint = 0, limit = c(0,1), space = "Lab", 
                       name="FST") +
  theme_minimal()+ 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                   size = 12, hjust = 1))+
  coord_fixed()+
  geom_text(aes(Var2, Var1, label = value), color = "black", size = 4) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank(),
    legend.justification = c(1, 0),
    legend.position = c(0.6, 0.7),
    legend.direction = "horizontal")+
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                               title.position = "top", title.hjust = 0.5))

library(export)
graph2ppt(file="WAL605_SNP68_hudson_fst_final_no_neg",width=10,height=6)
