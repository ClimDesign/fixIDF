\name{fixcurves_iso}
\alias{fixcurves_iso}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Adjusting non-consistent return levels by using isotonic regression
}
\description{
This function adjusts return levels such that they become monotonically increasing as a function of return period and duration. This is done by isotonic regression through the funtion \code{\link[isotonic.pen]{iso_pen}} with \code{pen=FALSE}. The function takes posterior median or posterior mean return levels for several durations and return periods as input, and returns a set of return levels that are consistent across durations and return periods.}
\usage{
fixcurves_iso(quant_bay=NULL,unadjusted.curves.df=NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{The function can either take a list of quantiles as input (\code{quant_bay}), similarly as the function \code{\link[fixIDF]{fixcurves_alg}}, or a data.frame with return levels, durations and return periods (\code{unadjusted.curves.df}). Hence, one of the following two inputs must be different from \code{NULL}:
 \item{quant_bay}{A list that contains the return levels' 1-99 \% posterior quantiles for a number of durations and return periods.  The return levels should be given in mm, and not e.g. in mm/hour. The list \code{quant_bay} is structured as follows: It has one element \code{$`dur=...`} per duration, for example \code{$`dur=1`, $`dur=3`} and \code{$`dur=60`}, where the durations are given in minutes, hours or days. The durations should be specified in increasing order. Each  \code{$`dur=...`} element includes a matrix where each row corresponds to a quantile in (0.01,0.02,0.03,...,0.98,0.99) and each column corresponds to a return period. The rows should be named as follows: \code{c("1\%","2\%",...,"99\%")}. The columns should be named as follows: \code{c("T=2","T=5",...,"T=100")} if your return periods are c(2, 5,...,100) years. A \code{quant_bay} list of the correct format can be obtained by using the function \code{\link[fixIDF]{compute_quantiles}} if you have MCMC parameter samples available.
}
\item{unadjusted.curves.df}{A \code{\link[base]{data.frame}} with the following three columns: \code{ret.periods}, \code{durations} and \code{ret.levels}. The column \code{ret.periods} contains return periods of interest, where the return periods typically are given in years.  The column \code{durations} contains durations of interest, where the durations typically are given in minutes, hours or days. The column \code{ret.levels} contains corresponding return levels that are to be adjusted.  These should have unit mm, and not e.g. mm/hour. An \code{unadjusted.curves.df} object containing posterior medians and means can be obtained by using the functions \code{\link[fixIDF]{compute_estimates}} if you have MCMC parameter samples available.
}

}
\details{
Since the function  adjusts the return levels such that they become increasing as a function of duration and return period, the input return levels must be given a unit such that this assumption makes sense. A suitable unit for annual maximum precipitation return levels would for example be mm, and not mm/hour.
}
\value{
\item{did.adjusments}{\code{TRUE} if adjustments have been done and \code{FALSE} if no adjustments were needed.}
\item{adjusted.curves}{Contains the adjusted return levels stored in a matrix. Each coulmn represents a return period of interest, while each row represents a duration.}
\item{unadjusted.curves}{Contains a matrix with the unadjusted, original return levels. Each coulmn represents a return period of interest, while each row represents a duration.}
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
See also the documentation of \code{\link[isotonic.pen]{iso_pen}} in the package \code{\link[isotonic.pen]{isotonic.pen}}.

See \code{\link[fixIDF]{compute_quantiles}} and \code{\link[fixIDF]{compute_estimates}} for preperation of input variables.

The adjusted and unadjusted curves can be plotted by using \code{\link[fixIDF]{plotIDF}} and \code{\link[fixIDF]{plotGEV}}.
}
\examples{

#Extract the parameter samples from a specific precipitation station:
data("theta",package="fixIDF")
statnr=1
stations=unique(theta$stnr)[statnr]
parameter.samples=theta[theta$stnr==stations,]

## EXAMPLE 1 ##

#Compute quantiles:
quant_bay=compute_quantiles(parameter.samples,
                            ret.periods=c(2,5,10,20,25,50,100,200))

#Adjust by isotonic regression:
res_iso=fixcurves_iso(quant_bay=quant_bay)

#Plot unadjusted curves:
plotIDF(res_iso$unadjusted.curves)

#Plot adjusted curves:
plotIDF(res_iso$adjusted.curves)

## END EXAMPLE 1 ##

## EXAMPLE 2 ##
#We use the posterior means to make initial return levels:
unadjusted.curves.df=compute_estimates(parameter.samples,
                     ret.periods=c(2,5,10,20,25,50,100,200),type="mean")

#Adjust by isotonic regression:
res_iso=fixcurves_iso(quant_bay=NULL,unadjusted.curves.df)

#Plot unadjusted curves:
plotIDF(res_iso$unadjusted.curves)

#Plot adjusted curves:
plotIDF(res_iso$adjusted.curves)

## END EXAMPLE 2 ##

}
