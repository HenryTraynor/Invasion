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
halfSimulations <- 3


pass_sim_list = c(replicate(n=passSimulations,
                          expr=alphaSim(att.param,time.param,ratio.max=2, ttb=5,do.fail=FALSE),
                          simplify=F))
fail_sim_list = c(replicate(n=failSimulations,
                          expr=alphaSim(att.param,time.param,ratio.max=2, ttb=5,do.fail=TRUE),
                          simplify=F))

df.data <- data.frame(success=c(rep("pass", halfSimulations),rep("fail", halfSimulations)),
                      data=vector(length=halfSimulations*2))

for(i in 1:halfSimulations) {
  df.data$data[i]=pass_sim_list[i]
  df.data$data[i+halfSimulations]=fail_sim_list[i]
}

df.data = as.data.frame(data.list)

df.output = data.frame(success=c(rep("pass",passSimulations),rep("fail", failSimulations)))



