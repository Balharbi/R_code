###Use simulation to calculate power for a 1 sample t-test

#Set the hypothetical mean
 data_mean=.25
#Set the hypothetical SD
 data_sd=1
#Set the number of samples
 n_samples=10
#Set alpha level
 alpha_level=0.05

#Set number of repetitions 
 rep=1000

#Make a vector of NA values, the length of the number of repetitions. The p-values of the simulations will be stored in this vector.
pv <- rep(NA,rep)


#Simulate data from a normal distribution over N repetitions. Test if the mean of this data is equal to 0, return p-value for the test
for (i in 1:rep)
{
  rsample <- rnorm(n_samples,data_mean,data_sd) #Draw 'n_samples' amount of random values from a normal distribution, with mean 'data_mean' and sd 'data_sd'
  pv[i] <- t.test(rsample)$p.value #Run a t-test on the sample and return the p-value. Assign this p-value to the i-th entry in the list of p-values.
}

#Calculate the proportion of times the p-value is below the alpha level p-value. This is the power!
 table(pv < alpha_level)[2] / length(pv)
 
#Compare this number to a theoretical power calculation
 power.t.test(n=n_samples,delta=data_mean,sd=data_sd,sig.level=alpha_level,type="one.sample")
 
 
