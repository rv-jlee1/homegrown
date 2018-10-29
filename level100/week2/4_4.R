# 4.1
my_variable <- 10
my_varıable
#> Error in eval(expr, envir, enclos): object 'my_varıable' not found
# This errors because the "i" in the variable is different in the second

# 4.2
install.packages("tidyverse", dependencies=TRUE)
library(tidyverse)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl = 8)
filter(diamonds, carat > 3)
# Had to install dependencies for tidyverse, correct filter spelling, and adding s to diamonds

# 4.3
# alt + shift + k bring up a list of shortcuts