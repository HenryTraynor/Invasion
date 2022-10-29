#b1, b2, k1, k2, a12, a21, del1, del2, tau, time.max, time.invade
modelSim <- function(att.param, time.param, do.determ = FALSE) {
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
  tau <- time.param$tau
  time.max <- time.param$time.max
  time.invade <- time.param$time.invade
  
  #indexing
  time <- 0
  step <- 1
  
  #for df initialization
  num.step <- as.integer(time.max/tau)
  #creates df with time and population sizes (0,0)
  df.pop <- data.frame(time=seq(0,time.max, by=tau),
                       endemic=vector("integer", num.step+1),
                       invader=vector("integer", num.step+1))
  
  #define initial state
  df.pop[1, 2:3] <- c(n1,n2)
  
  while(time<time.max) {
    step <- step+1
    #populations at current timestep as vector
    pops <- as.numeric(df.pop[step-1,2:3])

    if(do.determ) {
      birth <- tau*c(b1,b2)*pops[1:2]
      intra.death <- tau*c(b1,b2)/c(k1,k2)*pops[1:2]^2
      inter.death <- tau*c(b1,b2)*c(a12,a21)/c(k1,k2)*pops[1]*pops[2]
      immigration <- 0
      
      if(time >= time.invade) {
        immigration <- tau*c(del1,del2)
      } 
    } else {
      rate.birth <- tau*c(b1,b2)*pops[1:2]
      birth = rpois(2, rate.birth)
      #intra-species comp deaths
      #?? compare with intra.death above
      rate.intra <- tau*c(b1,b2)/c(k1,k2)*pops[1:2]^2
      intra.death <- rpois(2, rate.intra)
      #inter-species comp deaths
      #?? compare with inter.death above
      rate.inter <- tau*c(b1,b2)*c(a12,a21)/c(k1,k2)*pops[1]*pops[2]
      inter.death <- rpois(2, rate.inter)
      immigration <- 0
      
      if (time >= time.invade) {
        immigration <- rpois(2,tau*c(del1,del2))
      } 
    }
    change <- birth-intra.death-inter.death+immigration

    #?? It doesn't look like you need to index pops or change here 
    #?? Both are length-2 vectors, correct? 
    df.pop[step,2:3] <- pops[1:2] + change[1:2]
    
    time=time+tau
  }
  return(df.pop)
}
