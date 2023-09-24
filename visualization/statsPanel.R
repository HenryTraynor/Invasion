library(ggplot2)
library(reshape2)

stats.plots <- function(ttb.times, simulations, stats) {
  #creates dataset
  sim_list <- grandSim(ttb.times, simulations)
  
  #initialize empty list
  list.stat <- vector(mode='list', length(stats))
  #runs stat calculation on each created data frame
  for(i in 1:length(stats)) {
    for(j in 1:length(ttb.times)) {
      list.stat[[i]][[j]] = intervalAnalysis(sim_list[[j]], 
                                             time.param, 
                                             fun.call=stats[[i]],
                                             ttb=ttb.times[[j]])
    }
  }
  
  #collapses each stat for each ttb
  for(i in 1:length(list.stat)) {
    for(j in 1:length(ttb.times)) {
      list.stat[[i]][[j]] = melt(list.stat[[i]][[j]], id = 'time')
    }
  }
  
  #initialize emptly list for plots
  list.ggplots <- vector(mode='list', length(stats))
  #creates plots with 99% confidence intervals and titles/labels
  for(i in 1:length(list.stat)) {
    for(j in 1:length(ttb.times)) {
      list.ggplots[[i]][[j]] <- ggplot(list.stat[[i]][[j]],aes(time, value)) +
        stat_summary(geom = "line", fun = mean) +
        stat_summary(geom = "ribbon", fun.data = mean_cl_normal, alpha = 0.1) +
        ggtitle(paste0('Invader ',stats[[i]])) +
        geom_vline(xintercept=ttb.times[[j]], linetype='dashed', color='black') +
        xlab('time (years)') + ylab('number of individuals')
    }
  }
  
  return(list.ggplots)
}
