library(tidyverse)


### Creating new folders ###
current_time <- Sys.time()
output_folder <- paste0("log/", current_time)
dir.create(output_folder)


### Source the config file ###
source("config/exp4.R")

### Loop through all configs
output <- list()

for (i in 1:length(data)) {
  for (j in 1:length(params)) {
    ### Combine arguments ###
    args <- c(unlist(data[i], recursive = FALSE), unlist(params[j], recursive = FALSE))
    ### Run code ###
    result <- do.call(fun, args=args)
    output <- append(output, result)
    ### Save case output ###
    if (gen_plot) {
      mod <- summary(result)
      png(filename=paste0("log/", current_time, "/img_", i, j, ".png"), width=1200, height=450)
      plot(mod)
      dev.off()
    }
    ### Save data ####
    saveRDS(result, file = paste0("log/", current_time, "/", i, j, ".rds"))
    writeLines(as.character(params[j]), 
               paste0("log/", current_time, "/params", i, j, ".txt"))
    writeLines(as.character(output), 
               paste0("log/", current_time, "/results", i, j, ".txt"))
  }
}

