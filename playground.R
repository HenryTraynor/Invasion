library(ggplot2)
library(grid)
library(gridExtra)

time.param <- list(tau = 1/52,
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
                       ttb=25,
                       halfSimulations=50,
                       fail.ratio=0.1)

df.SD <- singleWindowStat(df.data=df.test,
                          singleWindow.time.param,
                          func="sd")

endemic.data = data.frame(endemic=c(att.param[1],att.param[3],att.param[5],att.param[7],att.param[9],att.param[11]))
colnames(endemic.data) = c('Initial N', 'Birth Rate', 'Carrying Cap.', 'Initial Inter.', 'Intra.', 'Immigration')
invader.data = data.frame(invader=c(att.param[2],att.param[4],att.param[6],att.param[8],att.param[10],att.param[12]))
colnames(invader.data) = c('Initial N', 'Birth Rate', 'Carrying Cap.', 'Initial Inter.', 'Intra.', 'Immigration')
parameters = rbind(endemic.data, invader.data)
rownames(parameters) = c("endemic", 'invader')

time.parameters = as.data.frame(t(c('1 Week', '10 Years', '1 Year', '70 Years', '100 each')))
colnames(time.parameters) = c('Tau', 'Window Start', 'Window Length', 'Run-time', 'Realizations')
rownames(time.parameters) = c('value')

plot <-ggplot(data=df.SD,
       aes(x=stat, y=do.win)) +
       geom_point(alpha=0.15, size=5) +
       labs(x='Standard Deviation', y="Invade?") +
       ggtitle("Standard Deviation for Successful and Unsuccessful Invasions")

grid.arrange(
  arrangeGrob(plot),
  tableGrob(parameters),
  tableGrob(time.parameters),
  layout_matrix = cbind(c(1,1,1,1,2,3),
                        c(1,1,1,1,2,3),
                        c(1,1,1,1,2,3),
                        c(1,1,1,1,2,3))
)

plot(df.rates$FPR,df.rates$TPR)

#-------------------------------------
df.test <- halfAndHalf(att.param,
                       singleWindow.time.param,
                       ttb=25,
                       halfSimulations=75,
                       fail.ratio=0.25)

df.input <- singleWindowStat(df.data=df.test,
                             singleWindow.time.param,
                             func="sd")


df.rates <- ROCcurveData(df.input, numThresholds = 75, inequality = ">")

ROCcurve <- ggplot(data=df.rates,
                   aes(x=FPR, y=TPR)) + geom_point() + geom_abline(slope=1, intercept=0, linetype=3)
ROCcurve

AUC(x=df.rates$FPR, y=df.rates$TPR, method='trapezoid')

