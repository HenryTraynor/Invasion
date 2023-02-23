library(ggplot2)
library(gridExtra)

etaSim <- function(att.param, time.param, do.prob = TRUE, ratio.max) {
  
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
  #time params
  tau <- time.param$tau
  time.max <- time.param$ttb * 2
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
  ratio.set <- seq(0,ratio.max,by=ratio.max/num.step)
  ratio.set[1] <- ratio.set[2]/2
  
  while(time<time.max) {
    step <- step+1
    a21 <- a12/ratio.set[step]
    #populations at current timestep as vector
    pops <- as.numeric(df.pop[step-1,2:3])
    
    #events are defined for either boolean input 
    birth <- tau*c(b1,b2)*pops
    intra.death <- tau*c(b1,b2)*c(a11,a22)/c(k1,k2)*pops^2
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
    
    #if((time/tau)%%156==0) {
    #  immigration <- 20
    #}
    
    #new entry in df
    change <- birth-intra.death-inter.death+immigration
    if (abs(change[1]) > pops[1] && change[1]<0) {
      change[1] <- 0
    } 
    if (abs(change[2]) > pops[2] && change[2]<0) {
      change[2] <- 0
    }
    df.pop[step,2:3] <- pops+change
    
    #step
    time=time+tau
    
    df.pop[step,4] <- a12/a21
  }
  return(df.pop)
}

df.etaSim <- etaSim(att.param, time.param, ratio.max=2)

ggp1 <- ggplot(data=df.etaSim, aes_(x=df.etaSim[,1], y=df.etaSim[,2], color='Endemic - Probabilistic')) +
  geom_line() +
  geom_line(data=df.etaSim, aes_(x=df.etaSim[,1], y=df.etaSim[,3], color='Invader - Probabilistic')) +
  ggtitle('Endemic and Invader Species Abundance versus Time') +
  xlab('time (years)') + ylab('abundance') +
  theme(legend.position = "bottom") +
  geom_vline(xintercept=time.param$time.max/2, linetype='dashed', color='black')

df.sd <- intervalStanDev(df.etaSim, time.param, fun.call="sd")

ggp2 <- ggplot(data=df.sd, aes_(x=df.sd[,1], y=df.sd[,3], color='SD: invader')) +
  geom_line()  +
  ggtitle('Invader Interval Standard Deviations') +
  xlab('time (years)') + ylab('number of individuals') +
  theme(legend.position = "bottom") +
  coord_cartesian(xlim = c(0, time.param$time.max)) +
  geom_vline(xintercept=time.param$time.max/2, linetype='dashed', color='black')

df.var <- intervalStanDev(df.etaSim, time.param, fun.call="var")

ggp3 <- ggplot(data=df.var, aes_(x=df.var[,1], y=df.var[,3], color='var: invader')) +
  geom_line() +
  ggtitle('Invader Interval Variance') +
  xlab('time (years)') + ylab('number of individuals') +
  theme(legend.position = "bottom") +
  coord_cartesian(xlim = c(0, time.param$time.max)) +
  geom_vline(xintercept=time.param$time.max/2, linetype='dashed', color='black')

ggp4 <- ggplot(data=df.etaSim, aes_(x=df.etaSim[,1], y=df.etaSim[,4], color='Ratio: a12/a22')) +
  geom_line() +
  ggtitle('Interspecific Comp. Ratio versus Time') +
  xlab('time (years)') + ylab('a12/a22') +
  theme(legend.position = 'bottom') +
  geom_segment(x=0, y=1, xend=time.param$ttb, yend=1, linetype='dashed', color='black') +
  geom_segment(y=0, x=time.param$ttb, yend=1, xend=time.param$ttb, linetype='dashed', color='black')


grid.arrange(ggp1, ggp4, ncol=1)

