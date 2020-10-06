######################################################################
#
# Program to look at outcomes of initiator/recipient death percentages


#Discuss missingness and potential imputation
######################################################################

library(dplyr)
library(tidyverse)
library(caret)
library(e1071)

IP=read_csv("derived_data/International.csv");
IP$Americas=as.factor(IP$Americas)
IP$WarTypeD=as.factor(IP$WarTypeD)



IP=IP %>%
  group_by(WarNum) %>%
  mutate(seqid = dplyr::row_number())

IP_Mod1<-IP%>%select(WarNum,seqid,Americas,StartYR_Norm,WarTypeD,WDuratDays,AbsDiffDeaths,AbsDiffDeathsImp,InitiatorForces,RecipientForces)%>% drop_na

IP_Mod2<-IP%>%select(WarNum,seqid,Americas,StartYR_Norm,WarTypeD,WDuratDays,RelDiffDeaths,RelDiffDeathsImp,InitiatorForces,RecipientForces)%>% drop_na


#Create partition with seed




#df3=IP_Mod1 %>% dplyr::distinct(as.factor(WarNum), .keep_all = TRUE)
#df3b=IP_Mod2 %>% dplyr::distinct(as.factor(WarNum), .keep_all = TRUE)

df3=IP_Mod1%>%dplyr::filter(seqid==1)
df3b=IP_Mod2%>%dplyr::filter(seqid==1)


set.seed(280)




default_idx=sample(1:nrow(df3), .5*nrow(df3))


mod1_tr <- df3[ default_idx, ]
mod1_te <- df3[-default_idx, ]
#dupe=IP_Mod1 %>% group_by(WarNum) %>% filter(duplicated(WarNum) | n()==1)
dupe=subset(IP_Mod1,seqid!=1)
mod1_te=rbind(mod1_te,dupe)


default_idx2=sample(1:nrow(df3b), .5*nrow(df3b))

mod2_tr <- IP_Mod2[ default_idx2, ]
mod2_te <- IP_Mod2[-default_idx2, ]
dupe2=subset(IP_Mod2,seqid!=1)
mod2_te=rbind(mod2_te,dupe2)




#Absolute deaths
set.seed(7279)


cv_5 = trainControl(method = "cv", number = 5)


rpartFit1 <- train(AbsDiffDeaths ~ Americas+StartYR_Norm+WDuratDays+WarTypeD+InitiatorForces+RecipientForces, 
                   trControl=cv_5, 
                   method = "glm", 
                   data=mod1_tr,family="gaussian",na.action = na.pass)

mod1_pred <- predict(rpartFit1, mod1_te)
ps1=postResample(pred = mod1_pred, obs = mod1_te$AbsDiffDeaths)
tab1=summary(rpartFit1)



#Relative deaths


set.seed(280)

cv_5 = trainControl(method = "cv", number = 5)


rpartFit2 <- train(RelDiffDeaths ~ Americas+StartYR_Norm+WDuratDays+WarTypeD+InitiatorForces+RecipientForces, 
                   trControl=cv_5, 
                   method = "glm", 
                   data=mod2_tr,family="gaussian")

mod2_pred <- predict(rpartFit2, mod2_te)
ps2=postResample(pred = mod2_pred, obs = mod2_te$RelDiffDeaths)
tab2=summary(rpartFit2)






df1=data.frame(cbind('','',round(tab1$coefficients[,1],2),round(tab1$coefficients[,2],2),round(tab1$coefficients[,4],2)))
df2=data.frame(cbind('','',round(tab2$coefficients[,1],3),round(tab2$coefficients[,2],3),round(tab2$coefficients[,4],2)))

df1[1,1]='Intl Absolute difference in deaths non-imputed'
df2[1,1]='Intl Relative difference in deaths non-imputed'
df1[1,2]=round(ps1[2],3)
df2[1,2]=round(ps2[2],3)
colnames(df1)=c('Description','R2','Estimate','Std err','p-val')
colnames(df2)=c('Description','R2','Estimate','Std err','p-val')



