**10/10/2022**

Currently, the probablistic model has been created but requires optimization and file organization needs to be completed for reduced runtime, decreased
dependencies, and ease of model iteration. Graphical outputs in ggplot seem to align with predictions made in the deterministic model.

**10/13/2022**

'plotsAndSuch.R' now displays both the deterministic and probabilistic models overlayed with each other for comparison. 'determModel.R' now holds the
deterministic model which has been replaced with the same code as the probabilistic model without the calls to rpois. This should allow for easier 
plotting in ggplot and eliminates a package use (deSolve).