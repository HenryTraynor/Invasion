library(ggplot2)
library(gridExtra)
library(dplyr)
library(tidyr)

## required files
source('modelParam.R')
source('modelSim.R')
source('../intervalAnalysis.R')



ttb.times = c(75, 100, 125)
simulations=3
stats = c('sd', 'var', 'kurtosis', 'skewness')

for(i in 1:length(ttb.times)){
  sim_list = replicate(n=simulations,
                       expr=alphaSim(att.param,time.param,ratio.max=2, ttb=ttb.times[[i]]),
                       simplify=F)
  assign(paste0("sim.list.",i), sim_list)
}

stats = c('sd', 'var', 'kurtosis', 'skewness')

df.invader1 = bind_cols(as.data.frame(sim.list.1[[1]]$time),
                         as.data.frame(sim.list.1[[1]]$invader),
                         as.data.frame(sim.list.1[[2]]$invader),
                         as.data.frame(sim.list.1[[3]]$invader))
colnames(df.invader1) = c('time', 'invader1', 'invader2', 'invader3')

df.invader2 = bind_cols(as.data.frame(sim.list.2[[1]]$time),
                        as.data.frame(sim.list.2[[1]]$invader),
                        as.data.frame(sim.list.2[[2]]$invader),
                        as.data.frame(sim.list.2[[3]]$invader))
colnames(df.invader2) = c('time', 'invader1', 'invader2', 'invader3')

df.invader3 = bind_cols(as.data.frame(sim.list.3[[1]]$time),
                        as.data.frame(sim.list.3[[1]]$invader),
                        as.data.frame(sim.list.3[[2]]$invader),
                        as.data.frame(sim.list.3[[3]]$invader))
colnames(df.invader3) = c('time', 'invader1', 'invader2', 'invader3')


dftest = intervalAnalysis(df.invader1, time.param, 'sd', 75)