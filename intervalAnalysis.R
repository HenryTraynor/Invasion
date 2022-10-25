intervalAnalysis <- function(df.sample, time.interval) {
  time.interval <- time.interval
  df.sample <- df.sample
  
  step <- 1 #index of df.sd
  time.step <- time.interval[2] 
  time <- 0
  time.window <- time.interval[1]
  time.max <- time.param[2]
  
  window <- 0 #index for sd calculation in sample df
  window.step <- time.interval[2]/time.param[1]
  
  df.sample <- df.popD
  
  num.interval <- as.integer((time.max-time.window)/time.step)
  
  df.sd <- data.frame(interval = seq(time.step,time.max-time.window,by=time.step-1),
                      endemic = vector("double", num.interval-1),
                      invader = vector("double", num.interval-1))
  
  while (step<length(df.sample$endemic)) {
    window <- window+window.step
    
    start.window <- window-window.step
    df.sd$endemic[step] <- sd(df.sample$endemic[start.window:window])
    df.sd$invader[step] <- sd(df.sample$endemic[start.window:window])
    
    step <- step+1
    time <- time+time.step
  }
  
  return(df.sd)
}