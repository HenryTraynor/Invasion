#currently using plot.test globally defined

library(gridExtra)
library(grid)

simulations=50

plots <- stats.plots(ttb.times,
                     simulations,
                     stats)

endemic.data = data.frame(endemic=c(att.param[1],att.param[3],att.param[5],att.param[7],att.param[9],att.param[11]))
colnames(endemic.data) = c('Initial N', 'Birth Rate', 'Carrying Cap.', 'Initial Inter.', 'Intra.', 'Immigration')
invader.data = data.frame(invader=c(att.param[2],att.param[4],att.param[6],att.param[8],att.param[10],att.param[12]))
colnames(invader.data) = c('Initial N', 'Birth Rate', 'Carrying Cap.', 'Initial Inter.', 'Intra.', 'Immigration')
parameters = rbind(endemic.data, invader.data)
rownames(parameters) = c("endemic", 'invader')

time.parameters = cbind(data.frame(time.param), simulations)
colnames(time.parameters) = c('Tau', 'Invasion Time', 'Window (tau)', 'Step (tau)', 'Realizations')
rownames(time.parameters) = c('value')
time.parameters[1][1] = '1/52'

grid.arrange(
  top = "Statistic Calculations of Invader Abundance",
  arrangeGrob(plots[[1]][[1]]+ggtitle('TTB: 75'),
              plots[[1]][[2]]+ggtitle('TTB: 100'),
              plots[[1]][[3]]+ggtitle('TTB: 125'),
              ncol = 3,
              left = textGrob('Mean', rot = 90)),
  arrangeGrob(plots[[2]][[1]],
              plots[[2]][[2]],
              plots[[2]][[3]],
              ncol = 3,
              left = textGrob('Stan. Dev', rot = 90)),
  arrangeGrob(plots[[3]][[1]],
              plots[[3]][[2]],
              plots[[3]][[3]],
              ncol = 3,
              left = textGrob('Variance', rot = 90)),
  arrangeGrob(plots[[4]][[1]],
              plots[[4]][[2]],
              plots[[4]][[3]],
              ncol = 3,
              left = textGrob('Kurtosis', rot = 90)),
  arrangeGrob(plots[[5]][[1]],
              plots[[5]][[2]],
              plots[[5]][[3]],
              ncol = 3,
              left = textGrob('Skewness', rot = 90)),
  tableGrob(parameters),
  tableGrob(time.parameters),
  layout_matrix = cbind(c(1,2,3,4,5,6),
                        c(1,2,3,4,5,6),
                        c(1,2,3,4,5,6),
                        c(1,2,3,4,5,7),
                        c(1,2,3,4,5,7),
                        c(1,2,3,4,5,7))
)


