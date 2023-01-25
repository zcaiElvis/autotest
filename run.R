library(tidyverse)


### Creating new folders ###
current_time <- Sys.time()
output_folder <- paste0("log/", current_time)
dir.create(output_folder)


### Source the config file ###
source("config/exp1.R")


### Loop through all configs
output <- list()

for (i in 1:length(data)) {
  for (j in 1:length(params)) {
    
    ### Combine arguments ###
    args <- c(unlist(data[i], recursive = FALSE), unlist(params[j], recursive = FALSE))
    print(args)
    ### Run code ###
    result <- do.call(fun, args=args)
    output <- append(output, result)
    ### Save case output ###
    png(filename=paste0("log/", current_time, "/img_", i, j, ".png"), width=900, height=450)
    plot(summary(result))
    dev.off()
    ### Save data ####
    saveRDS(result, file = paste0("log/", current_time, "/", i, j, ".rds"))

  }
}

