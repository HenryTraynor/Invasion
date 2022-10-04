# time scale: ?

tau <- 0.5
time <- 0
time_max <- 100

# (c(species i), c(species j))
popSize <- matrix(c(initialN[1], initialN[2]), nrow = 1, ncol =2, byrow = TRUE)

print(rpois(10, tau * b1 * popSize[nrow(popSize),2]))

while (time<time_max) {
  # +/- terms
  births1 = rpois(1, tau * b1 * popSize[nrow(popSize), 1])
  births2 = rpois(1, tau * b2 * popSize[nrow(popSize), 2])
  intraD1 = rpois(1, tau * b1 * (popSize[nrow(popSize),1]^2))
  intraD2 = rpois(1, tau * b2 * (popSize[nrow(popSize),2]^2))
  interD1 = rpois(1, tau * b1 * a12 * popSize[nrow(popSize),1] * popSize[nrow(popSize),2])
  interD2 = rpois(1, tau * b2 * a21 * popSize[nrow(popSize),1] * popSize[nrow(popSize),2])
  immigration1 = rpois(1, tau * d1 * popSize[nrow(popSize),1])
  immigration2 = rpois(1, tau * d2 * popSize[nrow(popSize),2])
  
  nextStep <- c(popSize[nrow(popSize), 1]+ births1 - intraD1 - interD1 + immigration1,
                popSize[nrow(popSize), 2]+ births2 - intraD2 - interD2 + immigration2)
  
  popSize <- rbind(popSize, nextStep)
  
  time = time + tau
}

plot(popSize[, 1], popSize[, 2])

