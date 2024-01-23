halfAndHalf <- function(ttb, passSimulations, failSimulations) {
    pass_sim_list = replicate(n=passSimulations,
                              expr=alphaSim(att.param,time.param,ratio.max=2, ttb=ttb,do.fail=FALSE),
                              simplify=F)
    fail_sim_list = replicate(n=failSimulations,
                              expr=alphaSim(att.param,time.param,ratio.max=2, ttb=ttb,do.fail=TRUE),
                              simplify=F)
    data.list = c()
    for(i in passSimulations) {
      data.list[[i]] = pass_sim_list[[i]]
    }
    for(i in failSimulations) {
      data.list[[i+passSimulations]] = fail_sim_list[[i]]
    }
    
    df.output = data.frame(success=c(c(rep("pass",passSimulations)),c(rep("fail", failSimulations))),
                           simulation=c(data.list))
}
