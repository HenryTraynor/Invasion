#runs model simulation for deterministic or stochastic model; do.prob has default 'TRUE'
#?? different names for params and args
modelSim <- function(att.param, time.param, do.prob = TRUE) {
  #unpacking of parameters
  n1 <- att.param$n1 
  n2 <- att.param$n2
  b1 <- att.param$b1
  b2 <- att.param$b2
  k1 <- att.param$k1
  k2 <- att.param$k2
  a12 <- att.param$a12
  a21 <- att.param$a21
  del1 <- att.param$del1
  del2 <- att.param$del2
  ##  time params
  tau <- time.param$tau
  time.max <- time.param$time.max
  time.invade <- time.param$time.invade
  
  #indexing
  time <- 0
  step <- 1
  
  #for df initialization
  num.step <- as.integer(time.max/tau)
  #creates df with time and population sizes (0,0)
  #!! indent style K&R
  df.pop <- data.frame(
    time=seq(0,time.max, by=tau),
    endemic=vector("integer", num.step+1),
    invader=vector("integer", num.step+1)
  )
  
  #define initial state
  df.pop[1, 2:3] <- c(n1,n2)
  
  while(time<time.max) {
    step <- step+1
    #populations at current timestep as vector
    pops <- as.numeric(df.pop[step-1,2:3])
    
    #events are defined for either boolean input 
    birth <- tau*c(b1,b2)*pops[1:2]
    intra.death <- tau*c(b1,b2)/c(k1,k2)*pops[1:2]^2
    inter.death <- tau*c(b1,b2)*c(a12,a21)/c(k1,k2)*pops[1]*pops[2]
    
    #now redefined in the case of probabilistic model
    if(do.prob) {
      birth <- rpois(2,birth)
      intra.death <- rpois(2,intra.death)
      inter.death <- rpois(2,inter.death)
    }
    
    #check for invasion time
    if(time >= time.invade) {
      immigration <- tau*c(del1,del2)
      #check for 'do.prob'
      if(do.prob) {
        immigration <- rpois(2,immigration)
      }
    } else {
      immigration <- 0
    }
    
    #new entry in df
    change <- birth-intra.death-inter.death+immigration
    df.pop[step,2:3] <- pops[1:2] + change[1:2]
    
    #step
    time=time+tau
  }
  return(df.pop)
}
