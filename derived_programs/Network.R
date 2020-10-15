######################
#Program to create initial network data structure for aim 3
######################

library(dplyr)
library(mice)
library(cluster)
library(Rtsne)
library(tidyverse)
library(lubridate)
library(igraph)
library(RColorBrewer)

network_l=read_csv("derived_data/International.csv");

network_l$Initiator_side=ifelse(network_l$SideA==network_l$Initiator,network_l$Initiator,network_l$SideB)
network_l$Recipient_side=ifelse(network_l$SideB!=network_l$Initiator_side,network_l$SideB,network_l$SideA)
network_l$Initiator_side=ifelse(network_l$Initiator_side=='-8','NA',network_l$Initiator_side)
network_l$Recipient_side=ifelse(network_l$Recipient_side=='-8','NA',network_l$Recipient_side)

#network_l$Initiator_force=ifelse(network_l$SideA==network_l$Initiator,network_l$SideAPeakTotForces,network_l$SideBPeakTotForces)
#network_l$Recipient_force=ifelse(network_l$SideB!=network_l$Initiator_side,network_l$SideBPeakTotForces,network_l$SideAPeakTotForces)


sources <- network_l %>%
  distinct(Initiator_side) %>%
  rename(label = Initiator_side)

destinations <-  network_l %>%
  distinct(Recipient_side) %>%
  rename(label = Recipient_side)


nodes <- full_join(sources, destinations, by = "label")
nodes

nodes <- nodes %>% rowid_to_column("id")

# per_war <- network_l %>%  
#   group_by(Initiator_side, Recipient_side) %>%
#   mutate(weight = TotalBDeathsU) %>% 
#   ungroup()

 per_war <- network_l %>%  
   group_by(Initiator_side, Recipient_side) %>%
   mutate(weight = abs(RelDiffDeathsImp)+1) %>% 
  ungroup()
per_war

edges <- per_war %>% 
  left_join(nodes, by = c("Initiator_side" = "label")) %>% 
  rename(from = id)

edges <- edges %>% 
  left_join(nodes, by = c("Recipient_side" = "label")) %>% 
  rename(to = id)

edges2=select(edges, from, to, weight,Americas,Intnl, WarTypeD, StartYR_Norm,InitiatorForces,RecipientForces,OutcomeC)

#library(network)
#war_network <- network(edges2, vertex.attr = nodes, matrix.type = "edgelist", ignore.eval = FALSE)

#plot(war_network, vertex.cex = 3,mode='circle')

#detach(package:network)
#rm(routes_network)


war_igraph <- graph_from_data_frame(d = edges2, vertices = nodes, directed = TRUE)


#End network construction

saveRDS(war_igraph,'derived_data/network.rds')
