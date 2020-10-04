######################################################################
#
# Program to look at outcomes of initiator/recipient death percentages with
#Internationalized conflicts


#Discuss missingness and potential imputation
######################################################################


library(caret)
library(gbm)
IP=read_csv("derived_data/International.csv");

#New start year 1 (Add to dataset)
IP$StartYR_Norm=IP$StartYr1-min(IP$StartYr1) 
IP$Americas=as.factor(IP$Americas)
IP$WarTypeD=as.factor(IP$WarTypeD)



IP_Mod1<-IP%>%select(WarNum,Americas,StartYR_Norm,WarTypeD,WDuratDays,AbsDiffDeaths)%>%filter(!is.na(AbsDiffDeaths))

IP_Mod2<-IP%>%select(WarNum,Americas,StartYR_Norm,WarTypeD,WDuratDays,RelDiffDeaths)%>%filter(!is.na(RelDiffDeaths))


#Simplest overall models
lm_fit=glm(AbsDiffDeaths ~Americas+StartYR_Norm+WDuratDays+WarTypeD,
           data = IP_Mod1, family='gaussian')

summary(lm_fit)

lm_fit2=glm(RelDiffDeaths ~Americas+StartYR_Norm+WDuratDays+WarTypeD,
            data = IP_Mod2, family='gaussian')

summary(lm_fit2)


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
postResample(pred = mod1_pred, obs = mod1_te$AbsDiffDeaths)

#


model.gbm <- gbm(AbsDiffDeaths ~ Americas+StartYR_Norm+WDuratDays+WarTypeD,
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


rpartFit1 <- train(RelDiffDeaths ~ Americas+StartYR_Norm+WDuratDays+WarTypeD, 
                   trControl=cv_5, 
                   method = "glm", 
                   data=mod2_tr,family="gaussian")

mod2_pred <- predict(rpartFit1, mod2_te)
postResample(pred = mod1_pred, obs = mod2_te$RelDiffDeaths)




model.gbm2 <- gbm(RelDiffDeaths ~ Americas+StartYR_Norm+WDuratDays+WarTypeD,
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
























