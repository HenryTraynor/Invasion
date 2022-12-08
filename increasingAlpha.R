alphaSim <- function(att.param, time.param, do.prob = TRUE, ratio.max) {
  
  #unpacking of parameters
  n1 <- att.param$n1 
  n2 <- att.param$n2
  b1 <- att.param$b1
  b2 <- att.param$b2
  k1 <- att.param$k1
  k2 <- att.param$k2
  a12 <- 0
  a21 <- att.param$a21
  del1 <- att.param$del1
  del2 <- att.param$del2
  #time params
  tau <- time.param$tau
  time.max <- time.param$time.max
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
    invader=vector("integer", num.step+1)
  )
  
  #define initial state
  df.pop[1, 2:3] <- c(n1,n2)
  
  #a12 for each step
  a12.set <- seq(0,ratio.max,by=ratio.max/num.step)
  
  while(time<time.max) {
    a12 <- a12.set[step]
    step <- step+1
    #populations at current timestep as vector
    pops <- as.numeric(df.pop[step-1,2:3])
    
    #events are defined for either boolean input 
    birth <- tau*c(b1,b2)*pops
    intra.death <- tau*c(b1,b2)/c(k1,k2)*pops^2
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
    }
    else {
      immigration <- 0
    }
    
    #new entry in df
    change <- birth-intra.death-inter.death+immigration
    df.pop[step,2:3] <- pops+change
    
    #step
    time=time+tau
  }
  return(df.pop)
}

df.alphaSim <- alphaSim(att.param, time.param, ratio.max=1.5)

ggp1 <- ggplot(data=df.alphaSim, aes_(x=df.alphaSim[,1], y=df.alphaSim[,3], color='Invader - Probabilistic')) +
  geom_line() +
  geom_line(data=df.alphaSim, aes_(x=df.alphaSim[,1], y=df.alphaSim[,2], color='Endemic - Probabilistic')) +
  ggtitle('Endemic and Invader Species Abundance versus Time') +
  xlab('time (years)') + ylab('abundance') +
  theme(legend.position = "bottom")

df.sd <- intervalStanDev(df.alphaSim, time.param, fun.call="sd")

ggp2 <- ggplot(data=df.sd, aes_(x=df.sd[,1], y=df.sd[,3], color='SD: invader')) +
  geom_line()  +
  ggtitle('Invader Interval Standard Deviations') +
  xlab('time (years)') + ylab('number of individuals') +
  theme(legend.position = "bottom")

df.var <- intervalStanDev(df.alphaSim, time.param, fun.call="var")

ggp3 <- ggplot(data=df.var, aes_(x=df.var[,1], y=df.var[,3], color='var: invader')) +
  geom_line() +
  ggtitle('Invader Interval Standard Deviations') +
  xlab('time (years)') + ylab('number of individuals') +
  theme(legend.position = "bottom")


grid.arrange(ggp1, ggp2, ggp3, ncol=1)
