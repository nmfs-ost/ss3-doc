# Contributing to ss3-doc

## General information
Thank you for your interest in contributing to doc! We strive to follow the [NMFS Fisheries Toolbox Contribution Guide](https://github.com/nmfs-fish-tools/Resources/blob/master/CONTRIBUTING.md). Note that these are guidelines, not rules, and we are open to collaborations in other ways that may work better for you. Please feel free to reach out to us by opening an issue in this repository or by emailing the developers at nmfs.stock.synthsis@noaa.gov.

This project and everyone participating in it is governed by the [NMFS Fisheries Toolbox Code of Conduct](https://github.com/nmfs-fish-tools/Resources/blob/master/CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [fisheries.toolbox@noaa.gov](mailto:fisheries.toolbox@noaa.gov). Note that the maintainers of SS3 do not have access to this email account, so unacceptable behavior of the maintainers can also be reported here.

## Compiling the Stock Synthesis manual

The manual can be compiled locally using a [LaTeX compiler](https://www.overleaf.com/learn/latex/Choosing_a_LaTeX_Compiler), such as TexLive or MikTex. To compile the whole document, clone the repository and follow instructions for LaTeX compiling, applying them to [SS330_User_Manual.tex](https://github.com/nmfs-ost/ss3-doc).

The manual is also compiled using github actions on every commit to the ss3-doc repository. The manual is saved as an artifact and is available for viewing. For those who don't want to compile locally, a pull request could be submitted with changes to the .tex files and github actions can be used to see the compiled products. The [call-ss3-manual-html job](https://github.com/nmfs-ost/ss3-doc/blob/main/.github/workflows/call-ss3-manual-html.yml) compiles the html version of the manual (using pandoc and R code), while the [call-ss3-manual-pdf](https://github.com/nmfs-ost/ss3-doc/blob/main/.github/workflows/call-ss3-manual-pdf.yml) job compiles the pdf version. call-ss3-manual-pdf-release.yml and call-ss3-manual-html-release.yml are only run manually (not with every commit).
