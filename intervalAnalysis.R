library(zoo)

intervalAnalysis <- function(df.sample, time.param) {
  tau <- time.param$tau
  time.window <- time.param$time.window
  window.step <- time.param$window.step
  time.max <- time.param$time.max
  
  
  df.sd <- rollapply(df.sample[,2:3],
                    FUN="sd",
                    width=time.window/tau,
                    by = window.step/tau,
                    by.column = TRUE,
                    align = "right")
  
  df.sd <- data.frame(time=seq(0, time.max, by), df.sd)
  
  return(as.data.frame(df.sd))
}