df1=df1 %>%
  mutate_all(as.character)

df2=df2%>%
  mutate_all(as.character)


saveRDS(df1,"Aim1_deaths/IntlnonImpTr1.rds")
saveRDS(df2,"Aim1_deaths/IntlnonImpTr2.rds")










#Repeat on imputed

IP_Mod1<-IP%>%select(WarNum,seqid,Americas,StartYR_Norm,WarTypeD,WDuratDays,AbsDiffDeaths,AbsDiffDeathsImp,InitiatorForces,RecipientForces)

IP_Mod2<-IP%>%select(WarNum,seqid,Americas,StartYR_Norm,WarTypeD,WDuratDays,RelDiffDeaths,RelDiffDeathsImp,InitiatorForces,RecipientForces)


#Create partition with seed



set.seed(280)

df3=IP_Mod1%>%dplyr::filter(seqid==1)
df3b=IP_Mod2%>%dplyr::filter(seqid==1)


default_idx=sample(1:nrow(df3), .5*nrow(df3))


mod1_tr <- df3[ default_idx, ]
mod1_te <- df3[-default_idx, ]
#dupe=IP_Mod1 %>% group_by(WarNum) %>% filter(duplicated(WarNum) | n()==1)
dupe=subset(IP_Mod1,seqid!=1)
mod1_te=rbind(mod1_te,dupe)


default_idx2=sample(1:nrow(df3b), .5*nrow(df3b))

mod2_tr <- IP_Mod2[ default_idx2, ]
mod2_te <- IP_Mod2[-default_idx2, ]
dupe2=subset(IP_Mod2,seqid!=1)
mod2_te=rbind(mod2_te,dupe2)




#Absolute deaths
set.seed(7279)


cv_5 = trainControl(method = "cv", number = 5)


rpartFit1 <- train(AbsDiffDeathsImp ~ Americas+StartYR_Norm+WDuratDays+WarTypeD+InitiatorForces+RecipientForces, 
                   trControl=cv_5, 
                   method = "glm", 
                   data=mod1_tr,family="gaussian")

mod1_pred <- predict(rpartFit1, mod1_te)
postResample(pred = mod1_pred, obs = mod1_te$AbsDiffDeaths)
summary(rpartFit1)


set.seed(7279)


cv_5 = trainControl(method = "cv", number = 5)


rpartFit1 <- train(RelDiffDeathsImp ~ Americas+StartYR_Norm+WDuratDays+WarTypeD+InitiatorForces+RecipientForces, 
                   trControl=cv_5, 
                   method = "glm", 
                   data=mod2_tr,family="gaussian")

mod2_pred <- predict(rpartFit1, mod2_te)
postResample(pred = mod2_pred, obs = mod2_te$RelDiffDeaths)
summary(rpartFit1)


df1=data.frame(cbind('','',round(tab1$coefficients[,1],2),round(tab1$coefficients[,2],2),round(tab1$coefficients[,4],2)))
df2=data.frame(cbind('','',round(tab2$coefficients[,1],3),round(tab2$coefficients[,2],3),round(tab2$coefficients[,4],2)))

df1[1,1]='Intl Absolute difference in deaths imputed'
df2[1,1]='Intl Relative difference in deaths imputed'
df1[1,2]=round(ps1[2],3)
df2[1,2]=round(ps2[2],3)
colnames(df1)=c('Description','R2','Estimate','Std err','p-val')
colnames(df2)=c('Description','R2','Estimate','Std err','p-val')



df1=df1 %>%
  mutate_all(as.character)

df2=df2%>%
  mutate_all(as.character)


saveRDS(df1,"Aim1_deaths/IntlImpTr1.rds")
saveRDS(df2,"Aim1_deaths/IntlImpTr2.rds")










