library(ggplot2)

time.param <- list(tau = 1/365,
                   time.invade = 0,
                   time.window = 70,
                   window.step = 3)
ttb.test <- 25

df.data <- alphaSim(att.param, time.param, ratio.max=0.5, ttb=ttb.test, do.fail=TRUE)

test.plot <- ggplot(df.data, aes(x=df.data[,1], y=df.data[,2])) +
  geom_line() +
  ggtitle('Species Abundance versus Time') +
  xlab('time (years)') + ylab('abundance') +
  theme(legend.position = "bottom") +
  geom_vline(xintercept=ttb.test, linetype='dashed', color='black') +
  scale_y_continuous(limits = c(0,600))

test.plot

pass_fail <- halfAndHalf(ttb=5,
                         passSimulations=3,
                         failSimulations=3)

#------------------------------------

df.test <- halfAndHalf(att.param,
                       singleWindow.time.param,
                       ttb=50,
                       halfSimulations=15,
                       fail.ratio=0.25)

df.SD <- singleWindowStat(df.data=df.test,
                          singleWindow.time.param)

plot(df.SD)

ggplot(data=df.SD,
       aes(x=stat, y=do.fail)) + geom_point()
