library("pkgdown")
build_site()


source_desc = NULL
sector_desc = NULL
group_desc = NULL
commodity_desc = NULL
short_desc = NULL
domain_desc = NULL
domaincat_desc = NULL
agg_level_desc = NULL
statisticcat_desc = NULL
state_name = NULL
asd_desc = NULL
county_name = NULL
region_desc = NULL
zip_5 = NULL
watershed_desc = NULL
year = NULL
freq_desc = NULL
reference_period_desc = NULL
token = NULL
format = "CSV"
numeric_vals = F

token = "21E12D8F-E59B-3C68-9113-EC288AA44D4D"
agg_level_desc = "COUNTY"
statisticcat_desc = "AREA PLANTED"
commodity_desc = "WHEAT"
commodity_desc = c("CORN", "WHEAT")


# __LE = <= 
# __LT = < 
# __GT = > 
# __GE = >= 
# __LIKE = like 
# __NOT_LIKE = not like 
# __NE = not equal 

#year = ">1999"
agg_level_desc = "COUNTY"
statisticcat_desc = "AREA PLANTED"
commodity_desc = "WHEAT"
year = ">2010"

how_many <- nass_count(agg_level_desc = "COUNTY",
                        statisticcat_desc = "AREA PLANTED",
                        commodity_desc = "WHEAT", year = ">2010")

what_of <- nass_param(param = "commodity_desc", agg_level_desc = "COUNTY",
                      statisticcat_desc = "AREA PLANTED",
                      year = ">2010")

what <- nass_data(agg_level_desc = "COUNTY",
                  statisticcat_desc = "AREA PLANTED",
                  commodity_desc = "WHEAT", year = ">2010")
