# County level Beginning Farmers and Ranchers Data (plus young!)

# NASS API for their Quickstats web interface:
# https://quickstats.nass.usda.gov/

devtools::install_github("rdinter/rnass")
library(rnass)
library(tidyverse)
source("0-data/0-api_keys.R")

# Create a directory for the data
local_dir    <- "0-data/NASS/BFR"
data_source <- paste0(local_dir, "/raw")
if (!file.exists(local_dir)) dir.create(local_dir)
if (!file.exists(data_source)) dir.create(data_source)

# Find all of the available data items for number of principal operators at
#  the county level
exp_params  <- nass_param(param = "short_desc", agg_level_desc = "COUNTY",
                          commodity_desc = "OPERATORS, PRINCIPAL",
                          statisticcat_desc = "OPERATORS",
                          token = api_nass_key)

# Download their data
experience_data <- map(exp_params$unlist.tt., function(x) {
  temp <- nass_data(short_desc = x,
                    agg_level_desc = "COUNTY",
                    commodity_desc = "OPERATORS, PRINCIPAL",
                    statisticcat_desc = "OPERATORS",
                    token = api_nass_key)
  return(temp)
})

exp_data <- experience_data %>% 
  bind_rows() %>% 
  mutate(year = parse_number(year),
         fips = 1000*parse_number(state_ansi) + parse_number(county_code)) %>% 
  select(year, val = Value, short_desc, fips, county_name, state_name) %>% 
  spread(short_desc, val)

write_csv(exp_data, "county_level_operators.csv")