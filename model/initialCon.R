# time scale: years

# initial attributes for species interactions
att.param <- c(b1 = .12,
               b2 = .3,
               k1 = 700,
               k2 = 800,
               a12 = 1.1,
               a21 = 0.9,
               del1 = 0.0,
               del2 = 2)

#time parameters (tau, time_max, time_invade)
time.param <- c(1/52,
                150,
                10)

# initial population size: (species 1, species2)
initial.N <- c(700,
               0)