#summary <- min, 1st Q, median, mean, 3rd Q, max
summary <- summary(df.popD$endemic)

time.interval <- c(1, 8/52) #(1 year interval, 8 weeks)



step <- 0
time <- 0
time.step <- time.interval[2]
time.range <- time.interval[1]
time.max <- time.param[2]
df.pop <- df.popD

num.interval <- as.integer((time.max-time.range)/time.step)

df.summary <- data.frame(interval = seq(0,time.max-time.range,by=time.step),
                         minimum = vector("double", num.interval+1),
                         firstQ = vector("double", num.interval+1),
                         median = vector("double", num.interval+1),
                         mean = vector("double", num.interval+1),
                         thirdQ = vector("double", num.interval+1),
                         max = vector("double", num.interval+1))

while(time < time.max-time.range) {
  step <- step+1
  time <- time+time.step
  summary <- as.numeric(summary(df.pop$endemic[step:step+1]))
  df.summary[step,2:7] <- summary
}
print(df.summary)
