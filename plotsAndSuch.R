library(ggplot2)

initialN <- c(100,20)
attParms <- c(0.7, 0.8, 100, 120, 1.2, 0.8)
timeParms <- c(1/365, 100)

df.pop <- probModel(initialN, attParms, timeParms)

colors <- c('Endemic' = 'red', 'Invader' = 'blue')

ggplot(data=df.pop, aes_(x=df.pop[,1], y=df.pop[,3], color='Invader')) +
  geom_line() +
  geom_line(data=df.pop, aes_(x=df.pop[,1], y=df.pop[,2], color='Endemic')) +
  ggtitle('Endemic and Invader Species Abundance') +
  xlab('time (unit time)') + ylab('abundance')
