library(zoo)

#returns df of right-handed standard deviation values over a given window for endemic and invasive species indexed with time
intervalStanDev <- function(df.sample, time.param, fun.call) {
  #unpacking
  time.window <- time.param$time.window
  window.step <- time.param$window.step
  time.max <- time.param$time.max
  
  #calculation of standard deviation values
  sd <- rollapply(df.sample[,2:3],
                    FUN=fun.call,
                    width=time.window,
                    by = window.step,
                    by.column = TRUE,
                    align = "right")
  
  #combining sd values with time indices
  sd <- data.frame(time=seq(from=time.window, to=time.max, length.out=nrow(sd)), sd)
  
  return(sd)
}



