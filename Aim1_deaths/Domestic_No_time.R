######################################################################
#
# Program to look at outcomes of initiator/recipient death percentages


#Discuss missingness and potential imputation
######################################################################


library(caret)
library(gbm)
IP=read_csv("derived_data/Overall.csv");
IP$Americas=as.factor(IP$Americas)
IP$WarTypeD=as.factor(IP$WarTypeD)


IP_Mod1<-IP%>%select(WarNum,Americas,StartYR_Norm,WarTypeD,WDuratDays,AbsDiffDeaths,AbsDiffDeathsImp)%>%filter(!is.na(AbsDiffDeaths))

IP_Mod2<-IP%>%select(WarNum,Americas,StartYR_Norm,WarTypeD,WDuratDays,RelDiffDeaths,RelDiffDeathsImp)%>%filter(!is.na(RelDiffDeaths))


#Simplest overall models
lm_fit=glm(AbsDiffDeaths ~Americas+StartYR_Norm+WDuratDays+WarTypeD,
           data = IP_Mod1, family='gaussian')

tab1=summary(lm_fit)

lm_fit2=glm(RelDiffDeaths ~Americas+StartYR_Norm+WDuratDays+WarTypeD,
           data = IP_Mod2, family='gaussian')

tab2=summary(lm_fit2)


df1=data.frame(cbind('',round(tab1$coefficients[,1],2),round(tab1$coefficients[,2],2),round(tab1$coefficients[,4],2)))
df2=data.frame(cbind('',round(tab2$coefficients[,1],3),round(tab2$coefficients[,2],3),round(tab2$coefficients[,4],2)))

df1[1,1]='Absolute difference in deaths non-imputed'
df2[1,1]='Relative difference in deaths non-imputed'

colnames(df1)=c('Description','Estimate','Std err','p-val')
colnames(df2)=c('Description','Estimate','Std err','p-val')



df1=df1 %>%
  mutate_all(as.character)

df2=df2%>%
  mutate_all(as.character)


saveRDS(df1,"Aim1_deaths/nonImpSimp1.rds")
saveRDS(df2,"Aim1_deaths/nonImpSimp2.rds")

#Create partition with seed

set.seed(280)
default_idx=sample(1:nrow(IP_Mod1), .5*nrow(IP_Mod1))


mod1_tr <- IP_Mod1[ default_idx, ]
mod1_te <- IP_Mod1[-default_idx, ]

mod2_tr <- IP_Mod2[ default_idx, ]
mod2_te <- IP_Mod2[-default_idx, ]




#Absolute deaths
set.seed(7279)


cv_5 = trainControl(method = "cv", number = 5)


rpartFit1 <- train(AbsDiffDeaths ~ Americas+StartYR_Norm+WDuratDays+WarTypeD, 
                   trControl=cv_5, 
                   method = "glm", 
                   data=mod1_tr,family="gaussian")

mod1_pred <- predict(rpartFit1, mod1_te)
ps1=postResample(pred = mod1_pred, obs = mod1_te$AbsDiffDeaths)
tab1=summary(rpartFit1)



#Relative deaths
set.seed(280)

cv_5 = trainControl(method = "cv", number = 5)


rpartFit2 <- train(RelDiffDeaths ~ Americas+StartYR_Norm+WDuratDays+WarTypeD, 
                   trControl=cv_5, 
                   method = "glm", 
                   data=mod2_tr,family="gaussian")

mod2_pred <- predict(rpartFit2, mod2_te)
ps2=postResample(pred = mod2_pred, obs = mod2_te$RelDiffDeaths)
tab2=summary(rpartFit2)




df1=data.frame(cbind('','',round(tab1$coefficients[,1],2),round(tab1$coefficients[,2],2),round(tab1$coefficients[,4],2)))
df2=data.frame(cbind('','',round(tab2$coefficients[,1],3),round(tab2$coefficients[,2],3),round(tab2$coefficients[,4],2)))

