library(ggplot2)
library(gridExtra)

 ## required files
source('modelParam.R')
source('modelSim.R')
source('../intervalAnalysis.R')

##?? *.param found in file...?
df.popD <- modelSim(att.param, time.param, do.prob = FALSE)

# set RNG seed for reproducible results:
#set.seed(1)
df.popP <- modelSim(att.param, time.param)

#standard deviation calculation
df.sd <- intervalStanDev(df.popD, time.param)

df.sd <- intervalStanDev(df.popP, time.param)

# ?? check color assignment; not as assigned here
colors <- c('Endemic - Deterministic' = 'red',
            'Invader - Deterministic' = 'blue',
            'Endemic - Probabilistic' = 'black',
            'Invader - Probabilistic' = 'yellow')

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

ggp1 <- ggplot(data=df.popP, aes_(x=df.popP[,1], y=df.popP[,3], color='Invader - Probabilistic')) +
        geom_line() +
        geom_line(data=df.popP, aes_(x=df.popP[,1], y=df.popP[,2], color='Endemic - Probabilistic')) +
        ggtitle('Endemic and Invader Species Abundance versus Time') +
        xlab('time (years)') + ylab('abundance') +
        theme(legend.position = "bottom")

ggp2 <- ggplot(data=df.popD, aes_(x=df.popD[,1], y=df.popD[,3], color='Invader')) +
  geom_line() +
  geom_line(data=df.popD, aes_(x=df.popD[,1], y=df.popD[,2], color='Endemic')) +
  ggtitle('Endemic and Invader Species Abundance versus Time') +
  xlab('time (years)') + ylab('abundance') +
  theme(legend.position = "bottom")

ggp2 <- ggplot(data=df.sd, aes_(x=df.sd[,1], y=df.sd[,2], color='SD: Endemic')) +
        geom_line() +
        geom_line(data=df.sd, aes_(x=df.sd[,1], y=df.sd[,3], color='SD: Invader')) +
        ggtitle('Endemic and Invader Interval Standard Deviations') +
        xlab('time (years)') + ylab('number of individuals') +
        coord_cartesian(xlim = c(0, 100))

grid.arrange(ggp1, ggp2, tableGrob(mytable))

grid.arrange(ggp1, ggp2, tableGrob(param.table), heights=c(3,3,1), ncol=1)
