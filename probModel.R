# time scale: year

## set RNG seed for reproducible results:
#set.seed(314159)

#initialN(endemic, invader)
#attParms(b1, b2, k1, k2, a12, a21)
#timeParms(tau, time_max)

#for testing
initialN <- c(100,2)
attParms <- c(0.7, 0.8, 100, 120, 1.2, 0.8)
timeParms <- c(1/52, 100)

probModel <- function(initialN, attParms, timeParms) {
  tau <- timeParms[1]
  time_max <- timeParms[2]
  time <- 0
  #indexing
  step <- 1
  #for df initialization
  numSteps <- as.integer(time_max/tau)
  
  #creates df with time and population sizes (0,0)
  df.pop <- data.frame(time=seq(0,time_max, by=tau),
                       endemic=vector("integer", numSteps+1),
                       invader=vector("integer", numSteps+1))
  
  #define initial state
  df.pop[1, 2:3] <- initialN
  
  
  while(time<time_max) {
    step <- step+1
    #populations at current timestep as vector
    pops <- as.numeric(df.pop[step-1,2:3])
    
    #births
    rate.birth <- tau*c(attParms[1:2])*pops[1:2]
    birth = rpois(2, rate.birth)
    #intra-species comp deaths
    rate.intra <- tau*c(attParms[1:2])/c(attParms[3:4])*pops[1:2]^2
    intra.death <- rpois(2, rate.intra)
    #inter-species comp deaths
    rate.inter <- tau*c(attParms[1:2])*c(attParms[5:6])/c(attParms[3:4])*pops[1]*pops[2]
    inter.death <- rpois(2, rate.inter)
    #delta(pops)
    change <- birth-intra.death-inter.death
    
    #check for double counting
    
    #updating population data in df
    df.pop[step,2:3] <- pops[1:2] + change[1:2]
    
    time=time+tau
  }
}

probModel(initialN=initialN, attParms=attParms, timeParms=timeParms)

print(df.pop)

