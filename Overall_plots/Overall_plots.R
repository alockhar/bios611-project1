IP=read_csv("derived_data/Overall.csv");
IP2=read_csv("derived_data/Overall_Long.csv");



#Look at overall attributes by Americas indicator in table

#Total exposure time (days) 
#ggplot(IP,aes(x=WDuratDays))+geom_histogram()+xlab('Total number of days war lasted')+ylab('Frequency')

#ggplot(IP,aes(x=WDuratDays))+geom_histogram()+xlab('Total number of days war lasted')+ylab('Frequency')+facet_grid(~ Americas)
ggplot(IP, aes(x = WDuratDays)) +  
  geom_histogram(aes(y = (..count..)/sum(..count..))) + ylab('Proportion of wars')+xlab('Duration of war (days)')+facet_grid(~ Americas)

#Total exposure time (months)
#ggplot(IP,aes(x=WDuratMo))+geom_histogram()+xlab('Total number of months war lasted')+ylab('Frequency')



#Total number of battle-related deaths both sides (Keep and explain why)
ggplot(IP,aes(x=TotalBDeaths))+geom_histogram(aes(y = (..count..)/sum(..count..)))+xlab('Total number of battle-related deaths both sides')+ylab('Proportion of wars')+ylab('Frequency')

#Total deaths by war type
#ggplot(IP,aes(y=TotalBDeathsU,x=WarTypeC))+geom_boxplot()+ylab('Upper limit greater than 50000 set to 50000 deaths')

#Total deaths by Region (keep and explain why)
#ggplot(IP,aes(y=TotalBDeathsU,x=V5RegionC))+geom_boxplot()+ylab('Upper limit greater than 50000 set to 50000 deaths')+theme(axis.text.x = element_text(angle = 90))



#Total deaths by Americas (Don't think it's needed)
#ggplot(IP,aes(y=TotalBDeathsU,x=Americas))+geom_boxplot()+ylab('Upper limit greater than 50000 set to 50000 deaths')

#Total deaths by Americas facet grid (Keep and explain why)
#ggplot(IP,aes(y=TotalBDeathsU,x=Americas))+geom_boxplot()+ylab('Upper limit greater than 50000 set to 50000 deaths')+facet_grid(~ WarTypeC)
ggplot(IP,aes(y=TotalBDeathsU,x=Americas))+geom_boxplot()+ylab('Upper limit greater than 50000 set to 50000 deaths')+facet_grid(~ WarTypeD)









#Total deaths and exposure time (months) by war type (Keep and explain why)
ggplot(IP, aes(TotalBDeathsU,WDuratMo)) + geom_point(aes(color=WarTypeD))+facet_grid(~ Americas)

#Total deaths and exposure time (days) by region
#ggplot(IP, aes(TotalBDeathsU,WDuratDays)) + geom_point(aes(color=V5RegionC))
#Total deaths and exposure time (months) by region
#ggplot(IP, aes(TotalBDeathsU,WDuratMo)) + geom_point(aes(color=V5RegionC))


#Total deaths and exposure time (days) by Americas indicator (Maybe keep)
#ggplot(IP, aes(TotalBDeathsU,WDuratDays)) + geom_point(aes(color=Americas))
#Total deaths and exposure time (months) by region
ggplot(IP, aes(TotalBDeathsU,WDuratMo)) + geom_point(aes(color=Americas))




#Temporal plots


#Deaths,war types, region by time (kind of like to keep)

# p1 <- ggplot(IP, 
#              aes(x = StartYr1, y = TotalBDeathsU)) +
#   geom_point()
# 
# p1
# 
# p2 <- ggplot(IP, 
#              aes(x = StartYr1, y = TotalBDeathsU)) +
#   geom_point()+facet_grid(~Americas)
# 
# p2


p3 <- ggplot(IP, 
             aes(x = StartYr1, y = TotalBDeathsU,group=WarTypeD,color=WarTypeD)) +
  geom_point()+facet_grid(~Americas)

p3






# p1 <- ggplot(IP, 
#              aes(x = StartYr1, y = TotalBDeathsU)) +
#   geom_line()+facet_grid(~Americas)
# 
# p1


# p1<-ggplot(IP, aes(x=Date,y= hms1))+ scale_x_date(breaks = date_breaks("1 day"))+
#   geom_linerange(aes(ymin = hms1, ymax = hms2),color = "red",size = 2)+ coord_flip()
# p1+ylab("Time")+ggtitle("Activity During Day")
# 
# ggplot(IP, aes(x=StartYr1))  +
#   scale_y_continuous(limits = c(0,10000), breaks=seq(0,10000,100))  +
#   geom_linerange(aes(ymin = Phase1_st, ymax = Phase1_en), color = "red",size = 2) + 
#   coord_flip() + ylab("Time (days)") + 
#   ggtitle("War Activity across 2 centuries")


# ggplot(IP, aes(x=StartYr1)) + 
#   scale_x_datetime(breaks = date_breaks("1 day")) +
#   scale_y_continuous(limits = c(0,10000), breaks=seq(0,10000,100), 
#                      labels=str_pad(seq(0,10000,100) %% 24, 2, pad="0")) +
#   geom_hline(yintercept=seq(0,48,24)) +
#   geom_linerange(aes(ymin = hms1a - Date, ymax = hms2a - Date), color = "red",size = 2) + 
#   coord_flip() + ylab("Time (hours)") + 
#   ggtitle("Activity During Day")



#Take a look at number of wars that transferred to another war (maybe show)
Toanothewar=subset(IP,TransTo!=-8)
Toanothewar%>%summarize(count=n())

#Take a look at numer of wars transferred from another war
Fanothewar=subset(IP,TransFrom!=-8)
Fanothewar%>%summarize(count=n())



#Initiator deaths Repeated above (KEEP BELOW) (One with exceptions removed)


p3 <- ggplot(IP, 
             aes(x = StartYr1, y =AbsDiffDeaths ,group=WarTypeD,color=WarTypeD)) +
  geom_point()+facet_grid(~Americas)

p3


p3 <- ggplot(IP, 
             aes(x = StartYr1, y =RelDiffDeaths ,group=WarTypeD,color=WarTypeD)) +
  geom_point()+facet_grid(~Americas)

p3



p3 <- ggplot(IP, 
             aes(x = StartYr1, y =AbsDiffDeaths ,group=OutcomeD,color=WarTypeD)) +
  geom_point()+facet_grid(~Americas)

p3


p3 <- ggplot(IP, 
             aes(x = StartYr1, y =RelDiffDeaths ,group=OutcomeD,color=WarTypeD)) +
  geom_point()+facet_grid(~Americas)

p3


#Output .png files here


