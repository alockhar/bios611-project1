IP=read_csv("source_data/INTRA-STATE_State_participants v5.1 CSV.csv");


IP<-IP%>% mutate(WarTypeC = as.factor(case_when(
  WarType==4~'Civil War: Central Control',WarType==5~'Civil War: Local Issues',WarType==6~'Regional Internal',WarType==7~'Intercommunal',WarType==-8~'NA' )),V5RegionC=case_when(V5Region==1~'North America',V5Region==2~'South America',V5Region==3~'Europe',V5Region==4~'Sub-Saharan Africa',V5Region==5~'Middle East and North Africa',V5Region==6~'Asia and Oceania'),OutcomeC=case_when(Outcome==1~"Side A wins",Outcome==2~"Side B wins",Outcome==3~"Compromise",Outcome==4~"War transformed into another War",Outcome==5~"War ongoing as of end of 2014",Outcome==6~"Stalemate",Outcome==7~"Conflict continues below war level" ) )

IP$WarTypeD=ifelse(IP$WarType==4,'Civil War: Central Control',ifelse(IP$WarType==5,'Civil War: Local Issues',ifelse(IP$WarType%in%c(6,7),'Other','NA')))


#Create initiator deaths Var (need to create war id long dataset)
#IP$InitiatorDeaths=ifelse(IP$Initiator==IP$SideA,IP$DeathsSideA,IP$DeathsSideB)
#IP$RecipientDeaths=ifelse(IP$Initiator==IP$SideB,IP$DeathsSideB,IP$DeathsSideA)

#Set upper limit to deaths 50000
IP$TotalBDeathsU=ifelse(IP$TotalBDeaths>=50000,50000,IP$TotalBDeaths)

#Make Hemisphere driven variable
IP$Americas=ifelse(IP$V5Region %in% c(1,2),'Americas','Not in Americas')

#Let's make some dates

IP$Phase1_st=ymd( paste(IP$StartYr1, IP$StartMo1, IP$StartDy1, sep="-"))
IP$Phase2_st=ymd( paste(IP$StartYr2, IP$StartMo2, IP$StartDy2, sep="-"))
IP$Phase3_st=ymd( paste(IP$StartYr3, IP$StartMo3, IP$StartDy3, sep="-"))
IP$Phase4_st=ymd( paste(IP$StartYr4, IP$StartMo4, IP$StartDy4, sep="-"))

IP$Phase1_en=ymd( paste(IP$EndYr1, IP$EndMo1, IP$EndDy1, sep="-"))
IP$Phase2_en=ymd( paste(IP$EndYr2, IP$EndMo2, IP$EndDy2, sep="-"))
IP$Phase3_en=ymd( paste(IP$EndYr3, IP$EndMo3, IP$EndDy3, sep="-"))
IP$Phase4_en=ymd( paste(IP$EndYr4, IP$EndMo4, IP$EndDy4, sep="-"))

write_csv(IP,"derived_data/International.csv")


chk=read_csv("derived_data/International.csv");
chk2=read_csv("derived_data/Overall.csv");