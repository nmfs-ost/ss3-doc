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


where $R_0$ (P) is the unfished equilibrium recruitment, $SB_0$ is the unfished equilibrium spawning biomass (or spawning output) corresponding to $R_0$, $SB_y$ is the spawning biomass at the start of the spawning season
during year $y$, $h$ (P) is the steepness parameter, $b_y$ (I) is the bias adjustment fraction applied
during year $y$, $\sigma_R$ (P) is the standard deviation among recruitment deviations in log space, and
$\tilde{R}_y$ (P) is the lognormal recruitment deviation for year $y$. The bias-adjustment factor **(Methot
and Taylor 2011)** ensures unbiased estimation of mean recruitment even during data-poor eras in
which the maximum likelihood estimate of the $\tilde{R}_y$ is near 0.0.

The annual bias-adjustment fraction by $b_y$ is the piecewise linear function:

\begin{equation}
\label{eqn3}
b_y =
\begin{cases}
0 & \text{for $y \leq y_1^b$} \\
b_{\text{max}}(1-\frac{y-y_1^b}{y_2^b-y_1^b}) & \text{for $y_1^b < y < y_2^b$} \\
b_{\text{max}} & \text{for $y_2^b \leq y \leq y_3^b$} \\
b_{\text{max}}(1-\frac{y_3^b-y}{y_4^b-y_3^b}) & \text{for $y_3^b < y < y_4^b$} \\
0 & \text{for $y_4^b \leq y$} \\
\end{cases}
\end{equation}

where $y_1^b$ (I) is the first year of the bias ramp up adjustment period, $y_2^b$  (I) is the last year of the
bias ramp up adjustment period, $y_3^b$ (I) is the first year of the bias ramp down adjustment period,
$y_4^b$ (I) is the last year of the bias ramp down adjustment period, and $b_{\text{max}}$ (I) is the maximum bias adjustment applied to recruitment deviations.

The total annual recruitment can be partitioned among growth morphs and birth seasons and areas according to a design matrix. Each of these entities can be further divided into males and females according to a pre-specified fraction. Finally, each of these entities can be further subdivided into platoons that will have slow, medium or large size-at-age relative to the average size-at-age for the overall morph. For morphs that are designated to recruit in a season after the spawning season, their age 0 for the purposes of growth occurs at the start of that season. Thus, they will have smaller size-at-age relative to morphs of that annual cohort that are born earlier, but will grow towards the same $L_\infty$.

### Additional Stock Recruitment Relationship Functional Forms

<!--chapter:end:12init_numbers_recruitment.Rmd-->

## Natural Mortality

Natural mortality can take several alternative forms, including age-specific and or sex-specific. Further, natural mortality parameters, in common with growth parameters, can be time-varying or functions of environmental inputs. The most basic and simple form of natural mortality is:

\begin{equation}
\label{eqn4}
M_{\gamma, a} = \text{constant}
\end{equation}

where the natural mortality rate is constant across ages $a$ beginning at age 0 and equal for sexes $\gamma$.

### Additional Natural Mortality Functional Forms


## Initial Growth

Growth follows the von Bertalanffy function as re-formulated by **Schnute (1981)**, or by the Richards equation which has an option for a 3rd parameter to govern growth **(ADD REFERENCE)**. Growth is sex-specific. SS3 also allows for additional morphs with different growth patterns.

Mean size-at-age is calculated from growth parameters at the start of the initial year. The mean size-at-age of each morph is progressed forward according to the growth parameters active during that time period for subsequent seasons within that year and for subsequent years.

The sex-specific size-at-age in the initial population using the von Bertalanffy growth function is calculated as:

\begin{equation}
\label{eqn5}
L_{0,\gamma,a} = 
\begin{cases}
L_{\text{min bin}} + ba & \text{for $a \leq a_3$} \\
L_{\infty,\gamma} + (L_{1,\gamma} - L_{\infty,\gamma})e^{-k_{\gamma}(a-a_3)} & \text{for $a>a_3$ to $a=A-1$}\\
\end{cases}
\end{equation}

where $L_{\text{min bin}}$ is the lower limite of the first population bin, $b$ is the linear slope of growth for $a \leq a_3$ calculated as:

\begin{equation}
\label{eqn6}
b = \frac{L_{1,\gamma} - L_{\text{min bin}}}{a_3}
\end{equation}

$L_{0,\gamma, a}$ is the mean size at the start of the equilibrium year for animals of age $a$ and sex $\gamma$, $a_3$ (I) is a reference age near the youngest age well represented in the data, $L_{1,\gamma}$ (P) is the mean size
of sexs $\gamma$ at age $a_3$, $k_{\gamma}$ (P) is the growth coefficient for sex $\gamma$, and $L_{\infty,\gamma}$ is the mean asymptotic size, calculated from:

\begin{equation}
\label{eqn7}
L_{\infty,\gamma} = L_{1,\gamma} + \frac{L_{2,\gamma} - L_{1,\gamma}}{1 - e^{-k(a_4 - a_3)}}
\end{equation}

