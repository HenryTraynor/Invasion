# time scale: ?

tau <- 5
time <- 0
time_max <- 100

popSize.data <- data.frame(
  popSize_name = c("Endemic", "Invader"),
  individuals = c(initialN[1], initialN[2])
)

while (time<time_max) {
  # +/- terms
  births1 = rpois(1, tau * b1 * popSize.data[1, ncol(popSize.data)])
  births2 = rpois(1, tau * b2 * popSize.data[2, ncol(popSize.data)])
  intraD1 = rpois(1, tau * b1 * (popSize.data[1, ncol(popSize.data)]^2))
  intraD2 = rpois(1, tau * b2 * (popSize.data[2, ncol(popSize.data)]^2))
  interD1 = rpois(1, tau * b1 * a12 * popSize.data[1, ncol(popSize.data)] * popSize.data[2, ncol(popSize.data)])
  interD2 = rpois(1, tau * b2 * a21 * popSize.data[1, ncol(popSize.data)] * popSize.data[2, ncol(popSize.data)])
  immigration1 = rpois(1, tau * d1 * popSize.data[1, ncol(popSize.data)])
  immigration2 = rpois(1, tau * d2 * popSize.data[2, ncol(popSize.data)])
  
  popSize.data$individuals <- c(popSize.data[1, ncol(popSize.data)]+ births1 - intraD1 - interD1 + immigration1,
                                popSize.data[2, ncol(popSize.data)]+ births2 - intraD2 - interD2 + immigration2,)
  
  time = time + tau
}
