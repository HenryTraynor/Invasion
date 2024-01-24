halfAndHalf <- function(att.param, time.param,ttb, halfSimulations, fail.ratio) {
  #generates abundance data for halfSimulations where invader wins and halfSimulations where invaders loses
  
  #data
  pass_sim_list = replicate(n=halfSimulations,
                            expr=alphaSim(att.param,time.param,ratio.max=2, ttb=ttb,do.fail=FALSE),
                            simplify=F)
  fail_sim_list = replicate(n=halfSimulations,
                            expr=alphaSim(att.param,time.param,ratio.max=fail.ratio, ttb=ttb,do.fail=TRUE),
                            simplify=F)
  #initialize df to store data
  df.data <- data.frame(do.fail=c(rep(FALSE, halfSimulations),rep(TRUE, halfSimulations)),
                        data=vector(length=halfSimulations*2))
  #place data in df
  for(i in 1:halfSimulations) {
    df.data$data[i]=pass_sim_list[i]
    df.data$data[i+halfSimulations]=fail_sim_list[i]
  }
  return(df.data)
}
