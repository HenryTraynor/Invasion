probModel <- function(initialN, attParms, timeParms) {
  tau <- timeParms[1]
  time_max <- timeParms[2]
  time <- 0
  #indexing
  step <- 1
  #for df initialization
  numStep <- as.integer(time_max/tau)
  
  #creates df with time and population sizes (0,0)
  df.pop <- data.frame(time=seq(0,time_max, by=tau),
                       endemic=vector("integer", numStep+1),
                       invader=vector("integer", numStep+1))
  
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
    #immigrations (individuals per unit time)
    immigration <- rpois(2,tau*c(attParms[7:8]))
    
    #delta(pops)
    change <- birth-intra.death-inter.death+immigration
    
    #check for double counting; ensures less/eq to events than population
    
    #updating population data in df
    df.pop[step,2:3] <- pops[1:2] + change[1:2]
    
    time=time+tau
  }
  return(df.pop)
}

