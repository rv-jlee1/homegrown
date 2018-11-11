library(nycflights13)
library(dplyr)
at <- flights$air_time
aat <- flights$arr_time - flights$dep_time
at == aat

# 5.5.2

# 1) 
# Currently dep_time and sched_dep_time are convenient to look at, but hard to compute with because they’re not really continuous numbers. 
# Convert them to a more convenient representation of number of minutes since midnight.
convertTime <- function(mTime) {
  # Divide number by 100 to get the number of hours
  hours <- mTime %/% 100
  # multiply hours by 60 to convert hours to minutes
  mins <- hours * 60
  # now add the min to the hours using modulo
  mins <- mins + (mTime %% 100)
  return(mins)
}
convertedFlights <- mutate(flights, convertTime(flights$dep_time), convertTime(flights$sched_dep_time))

# 2) 
# Compare air_time with arr_time - dep_time. 
# What do you expect to see?
# I expect the air_time to be the same as the difference between arr_time and dep_time

# What do you see?
# I see that for most of the values that air_time the difference between arr_time and dep_time is different

# What do you need to do to fix it?
# To fix this, I would need to dive deeper into the data to find the discrepencies. 
# It looks like the arr_time and dep_time are displaying the time in the time zone of their respective city and 
# when the flights go across midnight then the values are also changed. I would need to account for these changes.

# 3
# Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?
# I would expect that dep_time to equal schedu_dep_time - dep_delay.

# 4
# Find the 10 most delayed flights using a ranking function. How do you want to handle ties? 
# Carefully read the documentation for min_rank().
?min_rank
delayCol <- mutate(flights, delayRank = min_rank(flights$dep_delay))
fList <- filter(delayCol, delayRank <= 10)
ordList <- arrange(fList, delayRank)
res <- ordList %>% slice(1:10)
res

# 5
# What does 1:3 + 1:10 return? Why?
1:3 + 1:10 # Warning
1:3 + 1:12 # No warning
# It returns a object of length 10 that does the addition of 1-3 + 1-10. Once 1-3 is finished it'll repeat until it reaches 10 iterations.
# ALso receive a warning saying that the length of 10 is not a multiple of 3

# 5.6.7 (2-6)
# 2)
# Come up with another approach that will give you the same output as 
# not_cancelled %>% count(dest) and not_cancelled %>% count(tailnum, wt = distance) 
# (without using count()).
not_canceled <- flights %>% filter(!is.na(dep_delay), !is.na(arr_delay))
not_canceled

not_canceled %>% group_by(dest) %>% tally()
not_canceled %>% count(dest)
?count
not_canceled %>% group_by(tailnum) %>% tally(distance)
not_canceled %>% count(tailnum, wt = distance)

# 3)
# Our definition of cancelled flights (is.na(dep_delay) | is.na(arr_delay) ) is slightly suboptimal. 
# Why? Which is the most important column?
# If a flight is never departed then it will never arrive. Therefore we only need to check if dep_delay is.na

# 4)
# Look at the number of cancelled flights per day. Is there a pattern? 
# Is the proportion of cancelled flights related to the average delay?
flights %>% mutate(canceled = (is.na(dep_delay))) %>% group_by(year, month, day) %>% summarise(avg_canceled = mean(canceled, na.rm = TRUE), avg_dep_delay = mean(dep_delay, na.rm = TRUE))
# I believe the more dep delay on a particular day will increase the chance of more canceled flights

# 5) Which carrier has the worst delays?
flights %>% group_by(carrier) %>% summarise(avg_delay = mean(arr_delay, na.rm = TRUE)) %>% arrange(desc(avg_delay))
# carrier F9 has the worst average delays

# 6) What does the sort argument to count() do. When might you use it?
?count
# The sort argument will order the count in descending order. 

# 5.7.1 (1-8)
# 1)
# Refer back to the lists of useful mutate and filtering functions. 
# Describe how each operation changes when you combine it with grouping.
# When the mutate and filtering functions are used with grouping then it will apply the logic to the group instead of individual points

