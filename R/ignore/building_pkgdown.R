# https://lbusettspatialr.blogspot.com/2017/08/building-website-with-pkgdown-short.html

# require("devtools")
# use_readme_rmd()
# use_news_md()
# use_vignette("usdarnass")  #substitute with the name of your package
# 
# use_github_links()
# use_travis()
# use_cran_badge()

devtools::install_github("hadley/pkgdown")
library("desc")
library("pkgdown")

build_site()

desc_add_author("Robert", "Dinterman", "robert.dinterman@gmail.com",
                role = "cre", comment = c(ORCID = "0000-0002-9055-6082"))
desc_add_author("Robert", "Dinterman", "robert.dinterman@gmail.com",
                role = "aut", comment = c(ORCID = "0000-0002-9055-6082"))
desc_add_author("Jonathan", "Eyer", "jeyer@usc.edu", role = "aut")
