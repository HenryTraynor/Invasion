library(zoo)

#returns df of right-handed standard deviation values over a given window for endemic and invasive species indexed with time
intervalAnalysis <- function(df.sample, time.param, fun.call, ttb) {
  #unpacking
  time.window <- time.param$time.window
  window.step <- time.param$window.step
  time.max <- ttb*2
  tau <- time.param$tau
  
  #calculation of standard deviation values
  stat <- rollapply(df.sample[,2:ncol(df.sample)],
                    FUN=fun.call,
                    width=time.window,
                    by = window.step,
                    by.column = TRUE,
                    align = "right")
  
  #combining sd values with time indices
  stat <- data.frame(time=seq(from=time.window*tau, to=time.max, length.out=nrow(stat)), stat)
  
  return(stat)
}



