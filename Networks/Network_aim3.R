library(igraph)
library(RColorBrewer)

war_igraph <- readRDS('derived_data/network.rds')
#war_igraph2=as.undirected(war_igraph)

#End network construction

FG=walktrap.community(war_igraph)
#dendPlot(FG, mode="hclust")


png(file="Networks/Ov.png")
plot(FG,war_igraph,layout=layout.fruchterman.reingold, main="Overall walktrap community detection network\n based on relative difference of initiator and recipient deaths", vertex.label=NA)
dev.off()

#Sort by decreasing membership
meb_tab=sort(table(FG$membership), decreasing=TRUE) 
png(file="Networks/Membership.png")
plot(meb_tab,ylab='Frequency of community membership',xlab='Community')
dev.off()

#Re-color based on top 3 groups and then remaining
FG$membership_cons=ifelse(FG$membership==72,1,ifelse(FG$membership==36,2,ifelse(FG$membership==34,3,4)))
V(war_igraph)$community <- FG$membership_cons
colrs <- adjustcolor( c("gray50", "tomato", "gold", "yellowgreen"), alpha=.6)

png(file="Networks/Membership_consolidated.png")
plot(war_igraph , vertex.color=colrs[V(war_igraph)$community],layout=layout.fruchterman.reingold, main="Overall walktrap community detection network\n based on relative difference of initiator and recipient deaths\n colored by top 3 membership groups", vertex.label=NA)

legend(x=-1.5, y=-1.1, c("1st","2nd", "3rd","Other"), pch=21,
       col=c("gray50", "tomato", "gold", "yellowgreen"), pt.bg=colrs, pt.cex=2, cex=.8, bty="n", ncol=1)
dev.off()




#What are the attributes of the colored nodes?
#Top=delete_vertices(war_igraph, V(war_igraph)$membership != 4)
#V(Top)$label

