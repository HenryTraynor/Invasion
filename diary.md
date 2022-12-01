This markdown file serves as a log for important updates, mainly so big-picture details can be more easily accessed than in commit messages.

**10/10/2022**

Currently, the probablistic model has been created but requires optimization and file organization needs to be completed for reduced runtime, decreased
dependencies, and ease of model iteration. Graphical outputs in ggplot seem to align with predictions made in the deterministic model.

**10/13/2022**

'plotsAndSuch.R' now displays both the deterministic and probabilistic models overlayed with each other for comparison. 'determModel.R' now holds the
deterministic model which has been replaced with the same code as the probabilistic model without the calls to rpois. This should allow for easier 
plotting in ggplot and eliminates a package use (deSolve).

**10/21/2022**

Previous week as consisted of final model script optimization and the creation of an interval analysis script titled 'intervalAnalysis.R'. This script will carry out stastical summaries on a given window of population data. Then, this interval will be advance by a given time step that is less than the length of the window. Plotting calculated quantities on the right-hand side of the window against time with confidence intervals for many model iterations is the near goal. Also working on graphing multiple start parameters at a time.

**11/01/2022**

Standard devations are now computed over a given window and properly time indexed. 'intervalStanDev()' returns a dataframe that can then easily be plotted for comparison with abundance graph. Uisng package 'gridExtra', these plots are arranged side by side; look into overlaying on same graph with different scales.  'setup.R' sources all the necessary files to run the model and generate data frames. 'testModel.R' produces a desired number of realizations of the model for a parameter set.

**11/08/2022** 

We now see 'bifrucation.R' that plots the ratio of interspecific competition against abundance at a given time that is taken to be a time-state of equilibrium. This is currently an unexpected shape; needs more pencil-paper experimentation; evaluate the meaning of a_ii

**11/29/2022**

Adding link to overleaf doc to README
