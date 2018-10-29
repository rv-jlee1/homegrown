## 5.4.1
library(nycflights13)
library(tidyverse)

# 1 Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.
select(flights, dep_time, dep_delay, arr_time, arr_delay)

# 2 What happens if you include the name of a variable multiple times in a select() call?
select(flights, dep_time, dep_time)
select(flights, dep_time)
# It will only show the data once
  
# 3 What does the one_of() function do? Why might it be helpful in conjunction with this vector?
# vars <- c("year", "month", "day", "dep_delay", "arr_delay")
# one_of() is useful when you don't know if a certain data name is available. It won't cause the program to crash when it tries to find an value that doesn't exist
# It can be useful with this vector if we didn't know that all 5 values existed or not in the data set

# 4 Does the result of running the following code surprise you? How do the select helpers deal with case by default? How can you change that default?
select(flights, contains("TIME"))
# It returns any columns where the word time exists. It doesn't surprise it. You could chain multiple selects from the result to narrow it down further if you wish
select(select(flights, contains("TIME")), starts_with("dep"))
