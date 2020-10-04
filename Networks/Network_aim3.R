library(igraph)
library(RColorBrewer)

war_igraph <- readRDS('derived_data/network.rds')

war_igraph2=as.undirected(war_igraph)
#End network construction

FG=walktrap.community(war_igraph2)


plot.igraph(FG)

#Fast greedy algorithm detection
walktrap.Alg=walktrap.community(war_igraph)

weight.community=function(row,membership,weigth.within,weight.between){
  if(as.numeric(membership[which(names(membership)==row[1])])==as.numeric(membership[which(names(membership)==row[2])])){
    weight=weigth.within
  }else{
    weight=weight.between
  }
  return(weight)
}

E(walktrap.Alg)$weight=apply(get.edgelist(walktrap.Alg),1,weight.community,membership,10,1)



plot(war_igraph, edge.arrow.size = 0.2)

colrs <- c("gray50", "tomato")
V(war_igraph)$color <- colrs[V(war_igraph)$Americas]
plot(war_igraph, edge.arrow.size = 0.2)


plot(war_igraph)


pal <- brewer.pal(length(unique(V(war_igraph)$Americas)), "Dark2")

plot(war_igraph, vertex.color = pal[as.numeric(as.factor(vertex_attr(war_igraph, "group")))], layout=layout_randomly)