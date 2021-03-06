\name{compute_estimates}
\alias{compute_estimates}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Compute posterior median or mean return levels from GEV-parameter MCMC samples
}
\description{
Computes posterior medians or mean return levels for a three parameter GEV-distribution for several precipitation durations and return periods. This is done by using the function \code{\link[fixIDF]{compute_ret_level}} to compute return levels for all parameter sets that are used as input, for all return periods of interest. Then either the posterior mean or median is computed and returned. The returned \code{\link[base]{data.frame}} can further be used as the \code{unadjusted.curves.df} input in  \code{\link[fixIDF]{fixcurves_iso}}.
}
\usage{
compute_estimates(parameter.samples,ret.periods=c(2,5,10,20,25,50,100,200),type="median")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{parameter.samples}{A data frame with the following four columns: \code{location},\code{scale}, \code{shape} and \code{duration}. The column duration contains the duration of the observed precipitation or runoff in minutes or hours. The remaining columns correspond to each of the three parameters in a generalized extreme value distribution (location, scale and shape) and should be parameters sampled by MCMC. Typically one MCMC run has been performed for each duration.}


\item{ret.periods}{A vector of return periods of interest. Unit is years. Default is c(2,5,10,20,25,50,100,200).
}

\item{type}{Should be either "median" or "mean". This specifies which summary statistic that is computed and returned.}

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
\value{A list with three elements suitable as the \code{unadjusted.curves.df} input in  \code{\link[fixIDF]{fixcurves_iso}}:
\item{ret.periods}{The return periods used, typically in years.}
\item{durations}{The durations of interest, typically in minutes, hours or days.}
\item{ret.levels}{The mean or median return levels, typically in mm if we consider precipitation return levels.}



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

Adjust the return levels by using \code{\link[fixIDF]{fixcurves_iso}}.

}
\examples{
#Extract the parameter samples from a specific precipitation station:
data("theta",package="fixIDF")
statnr=1
stations=unique(theta$stnr)[statnr]
parameter.samples=theta[theta$stnr==stations,]

#Compute posterior means:
unadjusted.curves.df=compute_estimates(parameter.samples,
                  ret.periods=c(2,5,10,20,25,50,100,200),type="median")

#Compute posterior medians:
unadjusted.curves.df=compute_estimates(parameter.samples,
                  ret.periods=c(2,5,10,20,25,50,100,200),type="mean")

#Adjust curves:
res_iso=fixcurves_iso(NULL,unadjusted.curves.df)
plotIDF(res_iso$unadjusted.curves)
plotIDF(res_iso$adjusted.curves)

}
