setwd("~/Desktop/5243 ADS/Spr2017-proj5-grp1-master/data/baseline")
team<-read.csv("team.csv")[1:30,]
short<-read.csv("short.csv",header = F)
playoff16<-c("BOS","CHI","WAS","ATL","TOR","MIL","CLE","IND","GSW","POR","LAC","UTA","HOU","OKC","SAS","MEM")
short<-short[order(short$V1),]
colnames(team)[2]<-"Team"
team<-team[order(team$Team),]
team$short<-short$V2
team$Team<-team$short
tn<- team$Team %in% playoff16
newdata<- team[tn,]
n<-nrow(team)
d<-ncol(team)
newdata<-as.data.frame(cbind(newdata$FG.,newdata$X3P.,newdata$TRB,
                             newdata$AST,newdata$STL,newdata$BLK))
average<-apply(newdata,2,mean)

radardata<-matrix(NA,ncol = 6,nrow=16)
for (i in 1:16){
  for (j in 1:6){
    radardata[i,j]<-newdata[i,j]/average[j]
  }
}
radardata<-as.data.frame(radardata)
max(radardata)
min(radardata)

library(radarchart)
labs<-c("FG%","X3P%","TRB","AST","STL","BLK")
radarfunction<-function(a,b){
  scores<-list(
    "team1"=as.numeric(radardata[a,1:6]),
    "team2"=as.numeric(radardata[b,1:6]))
  
  chartJSRadar(scores = scores, labs = labs, scaleStartValue=min(radardata[a,],radardata[b,])+0.01,maxScale = max(radardata[a,],radardata[b,])+0.01)
}

