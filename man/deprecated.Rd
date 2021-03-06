% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/deprecated.R
\name{deprecated}
\alias{deprecated}
\alias{plotCountsPerGene}
\alias{plotGenesDetected}
\alias{alphaSummary}
\alias{contrastName}
\alias{plotDEGHeatmap}
\alias{plotDEGPCA}
\alias{plotMA}
\alias{plotMeanAverage}
\alias{plotVolcano}
\alias{resultsTables}
\alias{topTables}
\title{Deprecated functions}
\usage{
plotCountsPerGene(object, ...)

plotGenesDetected(object, ...)

alphaSummary(...)

contrastName(...)

plotDEGHeatmap(...)

plotDEGPCA(...)

plotMA(...)

plotMeanAverage(...)

plotVolcano(...)

resultsTables(...)

topTables(...)
}
\arguments{
\item{object}{Object.}

\item{...}{Additional arguments.}
}
\value{
\code{.Deprecated}.
}
\description{
Deprecated functions
}
\examples{
a <- function(...) {
    .Deprecated("b")
    b(...)
}

b <- function(x) {
    x + 1L
}

withCallingHandlers(
    expr = a(1L),
    warning = function(w) {
        print(w)
        invokeRestart("muffleWarning")
    }
)
}
\seealso{
\link[base:Deprecated]{Deprecated}.
}
\keyword{internal}
