## 5.3.1
library(nycflights13)
library(tidyverse)

# 1 How could you use arrange() to sort all missing values to the start?
arrange(flights, desc(is.na(flights$dep_time)), desc(is.na(flights$dep_delay)), desc(is.na(flights$arr_time)))
# continue through all 19 columns but I see no point in doing that so....

# 2 Sort flights to find the most delayed flights. Find the flights that left earliest.
arrange(flights, desc(flights$dep_delay), desc(flights$arr_delay))
arrange(flights, flights$dep_time)

# 3 Sort flights to find the fastest flights.
arrange(flights, flights$air_time)

# 4 Which flights travelled the longest? Which travelled the shortest?
arrange(flights, flights$distance)
arrange(flights, desc(flights$distance))