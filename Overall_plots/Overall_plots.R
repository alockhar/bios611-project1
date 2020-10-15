IP=read_csv("derived_data/Overall.csv");
IP2=read_csv("derived_data/Overall_Long.csv");

library(compareGroups)
library(Hmisc)
library(gridExtra)
library(dplyr)
library(mice)
library(cluster)
library(Rtsne)
library(tidyverse)
library(lubridate)
library(igraph)
library(RColorBrewer)
library(caret)
library(scales)
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
createTable(resu2,show.p.overall=FALSE)
saveRDS(resu2,'Overall_plots/plot_files/Table1.RDS')




#Total exposure time (days) 
png(file="Overall_plots/plot_files/Exposure_time2.png")
grp_plots <- by(IP, IP$Americas, function(sub){
  ggplot(sub, aes(WDuratDays)) + 
    geom_histogram(aes(y = (..count..)/sum(..count..))) + ggtitle(sub$Americas[[1]]) +
    theme(plot.title = element_text(hjust = 0.5))+xlab('Total days of war')+ylab('Proportion of total wars by Americas group')
})
grid.arrange(grobs = grp_plots, ncol=2)
dev.off()


#ggplot(IP, aes(x = WDuratDays)) +  
 # geom_histogram(aes(y = (..count..)/sum(..count..))) + ylab('Proportion of wars')+xlab('Duration of war (days)')+facet_grid(~ Americas)+theme_bw()

#Total number of battle-related deaths both sides (Keep and explain why)
#png(file="Overall_plots/plot_files/Battle deaths Both.png")
#ggplot(IP,aes(x=TotalBDeaths))+geom_histogram(aes(y = (..count..)/sum(..count..)))+xlab('Total number of battle-related deaths both sides')+ylab('Proportion of wars')+ylab('Frequency')
#dev.off()




#Total deaths by Americas facet grid (Keep and explain why)
png(file="Overall_plots/plot_files/Battle_deaths_Both3.png")
ggplot(IP,aes(y=TotalBDeathsU,x=Americas))+geom_boxplot()+labs(title = "Number of deaths by wartype and Americas indicator",
       caption = "Any wars greater than 50000 deaths set to 50000")+
  theme(plot.title = element_text(hjust = 0.5))+facet_grid(~WarTypeD)+ylab('Number of deaths')
dev.off()


#Total deaths and exposure time (months) by war type (Keep and explain why)
png(file="Overall_plots/plot_files/War_type_deaths_Americas_4.png")
ggplot(IP, aes(TotalBDeathsU,WDuratDays,color=WarTypeD)) + geom_point()+facet_grid(~ Americas)+xlab('Total deaths (thousands)')+ylab('Total days of war')+scale_x_continuous(labels = seq(0, 50, 10))+ labs(color='War Type')
dev.off()


#Total deaths and exposure time (days) by Americas indicator (Maybe keep)
#ggplot(IP, aes(TotalBDeathsU,WDuratDays)) + geom_point(aes(color=Americas))
#Total deaths and exposure time (months) by region
#ggplot(IP, aes(TotalBDeathsU,WDuratMo)) + geom_point(aes(color=Americas))




#Temporal plots

png(file="Overall_plots/plot_files/Start_year_5.png")
 ggplot(IP, 
             aes(x = StartYr1, y = TotalBDeathsU,group=WarTypeD,color=WarTypeD)) +
  geom_point()+facet_grid(~Americas)+ylab('Total deaths')+xlab('Start year')+ labs(color='War Type')
dev.off()


#Take a look at number of wars that transferred to another war (maybe show)
# Toanothewar=subset(IP,TransTo!=-8)
# Toanothewar%>%summarize(count=n())
# 
# #Take a look at numer of wars transferred from another war
# Fanothewar=subset(IP,TransFrom!=-8)
# Fanothewar%>%summarize(count=n())



#Initiator deaths Repeated above (KEEP BELOW) (One with exceptions removed)




p1= ggplot(IP, 
             aes(x = StartYr1, y =AbsDiffDeaths ,group=OutcomeD,color=WarTypeD)) +
  geom_point()+facet_grid(~Americas)+ylab('Absolute Difference in initiator deaths')+xlab('Start year 1')+labs(color='War Type')



p2= IP %>% filter(AbsDiffDeaths!=-374775)%>%{ggplot(.,aes(x = StartYr1, y =AbsDiffDeaths ,group=OutcomeD,color=WarTypeD)) +
   geom_point()+facet_grid(~Americas)+ylab('Absolute Difference in initiator deaths')+xlab('Start year 1')+labs(color='War Type',caption = "Extreme values removed")}
 
 
png(file="Overall_plots/plot_files/Abs_6.png")
grid.arrange(p1, p2, nrow = 2)
dev.off()
 
p3 =ggplot(IP, 
             aes(x = StartYr1, y =RelDiffDeaths ,group=OutcomeD,color=WarTypeD)) +
  geom_point()+facet_grid(~Americas)+ylab('Relative Difference in initiator deaths')+xlab('Start year 1')+labs(color='War Type')

p4=IP %>% filter(RelDiffDeaths<.4)%>%{ggplot(.,aes(x = StartYr1, y =RelDiffDeaths ,group=OutcomeD,color=WarTypeD)) +
    geom_point()+facet_grid(~Americas)+ylab('Relative Difference in initiator deaths')+xlab('Start year 1')+labs(color='War Type',caption = "Extreme values removed")}


png(file="Overall_plots/plot_files/Rel_7.png")
grid.arrange(p3, p4, nrow = 2)
dev.off()




