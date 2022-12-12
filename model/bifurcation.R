bifurcationModelSim <- function(att.param, time.param, do.prob = FALSE, comp.ratio) {
  #unpacking of parameters
  #pop states
  n1 <- att.param$n1 
  n2 <- att.param$n2
  #birth rates
  b1 <- att.param$b1
  b2 <- att.param$b2
  #carrying capacities
  k1 <- att.param$k1
  k2 <- att.param$k2
  #interspecific
  a12 <- 1
  a21 <- 1/comp.ratio
  #intraspecific
  a11 <- att.param$a11
  a22 <- att.param$a22
  #immigration
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
  
  while(time<time.max) {
    step <- step+1
    #populations at current timestep as vector
    pops <- as.numeric(df.pop[step-1,2:3])
    
    #events are defined for either boolean input 
    birth <- tau*c(b1,b2)*pops
    intra.death <- tau*c(b1,b2)/c(k1,k2)*pops^2*c(a11,a22)
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
  return(c(df.pop[nrow(df.pop),2], df.pop[nrow(df.pop),3]))
}

numRealizations <- 30
count <- 0

ratio.max <- 2

ratio.set <- seq(0,ratio.max,by=ratio.max/numRealizations)

df.bifurcation <- data.frame(
  ratio.index=seq(0,ratio.max, by=ratio.max/numRealizations),
  endemic=vector("integer", numRealizations+1),
  invader=vector("integer", numRealizations+1)
)

while(count < numRealizations+1) {
  count <- count+1
  ratio <- ratio.set[count]
  df.bifurcation[count,2:3] <- bifurcationModelSim(att.param, time.param, do.prob=FALSE, comp.ratio=ratio)
}

ggp1 <- ggplot(data=df.bifurcation, aes_(x=df.bifurcation[,1], y=df.bifurcation[,3], color='Invader')) +
  geom_line() +
  geom_line(data=df.bifurcation, aes_(x=df.bifurcation[,1], y=df.bifurcation[,2], color='Endemic')) +
  ggtitle('Equilibrium Populations vs. a12/a21') +
  xlab('interspecific ratio') + ylab('final count')

grid.arrange(ggp1, ncol=1)







