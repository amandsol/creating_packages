setwd("C:/Users/Amanda Santana/Google Drive/Amanda/Mestrado PPGEMA/Disciplinas/Estatística")
dir()
#TESTES ESTATÍSTICOS

dados<-read.table("data.csv",header = TRUE,sep = ";",dec = ".", blank.lines.skip = T)
dados
head(dados)

#Soma
sum(dados$Taxa)
sum(dados$chuvoso)

#Média
mean(dados$Taxa)
mean(dados$chuvoso)

#Mediana
median(dados$Taxa)
median(dados$chuvoso)

#Moda
table(dados$Taxa)

#Ordenar dados
ord<- ordered(dados$Taxa)

#Discrepâncias (dados - média)
disc<-dados$Taxa-mean(dados$Taxa)

#Discrepância ao quadrado
disc2<-disc^2
sum(disc2)
sum(disc2)/99
sqrt(0.020)
sqrt(0.020)/10

#Desvio Padrão
sd(dados$seco)
sd(dados$chuvoso)

#Erro Padrão
sd(dados$seco)/sqrt(50)
sd(dados$chuvoso)/sqrt(50)

#Máximo e Mínimo
max(dados$chuvoso)
min(dados$chuvoso)

#Teste de Normalidade
dados1<-read.table("data_periodo.csv",header = TRUE,sep = ";",dec = ".", blank.lines.skip = T)
dados1
head(dados1)

shapiro.test(dados1$seco)
shapiro.test(dados1$chuvoso)
hist(dados$seco)
hist(dados$chuvoso)

#Teste da homogeneidade das variâncias
var.test(dados1$seco,dados1$chuvoso)

###Uma variável com dois fatores

#Distribuição normal e variâncias homogêneas
#Distribuição não normal e variâncias homogêneas com n amostral>20
#Teste T
?t.test
t.test(dados1$seco,dados1$chuvoso, data=dados1, var.equal = TRUE, alternative = "two.sided", paired = TRUE)

#Distribuição normal e variâncias heterogêneas
#Distribuição não normal e variâncias heterogêneas
#Distribuição não normal e variâncias homogêneas com n amostral<20
#Teste U
?wilcox.test
wilcox.test(dados1$seco,dados1$chuvoso, exact=F)

###Uma variável com mais de dois fatores


A<-c(78,88,87,88,83,82,81,80,80,89)
B<-c(78,78,83,81,78,81,81,82,76,76)
C<-c(79,73,79,75,77,78,80,78,83,84)
D<-c(77,69,75,70,74,83,80,75,76,75)

massa<-data.frame(A,B,C,D)

dados2<-read.table("data2.csv",header = TRUE,sep = ";",dec = ".")
dados2
#head(dados2)

#Teste de normaalidade
shapiro.test(dados2$FEV)
shapiro.test(dados2$ABR)
shapiro.test(dados2$MAI)
shapiro.test(dados2$JUN)
shapiro.test(dados2$JUL)
shapiro.test(dados2$AGO)
shapiro.test(dados2$SET)
shapiro.test(dados2$OUT)
shapiro.test(dados2$NOV)
shapiro.test(dados2$DEZ)

#Teste da homogeneidade das variâncias
bartlett.test(dados2)


#Distribuição normal e variâncias homogêneas
#Distribuição não normal e variâncias homogêneas com 3 a 9 fatores com n amostral>15
#Distribuição não normal e variâncias homogêneas com 10 a 12 fatores com n amostral>20
#ANOVA

massa2<-data.frame(Localidade=gl(4,10),Massa=c(massa$A,massa$B,massa$C,massa$D))

massa2$Localidade<-factor(massa2$Localidade)
is.factor(massa2$Localidade)

massa.anova<-aov(massa2$Massa~massa2$Localidade)
summary(massa.anova)

#Quais diferem?
TukeyHSD(massa.anova, ordered = T)


#Distribuição normal e variâncias heterogêneas
#Distribuição não normal e variâncias heterogêneas
#Distribuição não normal e variâncias homogêneas com 3 a 9 fatores com n amostral>15
#Distribuição não normal e variâncias homogêneas com 10 a 12 fatores com n amostral>20

#ANOVA DE KRUSKAL WALLIS
?kruskal.test

#Organizar a tabela em duas colunas, uma numérica e outra em fatores
dados3<-read.table("data3.csv",header = TRUE,sep = ";",dec = ".")
dados3
head(dados3)

#Quais são os níveis?
levels(dados3$mês) #mostra em ordem alfabética

#Ordenar os níveis
dados3$mês <- ordered(dados3$mês,
                      levels = c("FEV", "ABR", "MAI", "JUN", "JUL", "AGO", "SET", "OUT", "NOV", "DEZ"))

kruskal.test(taxa~mês, data = dados3)
?kruskal.test
#Quais fatores diferem entre si?
#Teste de Nemenyi

install.packages("PMCMRplus")
library(PMCMR)
library(PMCMRplus)

??posthoc.kruskal.nemenyi.test
posthoc.kruskal.nemenyi.test(taxa~mês, data = dados3, dist = c("Tukey", "Chisquare"))

#Explorando gráficos
riqueza <- c(15,18,22,24,25,30,31,34,37,39,41,45)
area <- c(2,4.5,6,10,30,34,50,56,60,77.5,80,85)
area.cate <- rep(c("pequeno", "grande"), each=6)

plot(riqueza~area)
plot(area,riqueza) # o mesmo que o anterior
boxplot(riqueza~area.cate)
barplot(riqueza)

par(cex=1.5)
plot(riqueza~area)
