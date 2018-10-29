## 5.2.4
library(nycflights13)
library(tidyverse)

# 1.1 Had an arrival delay of two or more hours
filter(flights, flights$arr_delay >= 2)
# 1.2 Flew to Houston (IAH or HOU)
filter(flights, flights$dest %in% c("HOU", "IAH"))
# 1.3 Were operated by United, American, or Delta
filter(flights, flights$carrier %in% c("UA", "AA", "DL"))
# 1.4 Departed in summer (July, Aug, Sept)
filter(flights, flights$month %in% c(7,8,9))
# 1.5 Arrived more than 2 hours late but left on time
filter(flights, flights$dep_delay <= 0, flights$arr_delay >= 120)
# 1.6 Were delayed by at least 1 hour but made up 30 mins
filter(flights, flights$dep_delay >= 60, flights$arr_delay <= -30)
# 1.7 departed between midnight and 6am includsive
filter(flights, flights$dep_time >= 0, flights$dep_time <= 600)
