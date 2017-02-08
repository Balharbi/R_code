#Read data
dat <- read.table('C:/Users/adam/Desktop/PGC-PTSD/phenotype_harmonization/shareefa_check/Copy of C7Y6N1S2_6_2_15_COVs_PCAs_withSA_SD_harm_Jan2016.csv', sep=";", header=T,na.strings=c("NA","#N/A","-9"))

#Load MASS library for polr
library(MASS)

###Sample code for obtaining Nagelkerke R-squared
nagelkerke <- function(lik_intercept,lik_full, n)
{
     R2 <- (1 - exp((lik_full- lik_intercept)/n))/(1 - exp(-lik_intercept/n))
    RVAL <- list(N = n, R2 = R2)
    return(R2)
}

#Pseudo R-squared is calculated as a difference between likelihoods of the model with the covariate and the model without it

#For an observation to be used in regression, all of it's values on the predictors must be non-missing
#Regression models are fit to all observations with non-missing observations
#I used the subset code to make sure that the same set of subjects is fit in the null model (no trauma covariate)
#and the full model. Otherwise they would have different sample sizes, making r-squared calculations invalid.

#Sample code for predictions of PTSD case/control status
m1 <- glm(formula = as.factor(Phenotype) ~ InterpersonalTraumaCount , family = "binomial", data = subset(dat, Study == "dnhs" & !is.na(InterpersonalTraumaCount)))
m1_null <- glm(formula = as.factor(Phenotype) ~ 1, family = "binomial", data = subset(dat, Study == "dnhs" & !is.na(InterpersonalTraumaCount)))

nagelkerke(m1_null$deviance,m1$deviance,nobs(m1))
     
#Sample code for prediction of PTSD symptoms. Notice how I flipped PTSD and Trauma, to make this easier to calculate  
m2 <- polr(as.factor(InterpersonalTraumaCount) ~ PTSDCurrentContinuous,data= subset(dat, Study == "dnhs" & !is.na(PTSDCurrentContinuous)))
m2_null <- polr(as.factor(InterpersonalTraumaCount) ~ 1,data= subset(dat, Study == "dnhs" & !is.na(PTSDCurrentContinuous)))
         
nagelkerke(m2_null$deviance,m2$deviance,nobs(m1))
  
  
