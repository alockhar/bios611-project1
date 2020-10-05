IP=read_csv("derived_data/Overall.csv");
IP2=read_csv("derived_data/Overall_Long.csv");

library(compareGroups)
library(Hmisc)
library(gridExtra)
#Look at overall attributes by Americas indicator in table
#Table 1 object


label(IP$Intnl)="Internationalized"
label(IP$TotalBDeaths)="Total deaths"
label(IP$WDuratDays)="Total days of war"
label(IP$WarTypeC)="Type of War"
label(IP$InitiatorDeaths)="Initiator Deaths"
label(IP$RecipientDeaths)="Recipient Deaths"
label(IP$RelDiffDeaths)="Relative difference in initiator deaths"
label(IP$AbsDiffDeaths)="Absolute difference in initiator deaths"
label(IP$StartYR_Norm)="Time since first curation  (years)"


resu2 <- compareGroups(Americas ~ WarTypeC +WDuratDays+InitiatorDeaths+RecipientDeaths+RelDiffDeaths+AbsDiffDeaths+StartYR_Norm+OutcomeC+TotalBDeaths+Intnl+OutcomeE , data = IP, 
                       method=c(WarTypeC=3,OutcomeC=3,OutcomeE=3), Q1 = 0.025, Q3 = 0.975)
createTable(resu2)
saveRDS(resu2,'Overall_plots/plot_files/Table1.RDS')




#Total exposure time (days) 
png(file="Overall_plots/plot_files/Exposure time2.png")
ggplot(IP, aes(x = WDuratDays)) +  
  geom_histogram(aes(y = (..count..)/sum(..count..))) + ylab('Proportion of wars')+xlab('Duration of war (days)')+facet_grid(~ Americas)
dev.off()

#Total number of battle-related deaths both sides (Keep and explain why)
#png(file="Overall_plots/plot_files/Battle deaths Both.png")
#ggplot(IP,aes(x=TotalBDeaths))+geom_histogram(aes(y = (..count..)/sum(..count..)))+xlab('Total number of battle-related deaths both sides')+ylab('Proportion of wars')+ylab('Frequency')
#dev.off()




#Total deaths by Americas facet grid (Keep and explain why)
png(file="Overall_plots/plot_files/Battle deaths Both3.png")
ggplot(IP,aes(y=TotalBDeathsU,x=Americas))+geom_boxplot()+ylab('Upper limit greater than 50000 set to 50000 deaths')+facet_grid(~ WarTypeD)
dev.off()


#Total deaths and exposure time (months) by war type (Keep and explain why)
png(file="Overall_plots/plot_files/War type deaths Americas 4.png")
ggplot(IP, aes(TotalBDeathsU,WDuratDays)) + geom_point(aes(color=WarTypeD))+facet_grid(~ Americas)+xlab('Total deaths')+ylab('Total days of war')
dev.off()


#Total deaths and exposure time (days) by Americas indicator (Maybe keep)
#ggplot(IP, aes(TotalBDeathsU,WDuratDays)) + geom_point(aes(color=Americas))
#Total deaths and exposure time (months) by region
#ggplot(IP, aes(TotalBDeathsU,WDuratMo)) + geom_point(aes(color=Americas))




#Temporal plots

png(file="Overall_plots/plot_files/Start year 5.png")
 ggplot(IP, 
             aes(x = StartYr1, y = TotalBDeathsU,group=WarTypeD,color=WarTypeD)) +
  geom_point()+facet_grid(~Americas)
dev.off()

# p3 <- ggplot(IP, 
#              aes(x = StartYR_Norm, y = TotalBDeathsU,group=WarTypeD,color=WarTypeD)) +
#   geom_point()+facet_grid(~Americas)
# 
# p3






#Take a look at number of wars that transferred to another war (maybe show)
# Toanothewar=subset(IP,TransTo!=-8)
# Toanothewar%>%summarize(count=n())
# 
# #Take a look at numer of wars transferred from another war
# Fanothewar=subset(IP,TransFrom!=-8)
# Fanothewar%>%summarize(count=n())



#Initiator deaths Repeated above (KEEP BELOW) (One with exceptions removed)

# 
# p3 <- ggplot(IP, 
#              aes(x = StartYr1, y =AbsDiffDeaths ,group=WarTypeD,color=WarTypeD)) +
#   geom_point()+facet_grid(~Americas)
# 
# p3
# 
# 
# p3 <- ggplot(IP, 
#              aes(x = StartYr1, y =RelDiffDeaths ,group=WarTypeD,color=WarTypeD)) +
#   geom_point()+facet_grid(~Americas)
# 
# p3



p1= ggplot(IP, 
             aes(x = StartYr1, y =AbsDiffDeaths ,group=OutcomeD,color=WarTypeD)) +
  geom_point()+facet_grid(~Americas)+ylab('Absolute Difference in initiator deaths')+xlab('Start year 1')



p2= IP2 %>% filter(AbsDiffDeaths!=-374775)%>%{ggplot(.,aes(x = StartYr1, y =AbsDiffDeaths ,group=OutcomeD,color=WarTypeD)) +
   geom_point()+facet_grid(~Americas)+ylab('Absolute Difference in initiator deaths')+xlab('Start year 1')}
 
 
 
 
p3 =ggplot(IP, 
             aes(x = StartYr1, y =RelDiffDeaths ,group=OutcomeD,color=WarTypeD)) +
  geom_point()+facet_grid(~Americas)+ylab('Relative Difference in initiator deaths')+xlab('Start year 1')

p4=IP2 %>% filter(RelDiffDeaths<100)%>%{ggplot(.,aes(x = StartYr1, y =RelDiffDeaths ,group=OutcomeD,color=WarTypeD)) +
    geom_point()+facet_grid(~Americas)+ylab('Relative Difference in initiator deaths')+xlab('Start year 1')}

png(file="Overall_plots/plot_files/Abs 6.png")
grid.arrange(p1, p2, nrow = 2)
dev.off()
png(file="Overall_plots/plot_files/Rel 7.png")
grid.arrange(p3, p4, nrow = 2)
dev.off()


#Output .png files here


