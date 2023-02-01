library(dplyr)
library(zoo)

### Specify Function to run
fun <- cv_estimate_rt

### Handle owid data
owid_trans <- function(owid) {
  owid <- owid %>%
    filter(location == "Canada") %>%
    select(new_cases)
  owid
}

### Options

# Reload data
reload <- FALSE
# Generate plot for summary
gen_plot <- FALSE

### Load Dataset ###
if (reload) {
  ### Canadian Covid Data
  data_canada <- read.csv("data/owid_covid_Sep5.csv")
  data_canada <- owid_trans(data_canada)
  data_canada <- na.fill(data_canada, "extend")
  data_canada <- list(observed_counts = data_canada[,1])

  ### Toy data
  data_short <- list(observed_counts = c(1:10))

  data_short_pad <- list(observed_counts = c(rep(0, 5), 1:10))

  ### Synthetic data
  data_d2 <- list(observed_counts = read.csv("data/syn_d2.csv")$y)

  ### Canadian Mpox Data
  data_mpox <- read.csv("data/owid-monkeypox-data.csv")
  data_mpox <- owid_trans(data_mpox)
  data_mpox <- list(observed_counts = data_mpox[,1])
}

data <- list(data_short)

### Set parameters

# Multiple Lambda
p4 <- list(dist_gamma = c(2.5, 2.5),
           degree = 2,
           lambda = c(1:20),
           fold = 3)

params <- list(p4)
