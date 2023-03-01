library(ggplot2)
library(gridExtra)

 ## required files
source('modelParam.R')
source('modelSim.R')
source('../intervalAnalysis.R')

#creation of table for plot legend
colNames <- c("n1",
              "n2",
              "b1",
              "b2",
              "k1",
              "k2",
              "a12",
              "a21",
              "a11",
              "a22",
              "del1",
              "del2",
              "tau")
param.table <- cbind(as.data.frame(att.param), as.data.frame(time.param[1]), row.names=NULL)

# set RNG seed for reproducible results:
set.seed(4563)

#test data set
df.alphaSim <- alphaSim(att.param, time.param, ratio.max=2)

#stat calculation for data set
#--------------------------------
#SD
df.sd <- intervalAnalysis(df.alphaSim, time.param, fun.call="sd")
#VARIANCE
df.var <- intervalAnalysis(df.alphaSim, time.param, fun.call="var")
#KURTOSIS
df.kurtosis <- intervalAnalysis(df.alphaSim, time.param, fun.call='kurtosis')
#SKEWNESS
df.skewness <- intervalAnalysis(df.alphaSim, time.param, fun.call='skewness')
#AUTO-CORRELATION
df.ac <- intervalAnalysis(df.alphaSim, time.param, fun.call='acf')
#--------------------------------

#plot creation
#--------------------------------
#plot for abundance
ggp1 <- ggplot(data=df.alphaSim, aes_(x=df.alphaSim[,1], y=df.alphaSim[,2], color='Endemic - Probabilistic')) +
  geom_line() +
  geom_line(data=df.alphaSim, aes_(x=df.alphaSim[,1], y=df.alphaSim[,3], color='Invader - Probabilistic')) +
  ggtitle('Endemic and Invader Species Abundance versus Time') +
  xlab('time (years)') + ylab('abundance') +
  theme(legend.position = "bottom") +
  geom_vline(xintercept=time.param$ttb, linetype='dashed', color='black')

#standard deviation plot
ggpSD <- ggplot(data=df.sd, aes_(x=df.sd[,1], y=df.sd[,3], color='SD: invader')) +
  geom_line()  +
  ggtitle('Invader Interval Standard Deviations') +
  xlab('time (years)') + ylab('number of individuals') +
  theme(legend.position = "bottom") +
  coord_cartesian(xlim = c(0, time.param$ttb*2)) +
  geom_vline(xintercept=time.param$ttb, linetype='dashed', color='black')

#variance plot
ggpVAR <- ggplot(data=df.var, aes_(x=df.var[,1], y=df.var[,3], color='var: invader')) +
  geom_line() +
  ggtitle('Invader Interval Variance') +
  xlab('time (years)') + ylab('number of individuals') +
  theme(legend.position = "bottom") +
  coord_cartesian(xlim = c(0, time.param$ttb*2)) +
  geom_vline(xintercept=time.param$ttb, linetype='dashed', color='black')

#kurtosis plot
ggpKURTOSIS <- ggplot(data=df.kurtosis, aes_(x=df.kurtosis[,1], y=df.kurtosis[,3], color='kurtosis: invader')) +
  geom_line() +
  ggtitle('Kurtosis') +
  xlab('time (years)') + ylab('number of individuals') +
  theme(legend.position = "bottom") +
  coord_cartesian(xlim = c(0, time.param$ttb*2)) +
  geom_vline(xintercept=time.param$ttb, linetype='dashed', color='black')

#skewness plot
ggpSKEWNESS <- ggplot(data=df.skewness, aes_(x=df.skewness[,1], y=df.skewness[,3], color='skewness: invader')) +
  geom_line() +
  ggtitle('skewness') +
  xlab('time (years)') + ylab('number of individuals') +
  theme(legend.position = "bottom") +
  coord_cartesian(xlim = c(0, time.param$ttb*2)) +
  geom_vline(xintercept=time.param$ttb, linetype='dashed', color='black')

#auto-correlation plot
ggpAC <- ggplot(data=df.ac, aes_(x=df.ac[,1], y=df.ac[,3], color='AC: invader')) +
  geom_line() +
  ggtitle('Autocorrelation') +
  xlab('time (years)') + ylab('number of individuals') +
  theme(legend.position = "bottom") +
  coord_cartesian(xlim = c(0, time.param$ttb*2)) +
  geom_vline(xintercept=time.param$ttb, linetype='dashed', color='black')

#plot displaying a12/a21 
ggpRATIO <- ggplot(data=df.alphaSim, aes_(x=df.alphaSim[,1], y=df.alphaSim[,4], color='Ratio: a12/a21')) +
  geom_line() +
  ggtitle('Interspecific Comp. Ratio versus Time') +
  xlab('time (years)') + ylab('a12/a21') +
  theme(legend.position = 'bottom') +
  geom_segment(x=0, y=1, xend=time.param$ttb, yend=1, linetype='dashed', color='black') +
  geom_segment(y=0, x=time.param$ttb, yend=1, xend=time.param$ttb, linetype='dashed', color='black')
#--------------------------------


#arrangement
grid.arrange(ggp1, ggpRATIO, ggpSD, ggpVAR, ggpKURTOSIS, ggpSKEWNESS, ncol=2)
