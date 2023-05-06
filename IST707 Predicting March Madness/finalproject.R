
#load packages
library(tidyverse)
library(dbplyr)
library(caret)
library(rpart)
library(rpart.plot)
library(rattle)
library(ggplot2)
library(e1071)
library(tm)
library(wordcloud)
library(tidyr)
library(tidytext)
set.seed(475)

RankVSeed <- cor(MarchMadness$avg_rank,MarchMadness$mr_seed_num)
AttemptVMade <- cor(MarchMadness$avg_FGA,MarchMadness$avg_FGM)
MadeVScore <- cor(MarchMadness$avg_FGM,MarchMadness$avg_Score)
data.frame(RankVSeed,AttemptVMade,MadeVScore)


#load in dataset
MarchMadness <- read_csv("C:/Users/richa/OneDrive - Syracuse University/Documents/_01-Syracuse/03_Summer 2022/IST 707 Data Analytics/Project/march madness.csv", col_names=TRUE)
View(MarchMadness)
nrow(MarchMadness)
MarchMadnessSpecified <- MarchMadness[,-c(1:5)]
MarchMadnessSpecified <- MarchMadnessSpecified[complete.cases(MarchMadnessSpecified),]
MarchMadness$conf <- as.factor(MarchMadness$conf)
MarchMadness$opp_conf <- as.factor(MarchMadness$opp_conf)

#building training and testing
testset <- MarchMadnessSpecified[MarchMadnessSpecified$season=="2021",]
trainset <- MarchMadnessSpecified[MarchMadnessSpecified$season!="2021",]
testset <- testset[,-2] 
trainset <- trainset[,-2] 
View(testset)
View(trainset)

#make factors
#trainset$loc <- as.factor(trainset$loc)
trainset$result <- as.factor(trainset$result)
#testset$loc <- as.factor(testset$loc)
testset$result <- as.factor(testset$result)

#number of winning games
nrow(MarchMadnessSpecified)
nrow(trainset[trainset$result==1,])
nrow(testset[testset$result==1,])


###remove labels from testset
answers <- testset$result
testset <- testset[,-1]
nrow(answers)
str(testset)

