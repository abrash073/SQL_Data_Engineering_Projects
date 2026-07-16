-- duckdb dw_marts.duckdb -c ".read build_mart_dw.sql"
--- create schema tables
.read create_tables_dw.sql

--- load data from csv files into tables
.read load_schema_dw.sql