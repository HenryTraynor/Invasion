#this script serves as a function to simulate the entire dataset needed for stats calculation
#CAN ONLY TAKE 3 TTB (i.e. length(ttb.times) must equal 3)!!!!

grandSim <- function(ttb.times, simulations) {
  for(i in 1:length(ttb.times)){
    sim_list = replicate(n=simulations,
                         expr=alphaSim(att.param,time.param,ratio.max=2, ttb=ttb.times[[i]]),
                         simplify=F)
    assign(paste0("sim.list.",i), sim_list)
  }
  
  #vector created to set names of columns in sim combinations shown below
  vec.colnames = character(simulations+1)
  vec.colnames[[1]] = "time"
  for(i in 1:simulations) {
    vec.colnames[[i+1]]=paste0("invader",i)
  }
  
  #ttb 1 sim combination
  df.invader1 = as.data.frame(sim.list.1[[1]]$time)
  for(i in 1:simulations) {
    df.invader1 = bind_cols(df.invader1, as.data.frame(sim.list.1[[i]]$invader))
  }
  #rename
  colnames(df.invader1) = vec.colnames
  
  #ttb 2 sim combination
  df.invader2 = as.data.frame(sim.list.2[[1]]$time)
  for(i in 1:simulations) {
    df.invader2 = bind_cols(df.invader2, as.data.frame(sim.list.2[[i]]$invader))
  }
  colnames(df.invader2) = vec.colnames
  
  #ttb 3 sim combination
  df.invader3 = as.data.frame(sim.list.3[[1]]$time)
  for(i in 1:simulations) {
    df.invader3 = bind_cols(df.invader3, as.data.frame(sim.list.3[[i]]$invader))
  }
  colnames(df.invader3) = vec.colnames
  
  #combination of all sims for reference
  sim_list = list(df.invader1, df.invader2, df.invader3)
  
  return(sim_list)
}
