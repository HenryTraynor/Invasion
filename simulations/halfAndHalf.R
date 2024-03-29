halfAndHalf <- function(att.param, time.param,ttb, halfSimulations, win.ratio, fail.ratio, increasing=TRUE) {
  #generates abundance data for halfSimulations where invader wins and halfSimulations where invaders loses
  
  #data
  pass_sim_list = replicate(n=halfSimulations,
                            expr=alphaSim(att.param,time.param,ratio.max=win.ratio, ttb=ttb,do.win=increasing),
                            simplify=F)
  fail_sim_list = replicate(n=halfSimulations,
                            expr=alphaSim(att.param,time.param,ratio.max=fail.ratio, ttb=ttb,do.win=FALSE),
                            simplify=F)
  #initialize df to store data
  df.data <- data.frame(do.win=c(rep(TRUE, halfSimulations),rep(FALSE, halfSimulations)),
                        data=vector(length=halfSimulations*2))
  #place data in df
  for(i in 1:halfSimulations) {
    df.data$data[i]=pass_sim_list[i]
    df.data$data[i+halfSimulations]=fail_sim_list[i]
  }
  return(df.data)
}
