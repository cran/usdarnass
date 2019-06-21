## ----setup, include = FALSE----------------------------------------------
library("knitr")
opts_chunk$set(
  collapse = TRUE,
  eval = !(Sys.getenv("NASS_KEY") == ""),
  comment = "#>"
)

## ----installation_github, eval = FALSE-----------------------------------
#  # install.packages("devtools")
#  devtools::install_github("rdinter/usdarnass")

## ----load----------------------------------------------------------------
library("usdarnass")

## ----key-install, eval = FALSE-------------------------------------------
#  nass_set_key("YOUR_KEY_IN_QUOTATIONS")
#  # First time, reload your enviornment so you can use the key without restarting R.
#  readRenviron("~/.Renviron")
#  # You can check it with:
#  Sys.getenv("NASS_KEY")

## ----get_data------------------------------------------------------------
nass_data(year = 2012,
          short_desc = "AG LAND, INCL BUILDINGS - ASSET VALUE, MEASURED IN $",
          county_name = "WAKE",
          state_name = "NORTH CAROLINA")

## ----source--------------------------------------------------------------
nass_param("source_desc")

## ----ohio_group----------------------------------------------------------
nass_param("group_desc",
           state_name = "OHIO",
           agg_level_desc = "COUNTY",
           year = 2000)

## ----ohio_commodity------------------------------------------------------
nass_param("commodity_desc",
           group_desc = "dairy",
           state_name = "OHIO",
           agg_level_desc = "COUNTY",
           year = ">2000")

## ----count_all-----------------------------------------------------------
nass_count()

## ----count_agland--------------------------------------------------------
nass_count(commodity_desc = "AG LAND",
           agg_level_desc = "COUNTY")

## ----data_agland_error, error = TRUE-------------------------------------
nass_data(commodity_desc = "AG LAND",
          agg_level_desc = "COUNTY")

## ----count_agland_years--------------------------------------------------
years <- 2000:2017
sapply(years, function(x) nass_count(year = x,
                                     commodity_desc = "AG LAND",
                                     agg_level_desc = "COUNTY"))


## ----agland_params-------------------------------------------------------
agland_params <- nass_param("short_desc",
                            commodity_desc = "AG LAND",
                            agg_level_desc = "COUNTY")
agland_params

## ----count_agland_short_desc---------------------------------------------
sapply(agland_params, function(x) nass_count(short_desc = x,
                                             commodity_desc = "AG LAND",
                                             agg_level_desc = "COUNTY"))

## ----agland_domain-------------------------------------------------------
agland_domain <- nass_param("domain_desc",
                            short_desc = "AG LAND - TREATED, MEASURED IN ACRES",
                            commodity_desc = "AG LAND",
                            agg_level_desc = "COUNTY")
sapply(agland_domain, function(x) nass_count(domain_desc = x,
                                             short_desc = "AG LAND - TREATED, MEASURED IN ACRES",
                                             commodity_desc = "AG LAND",
                                             agg_level_desc = "COUNTY"))

