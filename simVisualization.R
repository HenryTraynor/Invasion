#currently using plot.test globally defined

library(gridExtra)

grid.arrange(
  plot.test[[1]][[1]],
  plot.test[[1]][[2]],
  plot.test[[1]][[3]],
  plot.test[[2]][[1]],
  plot.test[[2]][[2]],
  plot.test[[2]][[3]],
  plot.test[[3]][[1]],
  plot.test[[3]][[2]],
  plot.test[[3]][[3]],
  plot.test[[4]][[1]],
  plot.test[[4]][[2]],
  plot.test[[4]][[3]],
  ncol = length(ttb.times),
  top = "Statistic Calculations of Invader Abundance"
)
