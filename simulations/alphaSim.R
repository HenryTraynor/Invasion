alphaSim <- function(att.param, time.param, do.prob = TRUE, ratio.max, ttb, do.win = TRUE) {
  #unpacking of parameters
  n1 <- att.param$n1 
  n2 <- att.param$n2
  b1 <- att.param$b1
  b2 <- att.param$b2
  k1 <- att.param$k1
  k2 <- att.param$k2
  a12 <- 1
  a21 <- 1
  a11 <- 1
  a22 <- 1
  del1 <- att.param$del1
  del2 <- att.param$del2
  #time parameters
  tau <- time.param$tau
  time.max <- ttb * 2
  time.invade <- time.param$time.invade
  
  #indexing
  time <- 0
  step <- 1
  
  #for df initialization
  num.step <- as.integer(time.max/tau)
  #creates df with time and population sizes (0,0,0)
  #!! indent style K&R
  df.pop <- data.frame(
    time=seq(0,time.max, by=tau),
    endemic=vector("integer", num.step+1),
    invader=vector("integer", num.step+1),
    ratio=vector("double", num.step+1)
  )
  
  #define initial state
  df.pop[1, 2:3] <- c(n1,n2)
  
  
  #a12 for each step
  if(!do.win) {
    ratio.set <- c(rep(ratio.max,num.step+1))
  }
  else {
    ratio.set <- seq(0,ratio.max,by=ratio.max/num.step)
    ratio.set[1] <- ratio.set[2]/2
  }
  
  while(time<ttb*2) {
    step <- step+1
    a21 <- a12/ratio.set[step]
    #populations at current timestep as vector
    pops <- as.numeric(df.pop[step-1,2:3])
    
    #events are defined for either boolean input 
    birth <- tau*c(b1,b2)*pops
    intra.death <- abs(tau*c(b1,b2)*c(a11,a22)/c(k1,k2)*pops^2)
    inter.death <- abs(tau*c(b1,b2)*c(a12,a21)/c(k1,k2)*pops[1]*pops[2])
    
    #now redefined in the case of probabilistic model
    if(do.prob) {
      birth <- rpois(2,birth)
      intra.death <- rpois(2,intra.death)
      # old NA value fix (doesn't work)
      #if(0.999*.Machine$integer.max > inter.death[1] || 0.999*.Machine$integer.max > inter.death[2]) {
        #inter.death <- round(rnorm(2,mean=inter.death,sd=sqrt(inter.death)))
      #}
      if(is.na(inter.death[1])) {
        inter.death[1] <- 0
      }
      if(is.na(inter.death[2])) {
        inter.death[2] <- 0
      }
      inter.death <- rpois(2,inter.death)
    }
    
    #check for invasion time
    if(time >= time.invade) {
      immigration <- tau*c(del1,del2)
      #check for 'do.prob'
      if(do.prob) {
        immigration <- rpois(2,immigration)
      }
    }
    else {
      immigration <- 0
    }
    
    #new entry in df
    change <- birth-intra.death-inter.death+immigration
    #--------------------------------------------------------ERROR LOCATION
    if (abs(change[1]) > pops[1] && change[1]<0) {
      change[1] <- 0
    } 
    if (abs(change[2]) > pops[2] && change[2]<0) {
      change[2] <- 0
    }
    #--------------------------------------------------------END
    df.pop[step,2:3] <- pops+change
    
    #step
    time=time+tau
    
    df.pop[step,4] <- a12/a21
  }
  #df.pop = df.pop[-c(2,4)]
  return(df.pop)
}
