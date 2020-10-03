library(dplyr)


#R script to make Overall dataset into long format

IP=read_csv("derived_data/International.csv");


Sub1<-IP%>%mutate(deaths=`Deaths A`, force=SideAPeakTotForces, forcetheat=`SideAPeak TheatForces`)%>%select(WarNum,deaths,WDuratDays,Americas,WarTypeD,OutcomeD,Initiator,SideA,force,forcetheat)
Sub1$side='A'
Sub1$Init=ifelse(Sub1$SideA==Sub1$Initiator,1,0)
SubA<-Sub1%>%select(-c(Initiator,SideA))

Sub2<-IP%>%mutate(deaths=`Deaths B`, force=SideBPeakTotForces, forcetheat=`SideBPeakTheatForces`)%>%select(WarNum,deaths,WDuratDays,Americas,WarTypeD,OutcomeD,Initiator,SideB,force,forcetheat)
Sub1$side='A'
Sub2$side='B'
Sub2$Init=ifelse(Sub2$SideB==Sub2$Initiator,1,0)
SubB<-Sub2%>%select(-c(Initiator,SideB))


Long=data.frame(rbind(SubA,SubB))



#End Derived program for overall data set
write_csv(Long,"derived_data/International_Long.csv")




