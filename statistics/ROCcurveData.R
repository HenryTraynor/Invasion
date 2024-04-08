library(DescTools)

ROCcurveData <- function(df.input, numThresholds, inequality, statistic) {
  min = min(df.input[2])
  max = max(df.input[2])
  #max = df.input$stat[which.max(df.input$stat)]
  thresholds = seq(from = min-0.01,
                   to = max+(max*.01), 
                   length.out=numThresholds)
  
  df.rates = data.frame(threshold=thresholds,
                        TPR=vector("numeric", length=length(thresholds)),
                        FPR=vector("numeric", length=length(thresholds)),
                        statistic=statistic,
                        realizationType=vector("character", length=length(thresholds)),
                        windowSize=vector("numeric", length=length(thresholds)))
  # iterate through all thresholds
  for(i in 1:length(thresholds)) {
    # now finding TPR and FPR for a single threshold
    truePos=0
    falsePos=0
    pos=0
    neg=0
    # iterate through each realization from halfAndHalf input
    for(j in 1:length(df.input[,1])) {
      if (df.input[,1][j]) {
        pos=pos+1
        if(do.call(inequality, list(df.input[[2]][j],thresholds[i]))) {
          truePos=truePos+1
        }
      }
      else {
        neg=neg+1
        if(do.call(inequality, list(df.input[[2]][j],thresholds[i]))) {
          falsePos=falsePos+1
        }
      }
    }
    df.rates$TPR[i] = truePos/pos
    df.rates$FPR[i] = falsePos/neg
  }
  return(df.rates)
}
