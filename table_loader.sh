#!/bin/bash

echo \\\\ "START TIME:$(date)" >> ~/Documents/Projects/Datascience-Projects/Datascience-Projects/table_loader.logs

# Create a file to contain the data without password
touch ~/Documents/Projects/online_retail_without_password.csv

# Save a subset of the data without password field.
csvcut -c 1-12,14 ~/Documents/Projects/Online_Retail_with_fake_data.csv > ~/Documents/Projects/online_retail_without_password.csv
echo "password removed successfully" >> ~/Documents/Projects/Datascience-Projects/Datascience-Projects/table_loader.logs

# Create the tables from the reverse engineered sql script
psql -h 127.0.0.1 -p 5432 -U postgres -d retailDB -a -f ~/Documents/Projects/Datascience-Projects/Datascience-Projects/forward_engineered_table_creation_script.sql >> ~/Documents/Projects/Datascience-Projects/Datascience-Projects/table_loader.logs

# Load the retail staging table with the raw data
psql -h 127.0.0.1 -p 5432 -U postgres -d retailDB -c "\COPY public.retail_staging FROM ~/Documents/Projects/online_retail_without_password.csv WITH CSV HEADER DELIMITER ','" >> ~/Documents/Projects/Datascience-Projects/Datascience-Projects/table_loader.logs

# Extract data from the staging table and load into the final tables.
psql -h 127.0.0.1 -p 5432 -U postgres -d retailDB -a -f ~/Documents/Projects/Datascience-Projects/Datascience-Projects/table_loading_scripts.sql >> ~/Documents/Projects/Datascience-Projects/Datascience-Projects/table_loader.logs

echo "SCIPT ENDS:$(date)" >> ~/Documents/Projects/Datascience-Projects/Datascience-Projects/table_loader.logs