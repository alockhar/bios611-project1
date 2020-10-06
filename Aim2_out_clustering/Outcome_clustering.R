#Look at clustering results and describe by relevant attributes
#Model outcome by clustering
library(Rtsne)
library(compareGroups)

IP=read_csv("derived_data/Overall.csv")
gower_dist=readRDS("derived_data/gower_dist.rds")


tsne_obj <-  Rtsne(gower_dist, is_distance = TRUE)
tsne_data <- tsne_obj$Y %>%
  data.frame() %>%
  setNames(c("X", "Y")) %>%
  mutate(cluster = factor(IP$cluster))

png(file="Aim2_out_clustering/Aim2 TSNE.png")
ggplot(aes(x = X, y = Y), data = tsne_data) +
  geom_point(aes(color = cluster))
dev.off()


#Output table
resu2 <- compareGroups(cluster~Americas +OutcomeE+ WarTypeC +WDuratDays+InitiatorDeaths+RecipientDeaths+RelDiffDeaths+AbsDiffDeaths+StartYR_Norm+OutcomeC+TotalBDeaths+Intnl , data = IP, 
                       method=c(Americas=3,WarTypeC=3,OutcomeC=3,OutcomeE=3), Q1 = 0.025, Q3 = 0.975)
createTable(resu2)
saveRDS(resu2,'Aim2_out_clustering/Aim2_out_clustering.RDS')





