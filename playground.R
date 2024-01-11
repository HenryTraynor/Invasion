library(ggplot2)
library(bit64)
time.param <- list(tau = 1/365,
                   time.invade = 0,
                   time.window = 70,
                   window.step = 3)
ttb.test <- 100

df.data <- alphaSim(att.param, time.param, ratio.max=2, ttb=ttb.test)

test.plot <- ggplot(df.data, aes_(x=df.data[,1], y=df.data[,2])) +
  geom_line() +
  ggtitle('Species Abundance versus Time') +
  xlab('time (years)') + ylab('abundance') +
  theme(legend.position = "bottom") +
  geom_vline(xintercept=ttb.test, linetype='dashed', color='black')

test.plot


plot.test