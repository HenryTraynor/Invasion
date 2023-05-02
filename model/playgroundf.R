novel <- grandSim(ttb.times, simulations = 5)

sample.list <- list()
sample.list[[1]] = cbind(novel[[1]]$time, novel[[1]]$invader1)
sample.list[[2]] = cbind(novel[[1]]$time, novel[[1]]$invader2)
sample.list[[3]] = cbind(novel[[1]]$time, novel[[1]]$invader3)
sample.list[[4]] = cbind(novel[[1]]$time, novel[[1]]$invader4)
sample.list[[5]] = cbind(novel[[1]]$time, novel[[1]]$invader5)

p <- ggplot()

colors <- c('1','2','3', '4', '5')

for(i in 1:5) {
  df.data <- as.data.frame(sample.list[[i]])
  p <- p + geom_line(data=df.data, aes_(x=df.data[,1], y=df.data[,2], color=colors[i]))
}
p <- p + ggtitle("Sample 5 Realizations") + xlab('Time (years)') + ylab('Abundance') + geom_vline(xintercept=ttb.times[1], linetype='dashed', color='black')
p

#-------------------------------------------

stats.plots.noint <- function(ttb.times, simulations, stats) {
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
  return(list.stat)
}

novel.stat <- stats.plots(ttb.times, simulations=5, stats)
w <- novel.stat[[2]][[1]] + ggtitle("5 Sample Stan. Dev.") + xlab('Time (years)') + ylab('Abundance') + geom_vline(xintercept=ttb.times[1], linetype='dashed', color='black')
w
