#' Comment out lines that prevent pdf from being generated locally and produce pdf
#' 
#' Reads the tex file and comments out lines that prevent pdf from being
#' generated locally and  produces pdf using tinytex::pdflatex() and then changes 
#' the tex file back.
#' 
#' @param manual_file Name of the manual tex file. Default is "SS330_User_Manual.tex" 
#' with the assumption that this file is in your working directory.
#' @param dir Directory if "SS330_User_Manual.tex" is not in your working directory.
#' @author Elizabeth F. Perl
#' @return Results from tinytex::pdflatex().
#' @examples 
#' pdflatex_local_manual()
pdflatex_local_manual <- function(manual_file = "SS330_User_Manual.tex", dir = NULL)
{
    if(is.null(dir)){
        dir <- getwd()
    } else {
        dir <- dir
    }
    manual <- readLines(file.path(dir,"SS330_User_Manual.tex"))
    manual[3] <- gsub("\\\\","%\\\\",manual[3])
    manual[4] <- gsub("\\\\","%\\\\",manual[4])
    manual[6] <- gsub("\\\\","%\\\\",manual[6])
    manual[7] <- gsub("\\\\","%\\\\",manual[7])
    manual[8] <- gsub("\\\\","%\\\\",manual[8])
    manual[9] <- gsub("\\\\","%\\\\",manual[9])
    writeLines(manual, "SS330_User_Manual.tex")

    result <- tryCatch(
        expr = {
            message(tinytex::pdflatex("SS330_User_Manual.tex"))
            message("Successfully created SS330_User_Manual.pdf")
        },
        error = function(e){
            message('Caught an error!')
            print(e)
        },
        warning = function(w){
            message('Caught a warning!')
            print(w)
        }
    )

    manual <- readLines(file.path(dir,"SS330_User_Manual.tex"))
    manual[3] <- gsub("%\\\\", "\\\\",manual[3])
    manual[4] <- gsub("%\\\\", "\\\\",manual[4])
    manual[6] <- gsub("%\\\\", "\\\\",manual[6])
    manual[7] <- gsub("%\\\\", "\\\\",manual[7])
    manual[8] <- gsub("%\\\\", "\\\\",manual[8])
    manual[9] <- gsub("%\\\\", "\\\\",manual[9])
    writeLines(manual, "SS330_User_Manual.tex")

    return(result)
}

