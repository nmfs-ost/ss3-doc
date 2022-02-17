---
geometry: margin=1in
month: "February"
year: "2022"
preamble: |
output:
  sa4ss::techreport_pdf:
    default
  bookdown::pdf_document2:
    keep_tex: true
lang: en
papersize: letter
---



<!--chapter:end:00a.Rmd-->

---
author:
  - name: Chantel R. Wetzel
    code: 1
    first: C
    middle: R
    family: Wetzel
  - name: Kathryn Doering
    code: 1
    first: K
    middle: L
    family: Doering
author_list: Wetzel, C.R., K.L. Doering
affiliation:
  - code: 1
    address: Northwest Fisheries Science Center, U.S. Department of Commerce, National
      Oceanic and Atmospheric Administration, National Marine Fisheries Service, 2725
      Montlake Boulevard East, Seattle, Washington 98112

address:
  - ^1^Northwest Fisheries Science Center, U.S. Department of Commerce, National Oceanic
    and Atmospheric Administration, National Marine Fisheries Service, 2725 Montlake
    Boulevard East, Seattle, Washington 98112
---

<!--chapter:end:00authors.Rmd-->

---
bibliography:
  - sa4ss.bib
---

<!--chapter:end:00bibliography.Rmd-->

---
title: Technical description of Stock Synthesis assessment program
---

<!--chapter:end:00title.Rmd-->

\pagebreak
\pagenumbering{roman}
\setcounter{page}{1}

\renewcommand{\thetable}{\roman{table}}
\renewcommand{\thefigure}{\roman{figure}}


\setlength\parskip{0.5em plus 0.1em minus 0.2em}

<!--chapter:end:01a.Rmd-->


<!--chapter:end:01executive.Rmd-->

\pagebreak
\setlength{\parskip}{5mm plus1mm minus1mm}
\pagenumbering{arabic}
\setcounter{page}{1}
\renewcommand{\thefigure}{\arabic{figure}}
\renewcommand{\thetable}{\arabic{table}}
\setcounter{table}{0}
\setcounter{figure}{0}

<!--chapter:end:10a.Rmd-->

The Stock Synthesis 3 (SS3) assessment program provides a statistical framework for calibration of a population dynamics model using a diversity of fishery and survey data. SS is designed to deal with both age- and size-structure with multiple stock sub-areas and multiple growth patterns. The description here details the most commonly applied features, along with a subset of the more advanced options offered by SS3.

# Population Model

The factors described here are those that control the rate at which new individuals recruit to the population each time step; the rate at which they die due to fishing and natural mortality; and the rate at which they grow and contribute to the total biomass and reproductive potential of the stock. The total population can be divided among one to many entities. The total of all entities born within a year are referred to as a year-class or cohort. Each of the biologically- or birthseason- delineated entities is referred to as a morph. In addition, each morph can be sub-divided into slow-, medium-, and fast-growing entities termed platoons **(Goodyear 1996; Taylor and Methot 2012)**. The model description here does not include subscripting for morphs or platoons in an attempt for simplicity, but each of these entities is tracked in the population dynamics and biology if the user chooses to invoke these features. Each cohort/morph/platoon is split into males and females if the user invokes a two-sex configuration, and the subscript for gender is included in the description below.



<!--chapter:end:11introduction.Rmd-->

## Initial Numbers-at-Age

The population in the initial year of a SS application can be simply an unfished equilibrium population, a population in equilibrium with an estimated mortality rate that is influenced by data on historical equilibrium catch, or an equilibrium population that has estimable age-specific deviations from this equilibrium for a user-specified number of the younger ages.

The numbers of animals of gender $\gamma$ in age group a in a virgin state ($y=0$) is:

\begin{equation}
\label{eqn1}
N_{0,\gamma,a} =
\begin{cases}
cR_0e^{-aM_{\gamma,a}} & \text{for $a=0$ to $A-1$} \\
\sum_{a=A}^{3A-1}N_{0,\gamma,a} + \frac{N_{0,\gamma,3A-1}e^{-M_{\gamma,a}}}{1-e^{-M_{\gamma,a}}} & \text{for $a=A$ to $3A-1$}\\
\end{cases}
\end{equation}

