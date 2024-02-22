library(DescTools)

ROCcurveData <- function(df.input, numThresholds, inequality) {
  min = df.input$stat[which.min(df.input$stat)]
  max = df.input$stat[which.max(df.input$stat)]
  thresholds = seq(min-0.01, max+(max*.01), length.out=numThresholds)
  
  df.rates = data.frame(threshold=thresholds,
                         TPR=vector("numeric", length=length(thresholds)),
                         FPR=vector("numeric", length=length(thresholds)))
  # iterate through all thresholds
  for(i in 1:length(thresholds)) {
    # now finding TPR and FPR for a single threshold
    truePos=0
    falsePos=0
    pos=0
    neg=0
    # iterate through each realization from halfAndHalf input
    for(j in 1:length(df.input$do.win)) {
      if (df.input$do.win[j]) {
        pos=pos+1
        if(do.call(inequality, list(df.input$stat[j],thresholds[i]))) {
          truePos=truePos+1
        }
      }
      else {
        neg=neg+1
        if(do.call(inequality, list(df.input$stat[j],thresholds[i]))) {
          falsePos=falsePos+1
        }
      }
    }
    df.rates$TPR[i] = truePos/pos
    df.rates$FPR[i] = falsePos/neg
  }
  return(df.rates)
}
