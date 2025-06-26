#' Comment out lines that prevent pdf from being generated locally and produce pdf
#'
#' Reads the tex file and comments out lines that prevent pdf from being
#' generated locally and produces pdf using tinytex::lualatex() and then changes
#' the tex file back. Please see issue #135 in the ss3-doc repository
#' (https://github.com/nmfs-ost/ss3-doc/issues/135) for more information on the
#' lines that prevent the pdf from being generated locally.
#'
#' @param manual_file A string providing the name of the manual tex file. The default is
#' "SS330_User_Manual.tex" with the assumption that this file is in your working directory.
#' @param dir A string providing the path to the directory where `manual_file` is located.
#' The default is [getwd()].
#' @author Elizabeth F. Perl
#' @return Results from tinytex::lualatex().
#' @examples
#' lualatex_local_manual()
lualatex_local_manual <- function(
    manual_file = "SS330_User_Manual.tex",
    dir = getwd()
) {
    manual <- readLines(file.path(dir, "SS330_User_Manual.tex"))
    manual[3] <- gsub("\\\\", "%\\\\", manual[3])
    manual[4] <- gsub("\\\\", "%\\\\", manual[4])
    manual[6] <- gsub("\\\\", "%\\\\", manual[6])
    manual[7] <- gsub("\\\\", "%\\\\", manual[7])
    manual[8] <- gsub("\\\\", "%\\\\", manual[8])
    manual[9] <- gsub("\\\\", "%\\\\", manual[9])
    manual[67] <- gsub("\\\\", "%\\\\", manual[67])
    manual[68] <- gsub("\\\\", "%\\\\", manual[68])
    manual[69] <- paste0("%", manual[69])
    manual[70] <- paste0("%", manual[70])
    manual[71] <- paste0("%", manual[71])
    manual[72] <- gsub("\\\\", "%\\\\", manual[72])
    writeLines(manual, "SS330_User_Manual.tex")

    result <- tryCatch(
        expr = {
            message(tinytex::lualatex("SS330_User_Manual.tex"))
            message("Successfully created SS330_User_Manual.pdf")
        },
        error = function(e) {
            message('Caught an error!')
            print(e)
        },
        warning = function(w) {
            message('Caught a warning!')
            print(w)
        }
    )

    manual[3] <- gsub("%\\\\", "\\\\", manual[3])
    manual[4] <- gsub("%\\\\", "\\\\", manual[4])
    manual[6] <- gsub("%\\\\", "\\\\", manual[6])
    manual[7] <- gsub("%\\\\", "\\\\", manual[7])
    manual[8] <- gsub("%\\\\", "\\\\", manual[8])
    manual[9] <- gsub("%\\\\", "\\\\", manual[9])
    manual[67] <- gsub("%\\\\", "\\\\", manual[67])
    manual[68] <- gsub("%\\\\", "\\\\", manual[68])
    manual[69] <- gsub("%", "", manual[69])
    manual[70] <- gsub("%", "", manual[70])
    manual[71] <- gsub("%", "", manual[71])
    manual[72] <- gsub("%\\\\", "\\\\", manual[72])
    writeLines(manual, "SS330_User_Manual.tex")

    return(result)
}