where $c$ (I)[^1] is a user-defined constant that determines the sex-ratio of recruits[^2], $M_{\gamma,a}$ (P)[^3] is natural mortality for age a and sex $\gamma$, $A$ is the plus-group age, $3A$ is three times the plusgroup age, and $R_0$ is the number of age-0 fish at unfished equilibrium. The plus group virgin
numbers-at-age calculation is based on 3 timex the maximum age to include movement dynamics through age $3A-1$. After calculating the numbers-at-age through age $3A$, the numbers are collapsed to age A for subsequent calculations. Equation \ref{eqn1} use total mortality, $Z_{\gamma,a}$ (see Equation 1.21 XX), rather than $M_{\gamma,a}$ when the initial equilibrium also involves fishing mortality. Although this fishing mortality will reduce spawning biomass, no adjustment to $R_0$ is made on premise that this reduction has probably not been occurring for enough years to effect this change. $R_0$ serves as both the starting level of mean recruitment and as the factor that scales the mean spawner-recruitment relationship against which future annual recruitment deviations will act. An estimated offset, $R_1$, can be applied to $R_0$. When the initial population involves agespecific deviations, these deviations are an extension of the zero-centered, lognormal recruitment deviations applied to the equilibrium numbers-at-age (see Equation 1.20 XX).

[^1]: User-specified quantities will henceforth be denoted as "(I)". 
[^2]: The term "recruits" is used to refer to age-0 animals. 
[^3]: Estimated quantities will henceforth be denoted as "(P)".

## Recruitment

The number of age-0 fish is related to spawning biomass according to a stock-recruitment relationship. A range of stock-recruitment relationships are available. Here, the Beverton-Holt is described:

\begin{equation}
\label{eqn2}
R_y = \frac{4hR_0SB_y}{SB_0(1-h)+SB_y(5h-1)}e^{-0.5b_y\sigma_R^2+\tilde{R}_y} \;\ \tilde{R}_y \sim N(0; \sigma_R^2)
\end{equation}



<!--chapter:end:12init_numbers_recruitment.Rmd-->

## Initial Growth


## Natural Mortality


## Growth


## Variation in Size-at-Age


## Age-Length Population Structure


## Body Weight


## Maturity and Fecundity


<!--chapter:end:13biology.Rmd-->

## Population with Fishing Mortality

<!--chapter:end:14fishing_mort.Rmd-->

## Selectivity



## Retention

<!--chapter:end:15selectivity.Rmd-->

# Observation Model

<!--chapter:end:20observation_model.Rmd-->

## Survey Observation

<!--chapter:end:21survey.Rmd-->

## Abundance Indices

<!--chapter:end:22indices.Rmd-->

## Composition Data


### Length Compositions


### Age Compositions

<!--chapter:end:23composition_data.Rmd-->

# Statistical Model

<!--chapter:end:30statistical_model.Rmd-->

## Likelihood Components

<!--chapter:end:31likelihood.Rmd-->

## Recruitment Deviaitons

<!--chapter:end:32recruit_devs.Rmd-->

## Parameter Priors


## Parameter Deviations

<!--chapter:end:34para_priors.Rmd-->

## Crash Penalties

<!--chapter:end:35crash_penalities.Rmd-->

# Management Quantities

<!--chapter:end:40management_quants.Rmd-->

## Reference Points

<!--chapter:end:41reference_points.Rmd-->

## Forecast


### U.S. West Coast Groundfish Control Rule



### U.S. Alaska Control Rule

<!--chapter:end:42forecast.Rmd-->

# Advanced Model Options

<!--chapter:end:50advanced_options.Rmd-->

\clearpage

# References
<!-- If you want to references to appear somewhere before the end, add: -->
<div id="refs"></div>
<!-- where you want it to appear -->
<!-- The following sets the appropriate indentation for the references
  but it cannot be used with bookdown and the make file because it leads
  to a bad pdf.
\noindent
\vspace{-2em}
\setlength{\parindent}{-0.2in}
\setlength{\leftskip}{0.2in}
\setlength{\parskip}{8pt}
 -->

<!--chapter:end:69bibliography.Rmd-->

