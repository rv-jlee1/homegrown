# 20.3.5 (1-4)
# 1)
# is.finite(x) only considers numeric values to be finite. Other values are considered infinite
# is.infinite(x) only consdiers Inf and -Inf to be infinite and NaN to not be unlike is.finite(x)

# 2)
?dplyr::near
# compare two vectors of floating numbers, built in tolerance for comparing floating numbers

# 3)
# integer vector uses a 32 bit so any thing within 2^32 will work
# double vector uses 64 bit so 2^64

# 4)
# Round up if greater than equal .5
# Round down if less than .5
# floor everything
# ceiling everything

# 20.4.6 (1-6)
# 1) mean(is.na(x)) tells me the proportion of na in a given vector
# sum(!is.infinite(x)) tells me the number of elements in a vector that are finite

# 2)
?is.vector
# is.vector returns true if it has no other attributes than names
?is.atomic
# is.atomic returns true if x is atomic (or null). It doesn't care if there are other attributes

# 3) purrr:set_names() gives more flexibility than setNames(). You can create the same thing with set_names() but can apply a function to the values

# 4-1)
peek <- function(x) {
  x[[length(x)]]
}
# 4-2)
evenVal <- function(x) {
  for (i in 1:length(x)) {
    if (i %% 2 == 0) {
      print(x[i])
    }
  }
}
evenVal(1:10)
# 4-3)
allButLast <- function(x) {
  for (i in 1:(length(x) -1)) {
    print(x[i])
  }
}
allButLast(1:3)
# 4-4)
evenNum <- function(x) {
  x[x%%2==0]
}
evenNum(2:8)

# 5) Missing values are treated differently by the two functions

# 6) Subsetting with positive int bigger than vector will just fill with empty values. 
# Similarly subsetting with a name that doesn't exist gets fill with NA

# 20.5.4 (1-2)
# 1) Not sure how to draw diagrams through RStudio but hand drawn it
# 2) Subsetting works similarly in both tibble and list. Only difference is tibble needs to col = row.

# 21.2.1 (1-4)
# 1)
for (i in names(mtcars)) {
  print(mean(mtcars[[i]]))
}

# 2)
for (i in names(flights)) {
  print(class(flights[[i]]))
}

# 3)
for (i in names(iris)) {
  print(length(unique(iris[[i]])))
}

# 4)
mu <- c(-10, 0, 10, 100)
for (i in 1:4) {
  print(rnorm(10, mean = mu[[i]]))
}

# 21.3.5 (1-3)
# 1)
df <- vector("list", length(files))
for (fname in seq_along(files)) {
  df[[i]] <- read_csv(files[[i]])
}
df <- bind_rows(df)

# 2)
# if there are no names then no code is run
# if there are some then it will return an error when it hits an unknown name
# if there are multiple then the first one will be returned

# 3)
show_mean <- function(df) {
  for (n in names(df)) {
    print(mean(df[[n]]))
    print(n)
  }
}
show_mean(iris)

# 21.5.3
# 1)
purrr::map_dbl(mtcars, mean)

# 2)
purrr::map_chr(nycflights13::flights, typeof)

# 3)
purrr::map_int(iris, function(x) length(unique(x)))

# 4)
purrr::map(c(-10, 0, 10, 100), ~ rnorm(n = 10, mean = .))
