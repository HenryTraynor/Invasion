# initial attributes for species interactions
initialAtt <- c(b1 = .05,
                b2 = .07,
                k1 = 100,
                k2 = 100,
                a12 = 0.6,
                a21 = 0.3,
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
              20)
