library(igraph)
library(RColorBrewer)

war_igraph <- readRDS('derived_data/network.rds')


#End network construction

plot(war_igraph, edge.arrow.size = 0.2)

colrs <- c("gray50", "tomato")
V(war_igraph)$color <- colrs[V(war_igraph)$Americas]
plot(war_igraph, edge.arrow.size = 0.2)


plot(war_igraph)


pal <- brewer.pal(length(unique(V(war_igraph)$Americas)), "Dark2")

plot(war_igraph, vertex.color = pal[as.numeric(as.factor(vertex_attr(war_igraph, "group")))], layout=layout_randomly)