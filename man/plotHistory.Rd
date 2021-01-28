\name{plotHistory}
\alias{plotHistory}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Plot quantile history
}
\description{
A function that plots which quantile that was chosen for each duration as a function of iteration for the selection algorithm in \code{\link[fixIDF]{fixcurves_alg}} or \code{\link[fixIDF]{selection_alg}}. A \code{\link[ggplot2]{ggplot}} object is returned.
}
\usage{
plotHistory(res_alg,ylim=NULL,legend.name="Durations (min)",textsize=15)
}

\arguments{
  \item{res_alg}{The returned list from  \code{\link[fixIDF]{fixcurves_alg}} or \code{\link[fixIDF]{selection_alg}}.}
   \item{ylim}{Vector of two elements giving the limits for the y-axis. Default is c(0,100).}
   \item{legend.name}{The name displayed over the legend in the plot. Default is "Durations (min)".}
   \item{textsize}{The text size to be used in the plot. Default is 15.}
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{A  \code{\link[ggplot2]{ggplot}} object is returned.

}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Thea Roksvaag <roksvag@nr.no>
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
See the selection algorithms in \code{\link[fixIDF]{fixcurves_alg}} and \code{\link[fixIDF]{selection_alg}}.
}
\examples{
#Extract the parameter samples from a specific precipitation station:
data("theta",package="fixIDF")
statnr=2
stations=unique(theta$stnr)[statnr]
parameter.samples=theta[theta$stnr==stations,]

#Compute quantiles:
quant_bay=compute_quantiles(parameter.samples,ret.periods=c(2,5,10,20,25,50,100,200))

#EXAMPLE with fixcurves_alg() #
res_alg=fixcurves_alg(quant_bay,maxit=1000,seed=3)
plotHistory(res_alg,ylim=c(10,90),legend.name="Durations (min)")

#EXAMPLE with selection_alg()#
res_alg=selection_alg(quant_bay,maxit=1000,strategy="up",seed=4)
plotHistory(res_alg,ylim=c(10,90),legend.name="Durations (min)")

}
