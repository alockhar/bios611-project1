library(dplyr)


#R script to make Overall dataset into long format

IP=read_csv("derived_data/Overall.csv");


Sub1<-IP%>%mutate(deaths=DeathsSideA)%>%select(WarNum,deaths,WDuratDays,Outcome,Americas,WarTypeD,Initiator,SideA)
Sub1$side='A'
Sub1$Init=ifelse(Sub1$SideA==Sub1$Initiator,1,0)
SubA<-Sub1%>%select(-c(Initiator,SideA))

Sub2<-IP%>%mutate(deaths=DeathsSideB)%>%select(WarNum,deaths,WDuratDays,Outcome,Americas,WarTypeD,Initiator,SideB)
Sub2$side='B'
Sub2$Init=ifelse(Sub2$SideB==Sub2$Initiator,1,0)
SubB<-Sub2%>%select(-c(Initiator,SideB))


Long=data.frame(rbind(SubA,SubB))



#End Derived program for overall data set
write_csv(Long,"derived_data/Overall_Long.csv")

