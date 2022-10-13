library(deSolve)

# function for continuous analysis (maybe place in 'contModel' script?)
LVcomp <- function (t, n, parms) {
  with(as.list(parms), {
    dn1dt <- b1 * n[2] * (1 - (n[1]/k1) - a12 * (n[2]/k1))
    dn2dt <- b2 * n[2] * (1 - (n[2]/k2) - a21 * (n[1]/k2))
    list(c(dn1dt, dn2dt))
  })
}

out <- ode(y = initialN, times = 1:100, func = LVcomp, parms = initialAtt)
matplot(out[, 1], out[, -1], type = "l") 