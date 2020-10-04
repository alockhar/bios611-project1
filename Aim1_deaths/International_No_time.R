######################################################################
#
# Program to look at outcomes of initiator/recipient death percentages


#Discuss missingness and potential imputation
######################################################################

library(dplyr)
library(tidyverse)
library(caret)
library(gbm)
library(geepack)
library(data.table)


IP=read_csv("derived_data/International.csv");
IP$Americas=as.factor(IP$Americas)
IP$WarTypeD=as.factor(IP$WarTypeD)



IP=IP %>%
  group_by(WarNum) %>%
  mutate(seqid = dplyr::row_number())

IP_Mod1<-IP%>%select(WarNum,seqid,Americas,StartYR_Norm,WarTypeD,WDuratDays,AbsDiffDeaths,AbsDiffDeathsImp,InitiatorForces,RecipientForces)%>%filter(!is.na(AbsDiffDeaths))

IP_Mod2<-IP%>%select(WarNum,seqid,Americas,StartYR_Norm,WarTypeD,WDuratDays,RelDiffDeaths,RelDiffDeathsImp,InitiatorForces,RecipientForces)%>%filter(!is.na(RelDiffDeaths))


#Create partition with seed

df3=IP_Mod1 %>% dplyr::distinct(as.factor(WarNum), .keep_all = TRUE)
df3b=IP_Mod2 %>% dplyr::distinct(as.factor(WarNum), .keep_all = TRUE)




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
#dupe2=subset(IP_Mod2,seqid!=1)
#mod2_te=rbind(mod2_te,dupe2)




#Absolute deaths
set.seed(7279)


cv_5 = trainControl(method = "cv", number = 5)


rpartFit1 <- train(AbsDiffDeaths ~ Americas+StartYR_Norm+WDuratDays+WarTypeD+InitiatorForces+RecipientForces, 
                   trControl=cv_5, 
                   method = "glm", 
                   data=mod1_tr,family="gaussian")

mod1_pred <- predict(rpartFit1, mod1_te)
postResample(pred = mod1_pred, obs = mod1_te$AbsDiffDeaths)
summary(rpartFit1)
#


model.gbm <- gbm(AbsDiffDeaths ~ Americas+StartYR_Norm+WDuratDays+WarTypeD+InitiatorForces+RecipientForces,
                 distribution="gaussian",
                 data=mod1_tr,
                 n.trees = 200,
                 interaction.depth = 5,cv.folds = 5, 
                 shrinkage=0.1);
summary(model.gbm,plot=FALSE)

best.iter <- gbm.perf(model.gbm, method = "cv")
print(best.iter)

Yhat <- predict(model.gbm, newdata = mod1_te, n.trees = best.iter, type = "link")

# least squares error
print(sum((mod1_te$AbsDiffDeaths - Yhat)^2))



#Relative deaths









set.seed(280)

cv_5 = trainControl(method = "cv", number = 5)


rpartFit1 <- train(RelDiffDeaths ~ Americas+StartYR_Norm+WDuratDays+WarTypeD+InitiatorForces+RecipientForces, 
                   trControl=cv_5, 
                   method = "glm", 
                   data=mod2_tr,family="gaussian")

mod2_pred <- predict(rpartFit1, mod2_te)
postResample(pred = mod2_pred, obs = mod2_te$RelDiffDeaths)




model.gbm2 <- gbm(RelDiffDeaths ~ Americas+StartYR_Norm+WDuratDays+WarTypeD+InitiatorForces+RecipientForces,
                  distribution="gaussian",
                  data=mod2_tr,
                  n.trees = 200,
                  interaction.depth = 5,cv.folds = 5, 
                  shrinkage=0.1);
summary(model.gbm,plot=FALSE)

best.iter <- gbm.perf(model.gbm, method = "cv")
print(best.iter)

Yhat <- predict(model.gbm, newdata = mod2_te, n.trees = best.iter, type = "link")

# least squares error
print(sum((mod2_te$RelDiffDeaths - Yhat)^2))






#Repeat on imputed

IP_Mod1<-IP%>%select(WarNum,seqid,Americas,StartYR_Norm,WarTypeD,WDuratDays,AbsDiffDeaths,AbsDiffDeathsImp,InitiatorForces,RecipientForces)

IP_Mod2<-IP%>%select(WarNum,seqid,Americas,StartYR_Norm,WarTypeD,WDuratDays,RelDiffDeaths,RelDiffDeathsImp,InitiatorForces,RecipientForces)


#Create partition with seed

df3=IP_Mod1 %>% dplyr::distinct(as.factor(WarNum), .keep_all = TRUE)
df3b=IP_Mod2 %>% dplyr::distinct(as.factor(WarNum), .keep_all = TRUE)




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
#dupe2=subset(IP_Mod2,seqid!=1)
#mod2_te=rbind(mod2_te,dupe2)




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
#


model.gbm <- gbm(AbsDiffDeathsImp ~ Americas+StartYR_Norm+WDuratDays+WarTypeD+InitiatorForces+RecipientForces,
                 distribution="gaussian",
                 data=mod1_tr,
                 n.trees = 200,
                 interaction.depth = 5,cv.folds = 5, 
                 shrinkage=0.1);
summary(model.gbm,plot=FALSE)

best.iter <- gbm.perf(model.gbm, method = "cv")
print(best.iter)

Yhat <- predict(model.gbm, newdata = mod1_te, n.trees = best.iter, type = "link")

# least squares error
print(sum((mod1_te$AbsDiffDeathsImp - Yhat)^2))
















