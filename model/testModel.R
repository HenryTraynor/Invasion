source('setup.R')

##?? *.param found in file...?
df.popD <- modelSim(att.param, time.param, do.prob = FALSE)

# set RNG seed for reproducible results:
set.seed(1)
df.popP <- modelSim(att.param, time.param)

##?? how do we test results?
