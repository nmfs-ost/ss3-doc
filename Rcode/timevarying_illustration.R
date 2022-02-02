# code to create doc/images/TimeVarying.png
# describe this as example time varying setups

library(ggplot2) # to create the plots
library(patchwork) # to put together ggplots

# Deviations
set.seed(123)
base <- 0.5
devs_dat <- data.frame(year = 1:30,
                       devs = rnorm(30, sd = 0.1)+base)
dev_plot <- ggplot(data = devs_dat, aes(x = year, y = devs))+
  geom_point()+
  geom_hline(yintercept = base)+
  geom_linerange(ymin = base, ymax = devs_dat$devs)+
  ylab("base = 0.5")+
  xlab("Year") +
  ggtitle("Deviations")+ # add num of params to this? 
  theme_classic()

# Random Walk ----
base <- 0.5
#TODO: check this sampling is as intended
rw_samples <- 0.5+arima.sim(model= list(order = c(0, 1, 0)), n=30, sd = 0.1)
rw_df <- data.frame(year = 1:30, 
                    rw = rw_samples[-1])
random_walk_plot <- ggplot(data = rw_df, aes(x = year, y = rw)) +
  geom_line()+
  geom_point()+
  ggtitle("Random walk")+
  xlab("Year")+
  ylab("base = 0.5")+
  theme_classic()

# Blocks ----

base <- 3
block_vec <- c(rep(base, length.out = 10), 
               rep(base + 1, length.out = 3), 
               rep(base - 1, length.out = 5 ), 
               rep(base, length.out = 30-18))
block_df <- data.frame(year = 1:30, 
                       block = block_vec)

blocks_plot <- ggplot(data = block_df, aes(x = year, y = block)) +
  geom_point()+
  ggtitle("Time Blocks")+
  xlab("Year")+
  ylab("base = 3")+
  ylim(0, base+2)+
  theme_classic()


# Trend ----
# use Ian's code to construct the trend.
# set up some values
baseparm <- 0
endtrend <- 1
styr <- 1980
infl_year <- 2005
endyr <- 2020
YrMax <- 2025
slope  <- 5
yrs <- 1980:YrMax
# empty vector to store results
parm_timevary <- NA * yrs

# calculations below adapted from
# https://github.com/nmfs-stock-synthesis/stock-synthesis/blob/cf0ce2f2f6e0e5e3e6a11805f1a9668f3449e916/SS_timevaryparm.tpl#L166-L177

norm_styr <- pnorm(styr -infl_year)/slope
temp <- (endtrend - baseparm) / (pnorm((endyr - infl_year) / slope) - norm_styr) # delta in cum_norm between styr and endyr

for (iyr in 1:length(yrs))
{
  y1 <- yrs[iyr]
  if(y1<=endyr)
  {
    parm_timevary[iyr] <- baseparm + temp * (pnorm((y1 - infl_year) / slope) - norm_styr)
  }
  else
  {
    parm_timevary[iyr] <- parm_timevary[which(yrs == endyr)]
  }
}

trend_df <- data.frame(Year = yrs,
                       Parameter = parm_timevary)

trend_plot <- ggplot(trend_df, aes(x = Year, y = Parameter)) +
  geom_line() +
  geom_point()+
  geom_vline(xintercept = infl_year + c(0, slope, -slope), color = "blue")+
  annotate("text", label = "width", x = 2002.5, y = 0.1, size = 4, color = "blue")+
  annotate("segment", x = 2000, xend = 2005, y = 0.05, yend = 0.05,
           color = "blue") +
  annotate("text", label = "Inflection Point", x = 2018, y = 0.30, size = 4, 
           color = "blue")+
  annotate("segment", x = 2005, xend = 2012, y = 0.5, yend = 0.29,
           color = "blue") +
  ggtitle("Trend (uses normal cumulative probablity distribution)")+
  theme_classic()

# Environmental Link ----
#some pdo in January values just to get a realistic environmental time series.
pdo <- c(0.06, 1.18, 0.11, 0.4, 1.42, 0.87, 1.04, 1.47, 0.23, -1.24, -0.42,
         -1.8, 0.08, -0.28, 0.85, -0.86, 1.01, 0.44, 1.05, -0.78, -2.2, 0.48,
         -0.42, 1.45, -0.55, -0.15, 0.54, -0.69,  -1.5, -1.81)
# normalize (z score so mean is 0 and sd is 1)
pdo <- (pdo - mean(pdo))/sd(pdo)
par_val <- 5
add_pdo <- 5 + 0.3*pdo

pdo_df <- data.frame(Year = 1:30,
                     env_var = pdo,
                     param_base = par_val, 
                     param_value = add_pdo)
pdo_long <- tidyr::gather(pdo_df, "Timeseries", "Value", 2:4)
pdo_long$Timeseries <- factor(pdo_long$Timeseries, levels = c("env_var", "param_base", "param_value"), labels = c("Env. Var", "Param. Base", "Param. Value"))

env_plot <- ggplot(pdo_long, aes(x = Year, y = Value)) +
  geom_line(aes(linetype = Timeseries)) +
  ggtitle("Environmental Link (E.g., Additive)") +
  theme_classic()

# stitch together plots ---
tv_plot <- (dev_plot + blocks_plot)/(random_walk_plot + trend_plot)/ env_plot +
  plot_annotation(
    title = "Time-varying parameter options"
  )

ggsave("images/TimeVarying.png", width = 12, height = 8, units = "in")