df1[1,1]='Absolute difference in deaths non-imputed'
df2[1,1]='Relative difference in deaths non-imputed'
df1[1,2]=ps1[2]
df2[1,2]=ps2[2]
colnames(df1)=c('Description','R2','Estimate','Std err','p-val')
colnames(df2)=c('Description','R2','Estimate','Std err','p-val')



df1=df1 %>%
  mutate_all(as.character)

df2=df2%>%
  mutate_all(as.character)


saveRDS(df1,"Aim1_deaths/nonImpTr1.rds")
saveRDS(df2,"Aim1_deaths/nonImpTr2.rds")



#Repeat on imputed

IP_Mod1<-IP%>%select(WarNum,Americas,StartYR_Norm,WarTypeD,WDuratDays,AbsDiffDeaths,AbsDiffDeathsImp)
IP_Mod2<-IP%>%select(WarNum,Americas,StartYR_Norm,WarTypeD,WDuratDays,RelDiffDeaths,RelDiffDeathsImp)

#Simplest overall models
lm_fit=glm(AbsDiffDeathsImp ~Americas+StartYR_Norm+WDuratDays+WarTypeD,
           data = IP_Mod1, family='gaussian')

summary(lm_fit)

lm_fit2=glm(RelDiffDeathsImp ~Americas+StartYR_Norm+WDuratDays+WarTypeD,
            data = IP_Mod2, family='gaussian')

summary(lm_fit2)



#Absolute deaths


set.seed(280)
default_idx=sample(1:nrow(IP_Mod1), .5*nrow(IP_Mod1))


mod1_tr <- IP_Mod1[ default_idx, ]
mod1_te <- IP_Mod1[-default_idx, ]

mod2_tr <- IP_Mod2[ default_idx, ]
mod2_te <- IP_Mod2[-default_idx, ]




#Absolute deaths
set.seed(7279)


cv_5 = trainControl(method = "cv", number = 5)


rpartFit1 <- train(AbsDiffDeathsImp ~ Americas+StartYR_Norm+WDuratDays+WarTypeD, 
                   trControl=cv_5, 
                   method = "glm", 
                   data=mod1_tr,family="gaussian")

mod1_pred <- predict(rpartFit1, mod1_te)
ps1=postResample(pred = mod1_pred, obs = mod1_te$AbsDiffDeaths)
tab1=summary(rpartFit1)


#rel

set.seed(7279)


cv_5 = trainControl(method = "cv", number = 5)


rpartFit2 <- train(RelDiffDeathsImp ~ Americas+StartYR_Norm+WDuratDays+WarTypeD, 
                   trControl=cv_5, 
                   method = "glm", 
                   data=mod2_tr,family="gaussian")

mod2_pred <- predict(rpartFit2, mod2_te)
ps2=postResample(pred = mod2_pred, obs = mod2_te$RelDiffDeathsImp)
tab2=summary(rpartFit2)


df1=data.frame(cbind('','',round(tab1$coefficients[,1],2),round(tab1$coefficients[,2],2),round(tab1$coefficients[,4],2)))
df2=data.frame(cbind('','',round(tab2$coefficients[,1],3),round(tab2$coefficients[,2],3),round(tab2$coefficients[,4],2)))

df1[1,1]='Absolute difference in deaths imputed'
df2[1,1]='Relative difference in deaths imputed'
df1[1,2]=ps1[2]
df2[1,2]=ps2[2]
colnames(df1)=c('Description','R2','Estimate','Std err','p-val')
colnames(df2)=c('Description','R2','Estimate','Std err','p-val')



df1=df1 %>%
  mutate_all(as.character)

df2=df2%>%
  mutate_all(as.character)


saveRDS(df1,"Aim1_deaths/ImpTr1.rds")
saveRDS(df2,"Aim1_deaths/ImpTr2.rds")











