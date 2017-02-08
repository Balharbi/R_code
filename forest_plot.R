dat <- read.table('C:/Users/adam/Desktop/PGC-PTSD/phenotype_harmonization/shareefa_check/Copy of C7Y6N1S2_6_2_15_COVs_PCAs_withSA_SD_harm_Jan2016.csv', sep=";", header=T,na.strings=c("NA","#N/A","-9"))

#Load metafor library for forest plots
library(metafor)

### Sample code for forest plots


##PTSD case/control mdoels
m1 <- glm(formula = as.factor(Phenotype) ~ InterpersonalTraumaCount , family = "binomial", data = subset(dat, Study == "dnhs" & !is.na(InterpersonalTraumaCount)))
m2 <- glm(formula = as.factor(Phenotype) ~ InterpersonalTraumaCount , family = "binomial", data = subset(dat, Study == "MRS" & !is.na(InterpersonalTraumaCount)))
m3 <- glm(formula = as.factor(Phenotype) ~ InterpersonalTraumaCount , family = "binomial", data = subset(dat, Study == "NHS" & !is.na(InterpersonalTraumaCount)))

#Save the model beta values and variances (SE^2) to a vector

#See how the first code gives us all coefficients
 summary(m3)$coefficients
#And this gives specifically the beta
 summary(m3)$coefficients[2,1]
#And this gives specifically the SE
 summary(m3)$coefficients[2,2]

#This is sloppy as hell but it works
data_for_meta <- rbind(summary(m1)$coefficients[2,1:2],
summary(m2)$coefficients[2,1:2],
summary(m3)$coefficients[2,1:2])

#Do a fixed effects meta analysis. Notice that I supply column 1 of the data (betas) and column 2 (ses), and that I square the SEs to get variances
meta_analysis <- rma(yi=data_for_meta[,1],vi=data_for_meta[,2],method="FE")

forest.rma(meta_analysis,xlab="Beta for Interpersonal Trauma Count", slab=c("DNHS","MRS","NHS"))
