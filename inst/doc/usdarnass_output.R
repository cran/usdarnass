## ----setup, include = FALSE----------------------------------------------
library("knitr")
opts_chunk$set(
  collapse = TRUE,
  eval = !(Sys.getenv("NASS_KEY") == ""),
  comment = "#>"
)

## ----start, warning=FALSE, message=FALSE---------------------------------
library("usdarnass")
library("dplyr") # Helpful package

ohio_rent <- nass_data(commodity_desc = "RENT", agg_level_desc = "COUNTY",
                       state_name = "OHIO")
glimpse(ohio_rent)

## ----rent_nass_param-----------------------------------------------------
nass_param("short_desc", commodity_desc = "RENT", agg_level_desc = "COUNTY", state_name = "OHIO")

## ----rent_nass_param_alt-------------------------------------------------
table(ohio_rent$short_desc)

## ----non_irrigated-------------------------------------------------------
non_irrigated <- ohio_rent %>% 
  filter(grepl("NON-IRRIGATED", short_desc))
table(non_irrigated$year) # Observation per year

## ----counties------------------------------------------------------------
table(non_irrigated$county_name)
# nass_param("county_name", state_name = "OHIO")

## ----asd-----------------------------------------------------------------
non_irrigated %>%
  filter(county_name == "OTHER (COMBINED) COUNTIES") %>%
  pull(asd_code) %>%
  table()

## ----ag_census-----------------------------------------------------------
farms <- nass_data(source_desc = "CENSUS", year = 2012, state_name = "OHIO", agg_level_desc = "COUNTY", domain_desc = "TOTAL", short_desc = "FARM OPERATIONS - NUMBER OF OPERATIONS")

## ----combined------------------------------------------------------------
library("tidyr")
base_rent <- farms %>% 
  select(state_fips_code, county_code, county_name, asd_code, asd_desc) %>% 
  expand(year = unique(non_irrigated$year), nesting(state_fips_code, county_code, county_name, asd_code)) %>% 
  full_join(non_irrigated)

# Correct for missing values in the "other"
base_rent <- base_rent %>% 
  arrange(year, asd_code, county_code) %>% 
  group_by(year, asd_code) %>% 
  mutate(Value = ifelse(is.na(Value), Value[county_code == "998"], Value)) %>% 
  filter(county_code != "998")

# Finally, select only the relevant variables are rename
base_rent <- base_rent %>% 
  select(year, state_fips_code, county_code, county_name, asd_code, rent = Value) %>% 
  mutate(rent = as.numeric(rent),
         fips = as.numeric(paste0(state_fips_code, county_code)))

glimpse(base_rent)

