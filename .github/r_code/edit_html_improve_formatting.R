# Edit html to improve formatting
# Used in the build-ss3-manual-html.yml workflow and the
# release.yml workflow

# user_manual_name <- readLines("user_manual_name.txt", warn = FALSE)

# html_txt <- readLines(user_manual_name)
# # html_txt <- readLines("SS330_User_Manual_release.html")

html_txt <- readLines("SS330_User_Manual.html")
# read html snippits to add
html_snips <- readLines("html_usermanual_snippets.html")
# remove inline style
style_sec <- grep("style>", html_txt)
html_txt <- html_txt[-(style_sec[1]:style_sec[2])]
# add in the navbar
navbar_snip <- grep("div", html_snips)
navbar_snip <- html_snips[navbar_snip[1]:navbar_snip[2]]
html_txt <- append(html_txt, navbar_snip, after = grep("<html", html_txt))
html_txt <- gsub(
    "<p>_add:nnn<span>Catalog</span><span>Lang</span><span>(enUS)</span></p>",
    "", html_txt,
    fixed = TRUE
)
# add link to css
css_snip <- grep("<link", html_snips, value = TRUE)
html_txt <- append(html_txt, css_snip, after = grep("<title>", html_txt))
# Add styling to tables add 1 because first col is on next row
first_lines <- grep("^<tr class=[[:punct:]]{1}[oe]", html_txt) + 1
tmp_lines <- html_txt[first_lines]
tmp_lines <- gsub(
    "<td style=\"text-align: left;\">",
    "<td style=\"text-align: left;white-space: nowrap;\">",
    tmp_lines
)
html_txt[first_lines] <- tmp_lines
# remove Typical Value double header
label <- grep(">Typical Value<", html_txt, fixed = TRUE)
diff_label <- diff(label)
to_rm <- which(diff_label < 10)
# one to get rid of is test
to_rm_lines <- label[to_rm + 1]
for (i in to_rm_lines) {
    start <- grep("<tr", html_txt, fixed = TRUE)
    end <- grep("/tr", html_txt, fixed = TRUE)
    start <- max(start[start %in% (i - 5):(i - 1)])
    end <- min(end[end %in% (i + 1):(i + 5)])
    if (length(start) == 1 & length(end) == 1) {
        html_txt[start:end] <- ""
    }
}
# remove Value double header
label <- grep(">Value<", html_txt, fixed = TRUE)
diff_label <- diff(label)
to_rm <- which(diff_label < 10)
to_rm_lines <- label[to_rm + 1]
for (i in to_rm_lines) {
    start <- grep("<tr", html_txt, fixed = TRUE)
    end <- grep("/tr", html_txt, fixed = TRUE)
    start <- max(start[start %in% (i - 5):(i - 1)])
    end <- min(end[end %in% (i + 1):(i + 5)])
    if (length(start) == 1 & length(end) == 1) {
        html_txt[start:end] <- ""
    }
}
# remove LO HI INIT etc double header
label <- grep(">LO<", html_txt, fixed = TRUE)
diff_label <- diff(label)
to_rm <- which(diff_label < 20)
to_rm_lines <- label[to_rm + 1]
for (i in to_rm_lines) {
    start <- grep("<tr", html_txt, fixed = TRUE)
    end <- grep("/tr", html_txt, fixed = TRUE)
    start <- max(start[start %in% (i - 10):(i - 1)])
    end <- min(end[end %in% (i + 1):(i + 10)])
    if (length(start) == 1 & length(end) == 1) {
        html_txt[start:end] <- ""
    }
}
# remove Pattern N Parameters etc double header
label <- grep(">N Parameters<", html_txt, fixed = T)
diff_label <- diff(label)
to_rm <- which(diff_label == 5)
to_rm_lines <- label[to_rm + 1]
for (i in to_rm_lines) {
    start <- grep("<tr", html_txt, fixed = TRUE)
    end <- grep("/tr", html_txt, fixed = TRUE)
    start <- max(start[start %in% (i - 2):(i - 1)])
    end <- min(end[end %in% (i + 1):(i + 2)])
    if (length(start) == 1 & length(end) == 1) {
        html_txt[start:end] <- ""
    }
}
# Add title to table of contents
where_add <- grep('<nav id="TOC" role="doc-toc">',
    html_txt,
    fixed = TRUE
)
html_txt <- append(html_txt,
    "<h1>Table of Contents</h1>",
    after = where_add[1]
)
# Add title to references
where_add <- (grep("references csl-bib-body hanging-indent",
    html_txt,
    fixed = TRUE
) - 1)
dat_num <- grep("data-number", html_txt)
dat_num_actual <- html_txt[dat_num]
dat_num_actual <- gsub(".*data-number=", "", dat_num_actual)
ref_num <- max(as.numeric(sub("\\D*(\\d+).*", "\\1", dat_num_actual))) + 1
html_txt <- append(html_txt,
    paste0('<h1 data-number="', ref_num, '" id="sec:references"><span class="header-section-number">', ref_num, "</span> References</h1>"),
    after = where_add
)
# Add references to table of contents
where_add <- grep("</nav>", html_txt, fixed = TRUE) - 2
html_txt <- append(html_txt,
    paste0('<li><a href="#sec:references"><span class="toc-section-number">', ref_num, "</span> References</a></li>"),
    after = where_add
)

# writeLines(html_txt, user_manual_name)
# writeLines(html_txt, "SS330_User_Manual_release.html")
# writeLines(html_txt, "docs/SS330_User_Manual_release.html")
