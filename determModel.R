library(deSolve)

out <- ode(y = initialN, times = 1:400, func = LVcomp, parms = initialAtt)
matplot(out[, 1], out[, -1], type = "l") 

