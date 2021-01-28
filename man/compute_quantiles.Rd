\name{compute_quantiles}
\alias{compute_quantiles}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Compute posterior quantiles for return levels from GEV-parameter MCMC samples
}
\description{
Computes posterior (1,2,...,99) \% quantiles for the return levels for a three parameter GEV-distribution for several durations and return periods. This is done by using the function \code{\link[fixIDF]{compute_ret_level}} to estimate return levels for all parameter sets that are used as input, for all return periods of interest. Empirical posterior quantiles for each return period and duration are next computed by using the function \code{\link[stats]{quantile}}. The returned list can further be used as the \code{quant_bay} input in \code{\link[fixIDF]{fixcurves_alg}}, \code{\link[fixIDF]{fixcurves_iso}} and \code{\link[fixIDF]{selection_alg}}.
}
\usage{
compute_quantiles(parameter.samples,ret.periods=c(2,5,10,20,25,50,100,200))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{parameter.samples}{A data frame with the following four columns: \code{location},\code{scale}, \code{shape} and \code{duration}. The column duration contains the duration of the observed precipitation in minutes or hours. The remaining columns correspond to each of the three parameters in a generalized extreme value distribution (location, scale and shape) and should be parameters sampled by MCMC. Typically one MCMC run has been performed for each duration.}

\item{ret.periods}{A vector of return periods of interest. Unit is years. Default is c(2,5,10,20,25,50,100,200).
}

The (annual) maximum precipitation data that were used to estimate the parameters by MCMC should have a unit such that it makes sense that the return levels increase as a function of duration and return period. A suitable unit for the data is hence mm, and not e.g. mm/hour.

}
\details{


The cdf of the three parameter GEV-distribution is here parametrized as follows:

\eqn{G(x)=exp{-[1+shape((x-location)/scale)]^(-1/shape)}}

for \eqn{[1+shape((x-location)/scale)]>0} and \eqn{scale>0}.
The parameters \eqn{shape} and \eqn{location} can be any number.

The return level \eqn{z}  corresponding to a return period \eqn{T} is given by:

\eqn{z=location-(scale/shape)*[1-(-log(1-1/T))^{-shape}]} when \eqn{shape!=0} and

\eqn{z=location-scale*log(-log(1-1/ret.per))} when \eqn{shape=0}, following a Gumbel distribution.

}
\value{
Returns a list containing one element for each unique duration in parameter.samples$duration. The list is named according to duration. The returned list can further be used as the \code{quant_bay} input in the functions \code{\link[fixIDF]{fixcurves_alg}}, \code{\link[fixIDF]{fixcurves_iso}} and \code{\link[fixIDF]{selection_alg}}.
\item{$dur=...}{A matrix containing the posterior quantiles for the return levels for a duration of interest. The matrix has one column for each return period in ret.periods and one row for each quantile in (1,2,...,99).}
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
See  \code{\link[fixIDF]{compute_ret_level}}  for information on how the return levels are computed.

Adjust the return levels by using \code{\link[fixIDF]{fixcurves_alg}} or \code{\link[fixIDF]{fixcurves_iso}}.

}
\examples{
#Extract the parameter samples from a specific precipitation station:
data("theta",package="fixIDF")
statnr=1
stations=unique(theta$stnr)[statnr]
parameter.samples=theta[theta$stnr==stations,]

#Compute quantiles:
quant_bay=compute_quantiles(parameter.samples,ret.periods=c(2,5,10,20,25,50,100,200))

#Adjust curves - isotonic:
res_iso=fixcurves_iso(quant_bay)

#Adjust curves - algorithm:
res_alg=fixcurves_alg(quant_bay)

#Plot:
plotIDF(res_iso$adjusted.curves)
plotIDF(res_alg$adjusted.curves)


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
 \keyword{ ~IDF }
 \keyword{ ~QDF }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
