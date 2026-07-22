-- duckdb dw_marts.duckdb -c ".read build_mart_dw.sql"
--- create schema tables
.read create_tables_dw.sql

--- load data from csv files into tables
.read load_schema_dw.sql

-- create flat mart
.read create_flat_mart.sql

-- create skills demand mart
.read create_skills_mart.sql

-- create priority mart
.read create_priority_mart.sql

-- update priority mart
.read update_priority_mart.sql
