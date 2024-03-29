# time scale: years
# git test
# initial attributes for species interactions
att.param <- list(n1 = 500,
                  n2 = 0,
                  b1 = 0.65,
                  b2 = 0.65,
                  k1 = 500,
                  k2 = 500,
                  a12 = 1,
                  a21 = 1,
                  a11 = 1,
                  a22 = 1,
                  del1 = 0,
                  del2 = 2)

#time parameters
time.param <- list(tau = 1/52,
                   time.invade = 0,
                   time.window = 70,
                   window.step = 3)

singleWindow.time.param <- list(tau = 1/52,
                                time.invade = 0,
                                time.window = 52,
                                time.index = 520)

# singleWindow.time.param <- list(tau,
#                                 time.invade,
#                                 time.window = width of window for stat in units tau
#                                 time.index = location of the left-hand edge of window in units tau

#times to bifurcation - LEAVE AT LENGTH 3
ttb.times <- c(75,
               100,
               125)

#desired stats that can be passed through 'rollapply'
stats <- c('mean', 
           'sd',
           'var',
           'kurtosis',
           'skewness')
