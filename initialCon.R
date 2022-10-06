# function for continuous analysis (maybe place in 'contModel' script?)
LVcomp <- function (t, n, parms) {
  with(as.list(parms), {
    dn1dt <- b1 * (1 - (n[1]/k1) - a12 * (n[2]/k1))
    dn2dt <- b2 * n[2] * (1 - (n[2]/k2) - a21 * (n[1]/k2))
    list(c(dn1dt, dn2dt))
  })
}

# initial attributes for species interactions
initialAtt <- c(b1 = .2,
                b2 = .03,
                k1 = 100,
                k2 = 100,
                a12 = 0.6,
                a21 = 0.1,
                delta1 = 0.0,
                delta2 = 0.3)

# for access in 'discreteProb' script
b1 <- initialAtt[1]
b2 <- initialAtt[2]
k1 <- initialAtt[3]
k2 <- initialAtt[4]
a12 <- initialAtt[5]
a21 <- initialAtt[6]
d1 <- initialAtt[7]
d2 <- initialAtt[8]

# initial population size: (species 1, species2)
initialN <- c(100,
              10)
