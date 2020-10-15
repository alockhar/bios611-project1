library(dplyr)
library(mice)
library(cluster)
library(Rtsne)
library(tidyverse)
library(lubridate)

#R script to generate additional derived variables from Overall dataset

##################
#Present overall descriptive statistics from central nations in conflict
##################


Overall=read_csv("source_data/INTRA-STATE WARS v5.1 CSV.csv");

IP<-Overall%>% mutate(WarTypeC = as.factor(case_when(
  WarType==4~'Civil War: Central Control',WarType==5~'Civil War: Local Issues',WarType==6~'Regional Internal',WarType==7~'Intercommunal',WarType==-8~'NA' )),
  V5RegionC=case_when(V5RegionNum==1~'North America',V5RegionNum==2~'South America',V5RegionNum==3~'Europe',V5RegionNum==4~'Sub-Saharan Africa',V5RegionNum==5~'Middle East and North Africa',V5RegionNum==6~'Asia and Oceania'),OutcomeC=case_when(Outcome==1~"Side A wins",Outcome==2~"Side B wins",Outcome==3~"Compromise",Outcome==4~"War transformed into another War",Outcome==5~"War ongoing as of end of 2014",Outcome==6~"Stalemate",Outcome==7~"Conflict continues below war level" ) )

IP$WarTypeD=ifelse(IP$WarType==4,'Civil War: Central Control',ifelse(IP$WarType==5,'Civil War: Local Issues',ifelse(IP$WarType%in%c(6,7),'Other','NA')))

IP$OutcomeD=ifelse(IP$Outcome==1,'Side A',ifelse(IP$Outcome==2,'Side B','Other'))

#Create a variable for set upper limit to deaths 50000 after checking limit to deaths
IP$TotalBDeathsU=ifelse(IP$TotalBDeaths>=50000,50000,IP$TotalBDeaths)

#Make Hemisphere driven variable
IP$Americas=ifelse(IP$V5RegionNum %in% c(1,2),'Americas','Not in Americas')

#Let's make some dates

IP$Phase1_st=ymd( paste(IP$StartYr1, IP$StartMo1, IP$StartDy1, sep="-"))
IP$Phase2_st=ymd( paste(IP$StartYr2, IP$StartMo2, IP$StartDy2, sep="-"))
IP$Phase3_st=ymd( paste(IP$StartYr3, IP$StartMo3, IP$StartDy3, sep="-"))
IP$Phase4_st=ymd( paste(IP$StartYr4, IP$StartMo4, IP$StartDy4, sep="-"))

IP$Phase1_en=ymd( paste(IP$EndYr1, IP$EndMo1, IP$EndDy1, sep="-"))
IP$Phase2_en=ymd( paste(IP$EndYr2, IP$EndMo2, IP$EndDy2, sep="-"))
IP$Phase3_en=ymd( paste(IP$EndYr3, IP$EndMo3, IP$EndDy3, sep="-"))
IP$Phase4_en=ymd( paste(IP$EndYr4, IP$EndMo4, IP$EndDy4, sep="-"))


#Consider making transition to and from variables
IP$InitiatorDeaths=ifelse(IP$SideA==IP$Initiator,IP$DeathsSideA,IP$DeathsSideB)
IP$RecipientDeaths=ifelse(IP$SideA!=IP$Initiator,IP$DeathsSideA,IP$DeathsSideB)

IP$InitiatorDeaths2=ifelse(IP$InitiatorDeaths==-9,NaN,IP$InitiatorDeaths)
IP$RecipientDeaths2=ifelse(IP$RecipientDeaths==-9,NaN,IP$RecipientDeaths)


IP$AbsDiffDeaths=ifelse(IP$InitiatorDeaths!=-9 |IP$RecipientDeaths!=-9,IP$InitiatorDeaths-IP$RecipientDeaths,NaN)
IP$RelDiffDeaths=ifelse(IP$InitiatorDeaths!=-9 |IP$RecipientDeaths!=-9,abs(IP$InitiatorDeaths-IP$RecipientDeaths)/max(abs(IP$RecipientDeaths),abs(IP$InitiatorDeaths)),NaN)

IP$StartYR_Norm=IP$StartYr1-min(IP$StartYr1) 
IP$Americas=as.factor(IP$Americas)
IP$WarTypeD=as.factor(IP$WarTypeD)



ImpDS<-IP%>%select(WarNum,StartYr1,InitiatorDeaths2,RecipientDeaths2,WarTypeD,Americas)

ID=mice(ImpDS)
anescomp <- mice::complete(ID, 1)%>% rename(InitiatorDeathsImp=InitiatorDeaths2,RecipientDeathsImp=RecipientDeaths2)%>%select(WarNum,InitiatorDeathsImp,RecipientDeathsImp)

IP<-IP%>%left_join(.,anescomp)
#End Derived program for overall data set


IP$AbsDiffDeathsImp=IP$InitiatorDeathsImp-IP$RecipientDeathsImp
IP$RelDiffDeathsImp=abs(IP$InitiatorDeathsImp-IP$RecipientDeathsImp)/max(abs(IP$RecipientDeathsImp),abs(IP$InitiatorDeathsImp))


IP$OutcomeE=ifelse(IP$SideA==IP$Initiator & IP$OutcomeD=='Side A' ,'Initiator Won',ifelse(IP$SideB==IP$Initiator & IP$OutcomeD=='Side B' ,'Recipient Won','Other'))


#Look at clustering and append to final DS
ForClust<-IP%>%select(WarTypeD,Americas,StartYR_Norm,Intnl,WDuratDays,InitiatorDeathsImp,RecipientDeathsImp,RelDiffDeathsImp)


gower_dist <- daisy(ForClust, metric = "gower")
gower_mat <- as.matrix(gower_dist)



#Most similar (put in output)
IP[which(gower_mat == min(gower_mat[gower_mat != min(gower_mat)]), arr.ind = TRUE)[1, ], ]

#Most dissimilar
IP[which(gower_mat == max(gower_mat[gower_mat != max(gower_mat)]), arr.ind = TRUE)[1, ], ]

#Cluster determination
set.seed(1492)
results <- clusGap(gower_mat, kmeans,K.max = 5, B = 50)

png(file="Overall_plots/plot_files/Gap_stat.png")
ggplot(results$Tab %>% as_tibble() %>% mutate(k=seq(nrow(.))), aes(k,gap)) + geom_line()
dev.off()

#Go with 4
k <- 4
km_fit <- kmeans(gower_dist, k)
cluster=km_fit$cluster


IP<-cbind(IP,cluster)


write_csv(IP,"derived_data/Overall.csv")
saveRDS(gower_dist,"derived_data/gower_dist.rds")











