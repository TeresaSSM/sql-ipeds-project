# UC Enrollment Analysis (SQL Portfolio Project)

A SQL portfolio project analyzing enrollment and demographic data across
University of California campuses, using IPEDS (Integrated Postsecondary Education Data System) 2024 data. Built to
demonstrate core and intermediate SQL skills.

## Project Structure

| File | Description |
|---|---|
| `Prepare-data-for-SQL.r` | Cleans and reshapes raw IPEDS data in R ahead of import |
| `Make-db-schema.sql` | Creates the database schema (tables and relationships) |
| `Import-into-schema.r` | Loads prepared data into the SQL database |
| `IPEDS-queries.sql` | `IPEDS-queries.sql` is organized into 8 queries|
| `institutions.csv` | Institution-level reference data |
| `enrollment.csv` | Total, undergraduate, and graduate enrollment by campus |
| `demographics.csv` | Undergraduate demographic composition by campus |

## Analysis Pipeline

1. Raw IPEDS CSV was cleaned and reshaped into 3 CSVs in R (`Prepare-data-for-SQL.r`)
2. Schema was created (`Make-db-schema.sql`)
3. Data was loaded into pgAdmin 4 (`Import-into-schema.r`) 
4. Analysis queries were run (`IPEDS-queries.sql`).

## Related Work

I have also conducted a broader R-based enrollment benchmarking analysis:
[ucsd-ipeds-benchmarking](https://github.com/TeresaSSM/ucsd-ipeds-benchmarking)

## Author

Teresa McCarrell
