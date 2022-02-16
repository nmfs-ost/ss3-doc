# Always: Load packages
library(sa4ssgeneral)

# Always: Specify the directory for the document
setwd("C:/Users/Chantel.Wetzel/Documents/GitHub/doc/technical_description")


# Render Call:
if(file.exists("_main.Rmd")){
	file.remove("_main.Rmd")
}
# Render the pdf
bookdown::render_book("00a.Rmd", clean=FALSE, output_dir = getwd())
