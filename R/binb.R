##' Templates for RMarkdown-based Beamer PDF presentations supporting
##' the \sQuote{Metropolis} style by Matthias Vogelgesang and others,
##' and the \sQuote{IQSS} style by Ista Zahn and Gary King.
##'
##' Note that not all options and customizations available at the LaTeX
##' level are implemented or supported yet.
##' @title Binb is not Beamer - PDF Presentation Themes
##' @param toc A logical variable defaulting to \code{FALSE}.
##' @param slide_level A numeric variable defaulting to two for
##' \sQuote{Metrpolis} and three for \sQuote{IQSS}.
##' @param incremental A logical variable defaulting to \code{FALSE}.
##' @param fig_width A numeric variable defaulting to ten.
##' @param fig_height A numeric variable defaulting to seven.
##' @param fig_crop A logical variable defaulting to \code{TRUE}.
##' @param fig_caption A logical variable defaulting to \code{TRUE}.
##' @param dev A character variable defaulting to \dQuote{pdf}.
##' @param df_print A character variable defaulting to \dQuote{default}.
##' @param fonttheme A character variable defaulting to \dQuote{default}.
##' @param highlight A character variable defaulting to \dQuote{tango}.
##' @param keep_tex A logical variable defaulting to \code{FALSE}.
##' @param latex_engine A character variable defaulting to \dQuote{xelatex}.
##' @param citation_package An optional character variable with possible value
##' \dQuote{none}, \dQuote{natbib} (the default), or \dQuote{biblatex}.
##' @param includes An optional character variable defaulting to \code{NULL}.
##' @param md_extensions An optional character variable defaulting to \code{NULL}.
##' @param pandoc_args An optional character variable defaulting to \code{NULL}.
##' @return RMarkdown content processed for rendering.
##' @author Dirk Eddelbuettel
##' @examples
##' \dontrun{
##' library(rmarkdown)
##' draft("myslides.Rmd", template="metropolis", package="binb", edit=FALSE)
##' setwd("myslides")       ## template creates a new subdir
##' render("myslides.Rmd")
##' }
metropolis <- function(toc = FALSE,
                       slide_level = 2,
                       incremental = FALSE,
                       fig_width = 10,
                       fig_height = 7,
                       fig_crop = TRUE,
                       fig_caption = TRUE,
                       dev = 'pdf',
                       df_print = "default",
                       fonttheme = "default",
                       highlight = "tango",
                       keep_tex = FALSE,
                       latex_engine = "xelatex",
                       citation_package = c("none", "natbib", "biblatex"),
                       includes = NULL,
                       md_extensions = NULL,
                       pandoc_args = NULL) {

    template <- system.file("rmarkdown", "templates", "metropolis",
                            "resources", "template.tex",
                            package="binb")

    rmarkdown::beamer_presentation(template = template,
                                   toc = toc,
                                   slide_level = slide_level,
                                   incremental = incremental,
                                   fig_width = fig_width,
                                   fig_height = fig_height,
                                   fig_crop = fig_crop,
                                   fig_caption = fig_caption,
                                   dev = dev,
                                   df_print = df_print,
                                   theme = "metropolis",
                                   fonttheme = fonttheme,
                                   highlight = highlight,
                                   keep_tex = keep_tex,
                                   latex_engine = latex_engine,
                                   citation_package = citation_package,
                                   includes = includes,
                                   md_extensions = md_extensions,
                                   pandoc_args = pandoc_args)

}

##' @rdname metropolis
iqss <- function(toc = FALSE,
                 slide_level = 3,
                 incremental = FALSE,
                 fig_width = 10,
                 fig_height = 7,
                 fig_crop = TRUE,
                 fig_caption = TRUE,
                 dev = 'pdf',
                 df_print = "default",
                 fonttheme = "default",
                 highlight = "haddock",
                 keep_tex = FALSE,
                 latex_engine = "xelatex",
                 citation_package = c("none", "natbib", "biblatex"),
                 includes = NULL,
                 md_extensions = NULL,
                 pandoc_args = NULL) {

    for (f in c("beamercolorthemeiqss.sty", "beamerfontthemeiqss.sty",
                "beamerthemeiqss.sty", "header.png", "figs/"))
        if (!file.exists(f))
            file.copy(system.file("rmarkdown", "templates", "iqss", "skeleton", f, package="binb"),
                      ".", recursive=TRUE)

    template <- system.file("rmarkdown", "templates", "iqss",
                            "resources", "template.tex",
                            package="binb")

    rmarkdown::beamer_presentation(template = template,
                                   toc = toc,
                                   slide_level = slide_level,
                                   incremental = incremental,
                                   fig_width = fig_width,
                                   fig_height = fig_height,
                                   fig_crop = fig_crop,
                                   fig_caption = fig_caption,
                                   dev = dev,
                                   df_print = df_print,
                                   theme = "iqss",
                                   fonttheme = fonttheme,
                                   highlight = highlight,
                                   keep_tex = keep_tex,
                                   latex_engine = latex_engine,
                                   citation_package = citation_package,
                                   includes = includes,
                                   md_extensions = md_extensions,
                                   pandoc_args = pandoc_args)

}


# Call rmarkdown::pdf_documet and mark the return value as inheriting pdf_document
inherit_pdf_document <- function(...) {
    fmt <- rmarkdown::pdf_document(...)
    fmt$inherits <- "pdf_document"
    fmt
}

knitr_fun <- function(name) utils::getFromNamespace(name, 'knitr')

output_asis <- knitr_fun('output_asis')
