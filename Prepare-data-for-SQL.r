library(tidyverse)
library(janitor)

ipeds <- read_csv("C:/Users/teres/Desktop/Data work/IPEDS report/CSV_6132026-557.csv", show_col_types = FALSE) |>
  clean_names()

#################################################
# Institutions
#################################################

institutions <-
  ipeds %>%
  transmute(unitid, institution_name, year)

#################################################
# Enrollment
#################################################

enrollment <-
  ipeds %>%
  mutate(unitid, total_enrollment = drvef2024_total_enrollment, fte_enrollment = drvef2024_full_time_equivalent_fall_enrollment,

    full_time_enrollment = drvef2024_full_time_enrollment, part_time_enrollment = drvef2024_part_time_enrollment,

    undergraduate_enrollment = drvef2024_undergraduate_enrollment,

    first_time_undergraduate = drvef2024_first_time_degree_certificate_seeking_undergraduate_enrollment,

    transfer_undergraduate = drvef2024_transfer_in_degree_certificate_seeking_undergraduate_enrollment,

    continuing_undergraduate =
      drvef2024_continuing_degree_certificate_seeking_undergraduate_enrollment,

    nondegree_undergraduate =
      drvef2024_nondegree_certificate_seeking_undergraduate_enrollment,

    full_time_undergraduate =
      drvef2024_full_time_undergraduate_enrollment,

    part_time_undergraduate =
      drvef2024_part_time_undergraduate_enrollment,

    graduate_enrollment =
      drvef2024_graduate_enrollment,

    full_time_graduate =
      drvef2024_full_time_graduate_enrollment,

    part_time_graduate =
      drvef2024_part_time_graduate_enrollment
  )

#################################################
# Demographics
#################################################

demographics <-
  ipeds %>%
  mutate(

    unitid,

    ug_white_pct =
      drvef2024_percent_of_undergraduate_enrollment_that_are_white,

    ug_black_pct =
      drvef2024_percent_of_undergraduate_enrollment_that_are_black_or_african_american,

    ug_hispanic_pct =
      drvef2024_percent_of_undergraduate_enrollment_that_are_hispanic_latino,

    ug_asian_pct =
      drvef2024_percent_of_undergraduate_enrollment_that_are_asian,

    ug_nhpi_pct =
      drvef2024_percent_of_undergraduate_enrollment_that_are_native_hawaiian_or_other_pacific_islander,

    ug_aian_pct =
      drvef2024_percent_of_undergraduate_enrollment_that_are_american_indian_or_alaska_native,

    ug_two_or_more_pct =
      drvef2024_percent_of_undergraduate_enrollment_that_are_two_or_more_races,

    ug_unknown_pct =
      drvef2024_percent_of_undergraduate_enrollment_that_are_race_ethnicity_unknown,

    ug_nonresident_pct =
      drvef2024_percent_of_undergraduate_enrollment_that_are_u_s_nonresident,

    ug_women_pct =
      drvef2024_percent_of_undergraduate_enrollment_that_are_women,

    grad_white_pct =
      drvef2024_percent_of_graduate_enrollment_that_are_white,

    grad_black_pct =
      drvef2024_percent_of_graduate_enrollment_that_are_black_or_african_american,

    grad_hispanic_pct =
      drvef2024_percent_of_graduate_enrollment_that_are_hispanic_latino,

    grad_asian_pct =
      drvef2024_percent_of_graduate_enrollment_that_are_asian,

    grad_nhpi_pct =
      drvef2024_percent_of_graduate_enrollment_that_are_native_hawaiian_or_other_pacific_islander,

    grad_aian_pct =
      drvef2024_percent_of_graduate_enrollment_that_are_american_indian_or_alaska_native,

    grad_two_or_more_pct =
      drvef2024_percent_of_graduate_enrollment_that_are_two_or_more_races,

    grad_unknown_pct =
      drvef2024_percent_of_graduate_enrollment_that_are_race_ethnicity_unknown,

    grad_nonresident_pct =
      drvef2024_percent_of_graduate_enrollment_that_are_u_s_nonresident,

    grad_women_pct =
      drvef2024_percent_of_graduate_enrollment_that_are_women
  )

#################################################
# Export
#################################################


write_csv(institutions, "C:/Users/teres/Desktop/Data work/SQL project/institutions.csv", na = "")
write_csv(enrollment, "C:/Users/teres/Desktop/Data work/SQL project/enrollment.csv", na = "")
write_csv(demographics, "C:/Users/teres/Desktop/Data work/SQL project/demographics.csv", na = "")


