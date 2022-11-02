library(zoo)

intervalStanDev <- function(df.sample, time.param) {
  #unpacking
  tau <- time.param$tau
  time.window <- time.param$time.window
  window.step <- time.param$window.step
  time.max <- time.param$time.max
  
  #calculation of standard devation values
  sd <- rollapply(df.sample[,2:3],
                    FUN="sd",
                    width=time.window/tau,
                    by = window.step/tau,
                    by.column = TRUE,
                    align = "right")
  
  #combining sd values with time indices
  sd <- data.frame(time=seq(time.window, time.max, by = window.step), sd)
  
  return(sd)
}

