library(zoo)

#returns df of right-handed standard deviation values over a given window for endemic and invasive species indexed with time
intervalStat <- function(df.sample, time.param, fun.call) {
  #unpacking
  time.window <- time.param$time.window
  window.step <- time.param$window.step
  time.max <- time.param$time.max
  tau <- time.param$tau
  
  #calculation of standard deviation values
  stat <- rollapply(df.sample[,2:3],
                    FUN=fun.call,
                    width=time.window,
                    by = window.step,
                    by.column = TRUE,
                    align = "right")
  
  #combining sd values with time indices
  stat <- data.frame(time=seq(from=time.window*tau, to=time.max, length.out=nrow(stat)), stat)
  
  return(stat)
}



