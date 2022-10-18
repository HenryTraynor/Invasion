probModel <- function(initial.N, att.param, time.param) {
  tau <- time.param[1]
  time.max <- time.param[2]
  time.invade <- time.param[3]
  time <- 0
  #indexing
  step <- 1
  #for df initialization
  num.step <- as.integer(time.max/tau)
  
  #creates df with time and population sizes (0,0)
  df.pop <- data.frame(time=seq(0,time.max, by=tau),
                       endemic=vector("integer", num.step+1),
                       invader=vector("integer", num.step+1))
  
  #define initial state
  df.pop[1, 2:3] <- initial.N
  
  while(time<time.max) {
    step <- step+1
    #populations at current timestep as vector
    pops <- as.numeric(df.pop[step-1,2:3])
    
    #births
    rate.birth <- tau*c(att.param[1:2])*pops[1:2]
    birth = rpois(2, rate.birth)
    #intra-species comp deaths
    rate.intra <- tau*c(att.param[1:2])/c(att.param[3:4])*pops[1:2]^2
    intra.death <- rpois(2, rate.intra)
    #inter-species comp deaths
    rate.inter <- tau*c(att.param[1:2])*c(att.param[5:6])/c(att.param[3:4])*pops[1]*pops[2]
    inter.death <- rpois(2, rate.inter)
    #immigrations (individuals per unit time)
    if (time >= time.invade) {
      immigration <- rpois(2,tau*c(att.param[7:8]))
      change <- birth-intra.death-inter.death+immigration
    }
    else {
      change <- birth-intra.death-inter.death
    }
    
    #check for double counting; ensures less/eq to events than population
    
    #updating population data in df
    df.pop[step,2:3] <- pops[1:2] + change[1:2]
    
    time=time+tau
  }
  return(df.pop)
}