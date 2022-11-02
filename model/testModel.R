source('setup.R')

##?? *.param found in file...?
df.popD <- modelSim(att.param, time.param, do.prob = FALSE)

# set RNG seed for reproducible results:
set.seed(1)
nsim <- 10
#?? see help for parallel::mclapply 
l.popP <- lapply(1:nsim, modelSim,
    att.param=att.param, time.param=time.param
)

##?? how do we test results?
