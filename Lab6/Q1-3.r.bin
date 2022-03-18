library(bnclassify)

library(caTools)

library(graph)

setRepositories()

install.packages("graph") 

library(bnlearn)

course.grades<-read.table("C:\\Users\\Rakshil Modi\\OneDrive\\Documents\\Sem6\\AI\\Lab 5\\2020_bn_nb_data.txt", head = TRUE)
course.grades<- lapply(course.grades,as.factor)
course.grades<- data.frame(course.grades)

# with different scores

course.grades.net <- hc(course.grades[,-9],score = "aic")
course.grades.net1 <- hc(course.grades[,-9],score = "bdla")
course.grades.net2 <- hc(course.grades[,-9],score = "bic")
course.grades.net3 <- hc(course.grades[,-9],score = "k2")

course.grades.net
course.grades.net1
course.grades.net2
course.grades.net3

plot(course.grades.net)

plot(course.grades.net1)

plot(course.grades.net2)

plot(course.grades.net3)

course.grades.net.fit<-bn.fit(course.grades.net,course.grades[,-9])
course.grades.net.fit1<-bn.fit(course.grades.net1,course.grades[,-9])
course.grades.net.fit2<-bn.fit(course.grades.net2,course.grades[,-9])
course.grades.net.fit3<-bn.fit(course.grades.net3,course.grades[,-9])

# Printing CPTs
print("Cpt of each node in first network")
course.grades.net.fit

print("Cpt of each node in Second network")
course.grades.net.fit1

print("Cpt of each node in Third network")
course.grades.net.fit2

print("Cpt of each node in Fourth network")
course.grades.net.fit3
course.grades.plots<-lapply(course.grades.net.fit3, bn.fit.barchart)

course.grades.plots<-lapply(course.grades.net.fit3, bn.fit.barchart)

value<- c('AA','AB','BB','BC','CC','CD','DD','F')
x <- 0
for(i in 1:length(value))
{
    x <-append(x,cpquery(course.grades.net.fit3,event = ((PH100 == value[i])), evidence = ((EC100 =='DD' ) & IT101 == 'CC' & MA101 == 'CD')))
}
value[match(max(x),x)]


library(caret)

install.package("e1071")






