colors <- c('Endemic' = 'red', 'Invader' = 'blue')

ggplot(data= df, aes_(x=time, y=pop2, color='Invader')) +
  geom_line() +
  geom_line(data=df, aes_(x=time, y=pop1, color='Endemic')) +
  ggtitle('Endemic and Invader Species Abundance') +
  xlab('time (unit time)') + ylab('abundance')