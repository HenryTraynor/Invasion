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
