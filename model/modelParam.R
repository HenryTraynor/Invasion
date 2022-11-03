# time scale: years

# initial attributes for species interactions
att.param <- list(n1 = 700,
                  n2 = 0,
                  b1 = .2,
                  b2 = .3,
                  k1 = 700,
                  k2 = 900,
                  a12 = 1.2,
                  a21 = 0.8,
                  del1 = 0.0,
                  del2 = 3)

#time parameters
time.param <- list(tau = 1/52,
                   time.max = 100,
                   time.invade = 0,
                   time.window = 8/52,
                   window.step = 1)
