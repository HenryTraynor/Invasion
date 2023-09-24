# Invasion

Ovearleaf Document: https://www.overleaf.com/read/rbkhqhpprfnx

This project aims to create a probablistic model of invasive species model using traditional Lotka-Volterra competition equations. Analysis of these systems will then be directed to develop early warning system parameters for application to populations of invading species.

Equations in Question:

$$\frac{dN_i}{dt}=\beta_i N_i(1-\eta_i\frac{N_i}{K_i}-\alpha_{ij}\frac{N_j}{K_i})+\delta_i$$
$$\frac{dN_j}{dt}=\beta_j N_j(1-\eta_j\frac{N_j}{K_j}-\alpha_{ji}\frac{N_i}{K_j})+\delta_j$$
where,

$N_{i,j} =$ abudance of species i,j

$\beta_{i,j} =$ per capita growth rate of species i,j

$K_{i,j} =$ carrying capacity of species i,j agnostic of species j,i

$\eta_{i,j} =$ intraspecies competition factor

$\alpha_{ij,ji} =$ interspecies competition factor; read "effect of species j,i on species i,j"

$\delta_{i,j} =$ immigration factor; units individuals/unit time

Note, these equations distribute into the form,

$$\frac{dN_i}{dt}=\beta_i N_i - \eta_i\frac{\beta_i N_i^2}{K_i} - \alpha_{ij}\frac{\beta_i N_i N_j}{K_i}+\delta_i$$
$$\frac{dN_j}{dt}=\beta_j N_j - \eta_j\frac{\beta_j N_j^2}{K_j} - \alpha_{ji}\frac{\beta_j N_j N_i}{K_j}+\delta_i$$
such that, these terms represent rate of birth, rate of death from intraspecific competition, rate of death from interspecific competition, and rate of immigration, respectively, for a species.

When multiplied by a given time interval, the expected number of events for each term is given. This is the basis of 'contModel.R' and 'probModel.R'.

**Script Descriptions**

NEEDS UPDATE (some in LaTeX file)
