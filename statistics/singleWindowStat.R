singleWindowStat <- function(df.data, singleWindow.time.param, func) {
  #unpacking
  time.window = singleWindow.time.param$time.window
  time.index = singleWindow.time.param$time.index
  
  #set right-hand end of stat window in units tau
  time.windowEnd = time.window+time.index
  
  #initialize df for output
  output <- data.frame(do.win=df.data$do.win,
                       stat=vector(mode="numeric", length=length(df.data$do.win)))
  
  #calculate stat across each input realization
  for(i in 1:length(df.data$data)) {
    datum = df.data$data[i][[1]]
    output$stat[i] = do.call(func, list(datum$invader[time.index:time.windowEnd]))
  }
  #output$stat = replace(output$stat, is.na(output$stat), 0)
  return(output)
}

