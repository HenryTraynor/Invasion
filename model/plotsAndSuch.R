library(ggplot2)

df.popD <- determModel(initial.N, att.param, time.param)

# set RNG seed for reproducible results:
#set.seed(1)
df.popP <- probModel(initial.N, att.param, time.param)

# ?? check color assignment; not as assigned here
colors <- c('Endemic - Deterministic' = 'red',
            'Invader - Deterministic' = 'blue',
            'Endemic - Probabilistic' = 'black',
            'Invader - Probabilistic' = 'yellow')

ggplot(data=df.popD, aes_(x=df.popP[,1], y=df.popP[,3], color='Invader - Probabilistic')) +
  geom_line() +
  geom_line(data=df.popP, aes_(x=df.popP[,1], y=df.popP[,2], color='Endemic - Probabilistic')) +
  geom_line(data=df.popD, aes_(x=df.popD[,1], y=df.popD[,2], color='Endemic - Deterministic')) +
  geom_line(data=df.popD, aes_(x=df.popP[,1], y=df.popD[,3], color='Invader - Deterministic')) +
  ggtitle('Endemic and Invader Species Abundance versus Time') +
  xlab('time (years)') + ylab('abundance')

