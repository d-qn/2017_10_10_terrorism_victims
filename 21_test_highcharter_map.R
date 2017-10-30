library(highcharter)
library(dplyr)
library(purrr)

set.seed(1234)

n <- 20
z <-  sample(1:n)
sequences <- map2(1:n, z, function(x, y){ ifelse(x == 1:n, y, 0) })

df <- data_frame(
  lat = runif(n, -180, 180),
  lon = runif(n, -180, 180),
  z = z,
  color = colorize(z),
  sequence = sequences
)

hcmap() %>% 
  hc_add_series(data = df, type = "mapbubble",
                minSize = 0, maxSize = 30) %>% 
  hc_motion(enabled = TRUE, series = 1, labels = 1:n,
            loop = TRUE, autoPlay = TRUE, 
            updateInterval = 1000, magnet = list(step =  1)) %>% 
  hc_plotOptions(series = list(showInLegend = FALSE))