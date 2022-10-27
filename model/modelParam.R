# time scale: years

# initial attributes for species interactions
att.param <- c(b1 = .25,
               b2 = .3,
               k1 = 700,
               k2 = 700,
               a12 = 1.05,
               a21 = 0.95,
               del1 = 0.0,
               del2 = 2)

#time parameters (tau, time_max, time_invade)
time.param <- c(1/52,
                150,
                0)

# initial population size: (species 1, species2)
initial.N <- c(700,
               0)

# (window, step) - step must be a multiple of tau
time.interval <- c(1, 8/52) #(1 year interval, 8 weeks)
