\name{theta}
\docType{data}
\alias{theta}
\title{
MCMC parameter samples from a three parameter GEV-distribution
}
\description{
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
}
\usage{data("theta",package="fixIDF")}
\format{A \code{\link[base]{data.frame}} with five columns: \code{stnr}, \code{duration}, \code{location}, \code{scale} and \code{shape}. It contains parameter samples generated from a MCMC sampling algorithm where the parameters of a three parameter GEV-distribution were sampled. See our definition of the three parameter GEV-distribution below. The sampled parameters are contained in the columns \code{location}, \code{scale} and \code{shape} respectively.

The parameters are sampled based on annual maximum precipitation data from Norway with unit mm. The data were measured at 5 precipitation stations and the precipitation station IDs are contained in the column \code{stnr}. There were precipitation data available for several durations and the different durations are listed in column \code{duration} with unit minutes. One MCMC run was performed for each duration and station, independently of other durations and stations. In \code{theta}, 3000 of the MCMC parameter samples for each duration and station are included.

The method used for estimating the parameters is a Bayesian method with priors as described in Lutz et. al. (2020).


}
\details{
The cdf of the three parameter GEV-distribution is here parametrized as follows:

\eqn{G(x)=exp{-[1+shape((x-location)/scale)]^(-1/shape)}}

for \eqn{[1+shape((x-location)/scale)]>0} and \eqn{scale>0}.
The parameters \eqn{shape} and \eqn{location} can be any number.

The return level \eqn{z}  corresponding to a return period \eqn{T} is given by:

\eqn{z=location-(scale/shape)*[1-(-log(1-1/T))^{-shape}]} when \eqn{shape!=0} and

\eqn{z=location-scale*log(-log(1-1/T))} when \eqn{shape=0}, following a Gumbel distribution.

}
\source{
%\url{https://seklima.met.no/}}
\references{
Lutz, J., Grinde,  L., Dyrrdal, A., 2020. Estimating  rainfall  design  values  for  the  city  of  Oslo,  Norway - Comparison of methods and quantification of uncertainty.  Water 12, 1735. doi:10.3390/w12061735.
}