#bin values
testsetNew <- data.frame(testset$conf)
testsetNew$opp_conf <- testset$opp_conf
testsetNew$mr_seed_num <- testset$mr_seed_num
testsetNew$opp_mr_seed_num <- testset$opp_mr_seed_num
testsetNew$avg_DR  <- cut(testset$avg_DR  , breaks = 3, labels = c('low', 'medium', 'high'))                      
testsetNew$avg_OR  <- cut(testset$avg_OR  , breaks = 3, labels = c('low', 'medium', 'high'))                      
testsetNew$avg_PF  <- cut(testset$avg_PF  , breaks = 3, labels = c('low', 'medium', 'high'))                      
testsetNew$avg_TO  <- cut(testset$avg_TO  , breaks = 3, labels = c('low', 'medium', 'high'))                      
testsetNew$avg_Ast  <- cut(testset$avg_Ast  , breaks = 3, labels = c('low', 'medium', 'high'))                    
testsetNew$avg_Blk  <- cut(testset$avg_Blk  , breaks = 3, labels = c('low', 'medium', 'high'))                    
testsetNew$avg_FGA  <- cut(testset$avg_FGA  , breaks = 3, labels = c('low', 'medium', 'high'))                    
testsetNew$avg_FGM  <- cut(testset$avg_FGM  , breaks = 3, labels = c('low', 'medium', 'high'))                    
testsetNew$avg_FTA  <- cut(testset$avg_FTA  , breaks = 3, labels = c('low', 'medium', 'high'))                    
testsetNew$avg_FTM  <- cut(testset$avg_FTM  , breaks = 3, labels = c('low', 'medium', 'high'))                    
testsetNew$avg_Stl  <- cut(testset$avg_Stl  , breaks = 3, labels = c('low', 'medium', 'high'))                    
testsetNew$avg_FGA3  <- cut(testset$avg_FGA3  , breaks = 3, labels = c('low', 'medium', 'high'))                  
testsetNew$avg_FGM3  <- cut(testset$avg_FGM3  , breaks = 3, labels = c('low', 'medium', 'high'))                  
testsetNew$avg_rank  <- cut(testset$avg_rank  , breaks = 3, labels = c('low', 'medium', 'high'))                  
testsetNew$avg_Score  <- cut(testset$avg_Score  , breaks = 3, labels = c('low', 'medium', 'high'))                
testsetNew$avg_DR_opp  <- cut(testset$avg_DR_opp  , breaks = 3, labels = c('low', 'medium', 'high'))              
testsetNew$avg_OR_opp  <- cut(testset$avg_OR_opp  , breaks = 3, labels = c('low', 'medium', 'high'))              
testsetNew$avg_PF_opp  <- cut(testset$avg_PF_opp  , breaks = 3, labels = c('low', 'medium', 'high'))              
testsetNew$avg_TO_opp  <- cut(testset$avg_TO_opp  , breaks = 3, labels = c('low', 'medium', 'high'))              
testsetNew$opp_avg_DR  <- cut(testset$opp_avg_DR  , breaks = 3, labels = c('low', 'medium', 'high'))              
testsetNew$opp_avg_OR  <- cut(testset$opp_avg_OR  , breaks = 3, labels = c('low', 'medium', 'high'))              
testsetNew$opp_avg_PF  <- cut(testset$opp_avg_PF  , breaks = 3, labels = c('low', 'medium', 'high'))              
testsetNew$opp_avg_TO  <- cut(testset$opp_avg_TO  , breaks = 3, labels = c('low', 'medium', 'high'))              
testsetNew$avg_Ast_opp  <- cut(testset$avg_Ast_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$avg_Blk_opp  <- cut(testset$avg_Blk_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$avg_FGA_opp  <- cut(testset$avg_FGA_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$avg_FGM_opp  <- cut(testset$avg_FGM_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$avg_FTA_opp  <- cut(testset$avg_FTA_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$avg_FTM_opp  <- cut(testset$avg_FTM_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$avg_Stl_opp  <- cut(testset$avg_Stl_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$opp_avg_Ast  <- cut(testset$opp_avg_Ast  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$opp_avg_Blk  <- cut(testset$opp_avg_Blk  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$opp_avg_FGA  <- cut(testset$opp_avg_FGA  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$opp_avg_FGM  <- cut(testset$opp_avg_FGM  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$opp_avg_FTA  <- cut(testset$opp_avg_FTA  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$opp_avg_FTM  <- cut(testset$opp_avg_FTM  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$opp_avg_Stl  <- cut(testset$opp_avg_Stl  , breaks = 3, labels = c('low', 'medium', 'high'))            
testsetNew$avg_FGA3_opp  <- cut(testset$avg_FGA3_opp  , breaks = 3, labels = c('low', 'medium', 'high'))          
testsetNew$avg_FGM3_opp  <- cut(testset$avg_FGM3_opp  , breaks = 3, labels = c('low', 'medium', 'high'))          
testsetNew$opp_avg_FGA3  <- cut(testset$opp_avg_FGA3  , breaks = 3, labels = c('low', 'medium', 'high'))          
testsetNew$opp_avg_FGM3  <- cut(testset$opp_avg_FGM3  , breaks = 3, labels = c('low', 'medium', 'high'))          
testsetNew$opp_avg_rank  <- cut(testset$opp_avg_rank  , breaks = 3, labels = c('low', 'medium', 'high'))          
testsetNew$avg_Score_opp  <- cut(testset$avg_Score_opp  , breaks = 3, labels = c('low', 'medium', 'high'))        
testsetNew$opp_avg_Score  <- cut(testset$opp_avg_Score  , breaks = 3, labels = c('low', 'medium', 'high'))        
testsetNew$opp_avg_DR_opp  <- cut(testset$opp_avg_DR_opp  , breaks = 3, labels = c('low', 'medium', 'high'))      
testsetNew$opp_avg_OR_opp  <- cut(testset$opp_avg_OR_opp  , breaks = 3, labels = c('low', 'medium', 'high'))      
testsetNew$opp_avg_PF_opp  <- cut(testset$opp_avg_PF_opp  , breaks = 3, labels = c('low', 'medium', 'high'))      
testsetNew$opp_avg_TO_opp  <- cut(testset$opp_avg_TO_opp  , breaks = 3, labels = c('low', 'medium', 'high'))      
testsetNew$opp_avg_Ast_opp  <- cut(testset$opp_avg_Ast_opp  , breaks = 3, labels = c('low', 'medium', 'high'))    
testsetNew$opp_avg_Blk_opp  <- cut(testset$opp_avg_Blk_opp  , breaks = 3, labels = c('low', 'medium', 'high'))    
testsetNew$opp_avg_FGA_opp  <- cut(testset$opp_avg_FGA_opp  , breaks = 3, labels = c('low', 'medium', 'high'))    
testsetNew$opp_avg_FGM_opp  <- cut(testset$opp_avg_FGM_opp  , breaks = 3, labels = c('low', 'medium', 'high'))    
testsetNew$opp_avg_FTA_opp  <- cut(testset$opp_avg_FTA_opp  , breaks = 3, labels = c('low', 'medium', 'high'))    
testsetNew$opp_avg_FTM_opp  <- cut(testset$opp_avg_FTM_opp  , breaks = 3, labels = c('low', 'medium', 'high'))    
testsetNew$opp_avg_Stl_opp  <- cut(testset$opp_avg_Stl_opp  , breaks = 3, labels = c('low', 'medium', 'high'))   
testsetNew$opp_avg_FGA3_opp  <- cut(testset$opp_avg_FGA3_opp  , breaks = 3, labels = c('low', 'medium', 'high'))  
testsetNew$opp_avg_FGM3_opp  <- cut(testset$opp_avg_FGM3_opp  , breaks = 3, labels = c('low', 'medium', 'high')) 
testsetNew$opp_avg_Score_opp  <- cut(testset$opp_avg_Score_opp  , breaks = 3, labels = c('low', 'medium', 'high'))

#train
trainsetNew <- data.frame(trainset$conf)
trainsetNew$opp_conf <- trainset$opp_conf
trainsetNew$mr_seed_num <- trainset$mr_seed_num
trainsetNew$opp_mr_seed_num <- trainset$opp_mr_seed_num
trainsetNew$result <- trainset$result
trainsetNew$avg_DR  <- cut(trainset$avg_DR  , breaks = 3, labels = c('low', 'medium', 'high'))                      
trainsetNew$avg_OR  <- cut(trainset$avg_OR  , breaks = 3, labels = c('low', 'medium', 'high'))                      
trainsetNew$avg_PF  <- cut(trainset$avg_PF  , breaks = 3, labels = c('low', 'medium', 'high'))                      
trainsetNew$avg_TO  <- cut(trainset$avg_TO  , breaks = 3, labels = c('low', 'medium', 'high'))                      
trainsetNew$avg_Ast  <- cut(trainset$avg_Ast  , breaks = 3, labels = c('low', 'medium', 'high'))                    
trainsetNew$avg_Blk  <- cut(trainset$avg_Blk  , breaks = 3, labels = c('low', 'medium', 'high'))                    
trainsetNew$avg_FGA  <- cut(trainset$avg_FGA  , breaks = 3, labels = c('low', 'medium', 'high'))                    
trainsetNew$avg_FGM  <- cut(trainset$avg_FGM  , breaks = 3, labels = c('low', 'medium', 'high'))                    
trainsetNew$avg_FTA  <- cut(trainset$avg_FTA  , breaks = 3, labels = c('low', 'medium', 'high'))                    
trainsetNew$avg_FTM  <- cut(trainset$avg_FTM  , breaks = 3, labels = c('low', 'medium', 'high'))                    
trainsetNew$avg_Stl  <- cut(trainset$avg_Stl  , breaks = 3, labels = c('low', 'medium', 'high'))                    
trainsetNew$avg_FGA3  <- cut(trainset$avg_FGA3  , breaks = 3, labels = c('low', 'medium', 'high'))                  
trainsetNew$avg_FGM3  <- cut(trainset$avg_FGM3  , breaks = 3, labels = c('low', 'medium', 'high'))                  
trainsetNew$avg_rank  <- cut(trainset$avg_rank  , breaks = 3, labels = c('low', 'medium', 'high'))                  
trainsetNew$avg_Score  <- cut(trainset$avg_Score  , breaks = 3, labels = c('low', 'medium', 'high'))                
trainsetNew$avg_DR_opp  <- cut(trainset$avg_DR_opp  , breaks = 3, labels = c('low', 'medium', 'high'))              
trainsetNew$avg_OR_opp  <- cut(trainset$avg_OR_opp  , breaks = 3, labels = c('low', 'medium', 'high'))              
trainsetNew$avg_PF_opp  <- cut(trainset$avg_PF_opp  , breaks = 3, labels = c('low', 'medium', 'high'))              
trainsetNew$avg_TO_opp  <- cut(trainset$avg_TO_opp  , breaks = 3, labels = c('low', 'medium', 'high'))              
trainsetNew$opp_avg_DR  <- cut(trainset$opp_avg_DR  , breaks = 3, labels = c('low', 'medium', 'high'))              
trainsetNew$opp_avg_OR  <- cut(trainset$opp_avg_OR  , breaks = 3, labels = c('low', 'medium', 'high'))              
trainsetNew$opp_avg_PF  <- cut(trainset$opp_avg_PF  , breaks = 3, labels = c('low', 'medium', 'high'))              
trainsetNew$opp_avg_TO  <- cut(trainset$opp_avg_TO  , breaks = 3, labels = c('low', 'medium', 'high'))              
trainsetNew$avg_Ast_opp  <- cut(trainset$avg_Ast_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$avg_Blk_opp  <- cut(trainset$avg_Blk_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$avg_FGA_opp  <- cut(trainset$avg_FGA_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$avg_FGM_opp  <- cut(trainset$avg_FGM_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$avg_FTA_opp  <- cut(trainset$avg_FTA_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$avg_FTM_opp  <- cut(trainset$avg_FTM_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$avg_Stl_opp  <- cut(trainset$avg_Stl_opp  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$opp_avg_Ast  <- cut(trainset$opp_avg_Ast  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$opp_avg_Blk  <- cut(trainset$opp_avg_Blk  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$opp_avg_FGA  <- cut(trainset$opp_avg_FGA  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$opp_avg_FGM  <- cut(trainset$opp_avg_FGM  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$opp_avg_FTA  <- cut(trainset$opp_avg_FTA  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$opp_avg_FTM  <- cut(trainset$opp_avg_FTM  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$opp_avg_Stl  <- cut(trainset$opp_avg_Stl  , breaks = 3, labels = c('low', 'medium', 'high'))            
trainsetNew$avg_FGA3_opp  <- cut(trainset$avg_FGA3_opp  , breaks = 3, labels = c('low', 'medium', 'high'))          
trainsetNew$avg_FGM3_opp  <- cut(trainset$avg_FGM3_opp  , breaks = 3, labels = c('low', 'medium', 'high'))          
trainsetNew$opp_avg_FGA3  <- cut(trainset$opp_avg_FGA3  , breaks = 3, labels = c('low', 'medium', 'high'))          
trainsetNew$opp_avg_FGM3  <- cut(trainset$opp_avg_FGM3  , breaks = 3, labels = c('low', 'medium', 'high'))          
trainsetNew$opp_avg_rank  <- cut(trainset$opp_avg_rank  , breaks = 3, labels = c('low', 'medium', 'high'))          
trainsetNew$avg_Score_opp  <- cut(trainset$avg_Score_opp  , breaks = 3, labels = c('low', 'medium', 'high'))        
trainsetNew$opp_avg_Score  <- cut(trainset$opp_avg_Score  , breaks = 3, labels = c('low', 'medium', 'high'))        
trainsetNew$opp_avg_DR_opp  <- cut(trainset$opp_avg_DR_opp  , breaks = 3, labels = c('low', 'medium', 'high'))      
trainsetNew$opp_avg_OR_opp  <- cut(trainset$opp_avg_OR_opp  , breaks = 3, labels = c('low', 'medium', 'high'))      
trainsetNew$opp_avg_PF_opp  <- cut(trainset$opp_avg_PF_opp  , breaks = 3, labels = c('low', 'medium', 'high'))      
trainsetNew$opp_avg_TO_opp  <- cut(trainset$opp_avg_TO_opp  , breaks = 3, labels = c('low', 'medium', 'high'))      
trainsetNew$opp_avg_Ast_opp  <- cut(trainset$opp_avg_Ast_opp  , breaks = 3, labels = c('low', 'medium', 'high'))    
trainsetNew$opp_avg_Blk_opp  <- cut(trainset$opp_avg_Blk_opp  , breaks = 3, labels = c('low', 'medium', 'high'))    
trainsetNew$opp_avg_FGA_opp  <- cut(trainset$opp_avg_FGA_opp  , breaks = 3, labels = c('low', 'medium', 'high'))    
trainsetNew$opp_avg_FGM_opp  <- cut(trainset$opp_avg_FGM_opp  , breaks = 3, labels = c('low', 'medium', 'high'))    
trainsetNew$opp_avg_FTA_opp  <- cut(trainset$opp_avg_FTA_opp  , breaks = 3, labels = c('low', 'medium', 'high'))    
trainsetNew$opp_avg_FTM_opp  <- cut(trainset$opp_avg_FTM_opp  , breaks = 3, labels = c('low', 'medium', 'high'))    
trainsetNew$opp_avg_Stl_opp  <- cut(trainset$opp_avg_Stl_opp  , breaks = 3, labels = c('low', 'medium', 'high'))   
trainsetNew$opp_avg_FGA3_opp  <- cut(trainset$opp_avg_FGA3_opp  , breaks = 3, labels = c('low', 'medium', 'high'))  
trainsetNew$opp_avg_FGM3_opp  <- cut(trainset$opp_avg_FGM3_opp  , breaks = 3, labels = c('low', 'medium', 'high')) 
trainsetNew$opp_avg_Score_opp  <- cut(trainset$opp_avg_Score_opp  , breaks = 3, labels = c('low', 'medium', 'high'))

View(testsetNew)

###### Naive Bayes
nb <- naiveBayes(result~., data = trainset)
nbPredict <- predict(nb, testset, type= 'class')
table1 <- (table(nbPredict, answers)) 
AccuracyNB <- sum(diag(table1)) / sum(table1)
table1
AccuracyNB

###### Naive Bayes
nb2 <- naiveBayes(result~., data = trainsetNew)
nbPredict2 <- predict(nb2, testsetNew, type= 'class')
tables <- (table(nbPredict2, answers)) 
AccuracyNB2 <- sum(diag(tables)) / sum(tables)
tables
AccuracyNB2


#####decision tree 1
DT <- rpart(result ~ ., data = trainset, method="class")
summary(DT)

#plot
plotcp(DT)

#importance
DT$variable.importance
fancyRpartPlot(DT)

#prediction
DT_Prediction<- predict(DT, testset, type="class")
table2 <- (table(DT_Prediction, answers)) 
AccuracyDT <- sum(diag(table2)) / sum(table2)
table2
AccuracyDT

#####decision tree 2
DT2 <- rpart(result ~ mr_seed_num + opp_mr_seed_num, data = trainset, method="class")
summary(DT2)

#plot
plotcp(DT2)

#importance
DT2$variable.importance
fancyRpartPlot(DT2)

#prediction
DT_Prediction2<- predict(DT2, testset, type="class")
table3 <- (table(DT_Prediction2, answers)) 
AccuracyDT2 <- sum(diag(table3)) / sum(table3)
table3
AccuracyDT2

#prediction vs aspects
PredVRank <-data.frame(testset$avg_rank,testset$mr_seed_num ,testset$opp_avg_rank,DT_Prediction2, answers)
PredVRank<- PredVRank[order(testset$mr_seed_num),]
PredVRank

#####decision tree 3
DT3 <- rpart(result ~ mr_seed_num, data = trainset, method="class")
summary(DT3)

#plot
plotcp(DT3)

#importance
DT3$variable.importance
fancyRpartPlot(DT3)

#prediction
DT_Prediction3<- predict(DT3, testset, type="class")
table4 <- (table(DT_Prediction3, answers)) 
AccuracyDT3 <- sum(diag(table4)) / sum(table4)
table4
AccuracyDT3

testset$SeedGuess = ifelse(testset$mr_seed_num > testset$opp_mr_seed_num,0,1)
tableNew <-table(answers,testset$SeedGuess)
AccuracySeed <- sum(diag(tableNew)) / sum(tableNew)
tableNew
AccuracySeed
data.frame(answers, testset$SeedGuess)
