# Invasion

This project aims to create a probablistic model of invasive species model using traditional Lotka-Volterra competition equations. Analysis of these systems will then be directed to develop early warning system parameters for application to populations of invading species.

**Script Descriptions**

initialCon.R --
outlines initial conditions and atttributes of species interactions to be passed through the two model scripts

contModel.R --
deterministic model of competitive interaction

probModel.R -- 
probabalistic model of competitive interaction using tau leap method and Poisson distribution

plotsAndSuch.R --
calls function from model scripts and passed parameters to generate plots and other graphical outputs

**Diary**

(10/10/2022)
Currently, the probablistic model has been created but requires optimization and file organization needs to be completed for reduced runtime, decreased dependencies, and ease of model iteration. Graphical outputs in ggplot seem to align with predictions made in the deterministic model.