$a_4$ (I) is a reference age near the oldest age well represented in the data, and $L_{2,\gamma}$ (P) is the mean size of sex $\gamma$ at age $a_4$. An option allows $L_{2,\gamma}$ to be used directly as $L_{\infty,\gamma}$.

Growth within the plus-group in the initial year is accounted for by calculating an average length for the group by:

\begin{equation}
\label{eqn8}
L_{0,\gamma,A} = \frac{\sum_{a=A}^{2A}e^{-0.2(a-A)}(L_{0,\gamma}^{'}+(\frac{a-A}{A})(L_{\infty,\gamma} - L_{0,\gamma}^{'}))}{\sum_{a=A}^{2A}e^{-0.2(a-A)}} 
\end{equation}

where $L_{0,\gamma}^{'}$ is defined as the size at the plus-group age defined from the growth curve (Eqn. \ref{eqn5}) which is used to calculate the potential growth in the plus-group beyond the maximum age set within the model.

Equation \ref{eqn8} would logically use natural mortality as the decay factor. However, growth is calculated before natural mortality (to allow for size-specific natural mortality), so a fixed decay constant of 0.2 is used. Also, A should be large enough such that growth within the plus-group is small.

## Growth

The mean size-at-age for the von Bertanlaffy growth curve by sex at the start of each season for each growth morph is incremented across years as:

\begin{equation}
\label{eqn9}
L_{y+1,\gamma,a} = L_{y,\gamma,a} + (L_{y,\gamma,a-k} - L_{\infty,\gamma}) (e^{-k_{\gamma}} - 1) \;\ \text{for $a<A$}
\end{equation}

where $k_{\gamma}$ (P) is the growth coeffient for sex $\gamma$.

The mean size at the start of the season for the plus-group is calculated based on a weighted average of fish moving into the plus-group and existing plus-group fish. This approach allows for a decline in the mean size of fish in the plus-group over time as fishing mortality reduces the numbers in the plus-group. It also prevents an instantaneous change in size of plus-group fish when growth parameters are allowed to be time-varying.

\begin{equation}
\label{eqn10}
L_{y,t+1,\gamma,a} = \frac{N_{y,t,\gamma,A-1} \tilde{L}_{y,t,\gamma,A} (L_{y,t,\gamma,A} + (L_{y,t,\gamma,A} - L_{\infty,\gamma}) (e^{-k_{\gamma}} - 1))}{ N_{y,t,A-1} + N_{y,t,\gamma,A} } 
\end{equation}

DEFINE $t$. IS IT THE START OF A SEASON SINCE BELOW SEASON DURATION IS $\delta_s$?

Note that size in the plus-group from Equation \ref{eqn10} will differ slightly from size in the plus-group in the initial year from Equation \ref{eqn8} if fish are still growing appreciably when they reach age $A$ and if the mortality factor of 0.2, in Equation \ref{eqn8} is not close to the mortality rate in the appliation. 

Fish of each sex grow according to their current size and current year’s $k$ and $L_{\infty}$. This cohort-specific growth propagates into forecasts. Fish are not allowed to shrink if $L_{\infty}$ declines. Provision exists for cohort-specific $k$ deviations in addition to time-varying $k$, $L_{\infty}$, and $L_1$. Another option allows for age-specific $k$ for a user-specified number of younger ages.

The mean size in the middle of the season is calculated from the size at the start of the season as:

\begin{equation}
\label{eqn11}
\tilde{L}_{y,t,\gamma,a} = L{y,t,\gamma,a} + (L_{y,t,\gamma,a} - L_{\infty,\gamma})(e^{-0.5\delta_{s}k_{\gamma}} - 1)
\end{equation}

where $\delta_s$ (I) is the duration of the season.

### Additional Growth Functional Forms


## Variation in Size-at-Age

Variation in size can be a function of age or mean length-at-age, with the option of either having the parameters for each sex expressed in terms of the coefficient of variation or the standard deviation. For example, the standard deviation of length-at-age for each sex $\gamma$ when the coefficient of variation in length changes linearly with size-at-age between parameters specified for ages $a_3$ and $a_4$ for each sex $\gamma$ is given by:

\begin{equation}
\label{eqn12}
\sigma_{\gamma, a} = 
\begin{cases}
\tilde{L}_{\gamma,a}CV_{1,\gamma} \;\ \text{for $a \leq a_3$} \\
\tilde{L}_{\gamma,a}\biggl(CV_{1,\gamma} + \frac{\tilde{L}_{\gamma,a} - L_{1,\gamma}}{L_{2,\gamma} - L_{1,\gamma}}(CV_{2,\gamma} - CV_{1,\gamma})\biggr) \;\ \text{for $a_3 < a < a_4$}\\
\tilde{L}_{\gamma,a}CV_{2,\gamma} \;\ \text{for $a \geq a_4$} \\
\end{cases}
\end{equation}

where $CV_{1,\gamma}$ (P) is the coefficient of variation for length for sex $\gamma$ at age $a_3$ , and $CV_{2,\gamma}$ (P) is the coefficient of variation for length for sex $\gamma$ at age $a_4$.

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

