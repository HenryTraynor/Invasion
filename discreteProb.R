# time scale: ?
library(ggplot2)

tau <- 1
time <- 0
time_max <- 1000

# dN/dt <- B_iN_i - (B_i/K_i)N_i^2 - (B)(a_ij)/K)(N_i)(N_j) + delta

# (c(species i), c(species j))
popSize <- matrix(c(time, initialN[1], initialN[2]), nrow = 1, ncol = 3)

# rpois(1, tau * b1 * popSize[nrow(popSize),1])

while(time < time_max) {
  births1 = rpois(1, tau*b1*popSize[nrow(popSize),2])
  births2 = rpois(1, tau*b2*popSize[nrow(popSize),3])
  #print(births1)
  
  intraDeaths1 = rpois(1, tau*b1/k1*popSize[nrow(popSize),2]^2)
  intraDeaths2 = rpois(1, tau*b2/k2*popSize[nrow(popSize),3]^2)
  #print(intraDeaths2)
  
  interDeaths1 = rpois(1, tau*b1*a12/k1*popSize[nrow(popSize),2]*popSize[nrow(popSize),3])
  interDeaths2 = rpois(1, tau*b2*a21/k2*popSize[nrow(popSize),2]*popSize[nrow(popSize),3])
  #print(interDeaths1)
  
  change1 = births1 - intraDeaths1 - interDeaths1
  change2 = births2 - intraDeaths2 - interDeaths2
  
  if(change1 > popSize[nrow(popSize),2] | change2 > popSize[nrow(popSize),3]) {break}
  
  newState = c(time+tau, popSize[nrow(popSize),2]+change1, popSize[nrow(popSize),3]+change2)
  
  popSize = rbind(popSize, newState)
  time = time+tau
}



time = popSize[,1]
pop1 = popSize[,2]
pop2 = popSize[,3]

df <- data.frame(time, pop1, pop2)

colors <- c('Endemic' = 'red', 'Invader' = 'blue')

ggplot(data= df, aes_(x=time, y=pop2, color='Invader')) +
  geom_line() +
  geom_line(data=df, aes_(x=time, y=pop1, color='Endemic')) +
  ggtitle('Endemic and Invader Species Abundance') +
  xlab('time (unit time)') + ylab('abundance')