# 2)
# Which plane (tailnum) has the worst on-time record?
flights %>% group_by(tailnum) %>% summarize(avg_delay = mean(arr_delay, na.rm = TRUE), flights = n()) %>% filter(min_rank(desc(avg_delay)) <= 1)
# Tailnum N844MH has the worst average delay at 320

# 3)
# What time of day should you fly if you want to avoid delays as much as possible?
flights %>% group_by(hour) %>% summarize(avg_delay = mean(arr_delay, na.rm = TRUE)) %>% arrange(avg_delay)
# The data indicates that it might be better to fly earlier in the day if you want to avoid delays as much as possible

# 4)
# For each destination, compute the total minutes of delay.
# For each flight, compute the proportion of the total delay for its destination.
flights %>% filter(!is.na(arr_delay), arr_delay >= 0) %>% group_by(dest) %>% transmute(sum_arr_delay = sum(arr_delay), avg_arr_delay = arr_delay / sum_arr_delay)

# 5)
# Delays are typically temporally correlated: even once the problem that caused the initial delay has been resolved, 
# later flights are delayed to allow earlier flights to leave. 
# Using lag(), explore how the delay of a flight is related to the delay of the immediately preceding flight.
flights %>% group_by(origin) %>% arrange(year, month, day, dep_time) %>% mutate(lag_dep_delay = lag(dep_delay)) %>% filter(!is.na(dep_delay), !is.na(lag_dep_delay))

# 6)
# Suspciously fast flights
flights %>% group_by(dest) %>% arrange(air_time)

# 7) Find all destinations that are flown by at least two carriers.
flights %>% group_by(dest) %>% filter(n_distinct(carrier) > 2) %>% group_by(carrier) %>% summarise(avg_delay = mean(dep_delay, na.rm = TRUE)) %>% arrange(avg_delay)

# 8) For each plane, count the number of flights before the first delay of greater than 1 hour.
flights %>% arrange(tailnum, year, month, day) %>% group_by(tailnum) %>% mutate(del_one_hr = dep_delay > 60) %>% mutate(num_predelay = cumsum(del_one_hr)) %>% filter(num_predelay == 0) %>% count()

# 19.3.1 (1-4)
# 1)
# f1 -> has_prefix
# f2 -> pop
# f3 -> repeat_char

# 2) Better name for function and arguments
# sum <- function(x, y)

# 3) Compare and contrast rnorm() and MASS::mvrnorm(). How could you make them more consistent?
?rnorm
?MASS::mvrnorm
# rnorm is univariate and mvrnorm is multivariate. So set mvrnorms arguments the same as rnorm

# 4) Make a case for why norm_r(), norm_d() etc would be better than rnorm(), dnorm(). Make a case for the opposite.
# The first set organizes functions by a broader functionality. The latter organizes by the specifics first

# 19.4.4 (1-6)
# 1) 
?ifelse
# If tests a single condition whereas ifelse checks all components and returns a vector

# 2)
greeter <- function(t = lubridate::now()) {
  h <- lubridate::hour(t)
  if (h < 12) {
    print("Good morning")
  } else if (h < 18) { 
    print("Good afternoon")
  } else {
    print("Good evening")
  }
}
greeter()

# 3)
fizzbuzz <- function(n) {
  if (!(n %% 3) & !(n %% 5)) {
    print("fizzbuzz")
  } else if (!(n %% 5)) {
    print("buzz")
  } else if (!(n %% 3)) {
    print("fizz")
  } else {
    print(n)
  }
}
fizzbuzz(15)
fizzbuzz(5)
fizzbuzz(3)
fizzbuzz(2)

# 4) cut example
?cut
v <- c(-1, 22, 44, 2, 33, 11)
cut(v, c(-Inf, 0, 10 , 20 , 30, Inf), labels = c("freezing", "cold", "cool", "warm", "hot"), right = TRUE)
# If I wanted to change the closing then I'd use right = FALSE. Advantage is that there is much less code space required which means less chance for bugs

# 5) What happens if you use switch() with numeric values?
?switch
# If a number is used then it will select the nth value from the list

# 6) Switch
# switch statement will fall through code until it finds a value that it can return. If we input 'e' into this example then it will return null.

