library(DBI)
library(RPostgres)
library(tidyverse)

# Connect to PostgreSQL
con <- dbConnect(
  RPostgres::Postgres(),
  dbname = "IPEDS SQL Portfolio Project",
  host = "localhost",
  port = 5432,
  user = "postgres",
  password = "Teresa"
)


# File location
folder <- "C:/Users/teres/Desktop/Data work/SQL project"


# Read CSVs
institutions <- read_csv(
  file.path(folder, "institutions.csv")
)

enrollment <- read_csv(
  file.path(folder, "enrollment.csv")
)

demographics <- read_csv(
  file.path(folder, "demographics.csv")
)

distance_learning <- read_csv(
  file.path(folder, "distance_learning.csv")
)


# Send data into PostgreSQL

dbWriteTable(
  con,
  "institutions",
  institutions,
  append = TRUE
)

dbWriteTable(
  con,
  "enrollment",
  enrollment,
  append = TRUE
)

dbWriteTable(
  con,
  "demographics",
  demographics,
  append = TRUE
)


# Close connection
dbDisconnect(con)
