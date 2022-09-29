LVcomp <- function (t, n, parms) {
  with(as.list(parms), {
    dn1dt <- birth1 * (1 - (n[1]/k1) - a12 * (n[2]/k1))
    dn2dt <- b2 * n[2] * (1 - (n[2]/k2) - a21 * (n[1]/k2))
    list(c(dn1dt, dn2dt))
  })
}

initialAtt <- c(b1 = 0.2,
                b2 = 0.3,
                k1 = 10,
                k2 = 10,
                a12 = 0.1,
                a21 = 0.5)

birth1 <- initialAtt[1]
birth2 <- initialAtt[2]
k1 <- initialAtt[3]
k2 <- initialAtt[4]
a12 <- initialAtt[5]
a21 <- initialAtt[6]

initialN <- c(10,
              1)