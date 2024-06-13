#' Comment out lines that prevent pdf from being generated locally and produce pdf
#' @description Reads the tex file and comments out lines that prevent pdf from being
#'   generated locally and  produces pdf using tinytex::pdflatex() and then changes 
#'   the tex file back.
#' @param manual_file Name of the manual tex file. Default is "SS330_User_Manual.tex"
#'  so you don't need to put one in there.
#' @author Elizabeth F. Perl

pdflatex_local_manual <- function(manual_file = "SS330_User_Manual.tex")
{
    manual <- readLines(file.path(getwd(),"SS330_User_Manual.tex"))
    manual[3] <- gsub("\\\\","%\\\\",manual[3])
    manual[4] <- gsub("\\\\","%\\\\",manual[4])
    manual[6] <- gsub("\\\\","%\\\\",manual[6])
    manual[7] <- gsub("\\\\","%\\\\",manual[7])
    manual[8] <- gsub("\\\\","%\\\\",manual[8])
    manual[9] <- gsub("\\\\","%\\\\",manual[9])
    writeLines(manual, "SS330_User_Manual.tex")

    result <- tinytex::pdflatex("SS330_User_Manual.tex")

    manual <- readLines(file.path(getwd(),"SS330_User_Manual.tex"))
    manual[3] <- gsub("%\\\\", "\\\\",manual[3])
    manual[4] <- gsub("%\\\\", "\\\\",manual[4])
    manual[6] <- gsub("%\\\\", "\\\\",manual[6])
    manual[7] <- gsub("%\\\\", "\\\\",manual[7])
    manual[8] <- gsub("%\\\\", "\\\\",manual[8])
    manual[9] <- gsub("%\\\\", "\\\\",manual[9])
    writeLines(manual, "SS330_User_Manual.tex")

    return(result)
}

