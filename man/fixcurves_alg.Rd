\name{fixcurves_alg}
\alias{fixcurves_alg}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Adjusting non-consistent return levels by using a selection algorithm

}
\description{
This function adjusts return levels such that they become monotonically increasing as a function of return period and duration. This is done by performing a selection algorithm that (randomly) searches through the posterior 1-99 \% posterior quantiles of the return levels to find a consistent curve set. Any quantile between the 1 and 99 \% can be chosen for a return level, as long as it give a consistent curves.

Two search strategies are tested by invoking the \code{\link[fixIDF]{selection_alg}} function, one time with \code{strategy="up"} and one time with  \code{strategy="down"}. If at least one of the strategies converges, a consistent set of IDF-curves is returned together with some convergence diagnostics. If both strategies converges, the solution of the strategy that selects quantiles closer to the initial posterior medians is returned. If the algorithm  is not able to find consistent return levels within the 1-99 \% posterior quantiles this is indicated through a message.
}
\usage{
fixcurves_alg(quant_bay,maxit=1000,save.history=TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
 \item{quant_bay}{A list that contains the return levels' 1-99 \% posterior quantiles for a number of durations and return periods.  The list \code{quant_bay} is structured as follows: It has one element \code{$`dur=...`} per duration, for example \code{$`dur=1`, $`dur=3`} and \code{$`dur=60`}, where the durations are given in minutes, hours or days. The durations should be specified in increasing order. Each  \code{$`dur=...`} element includes a matrix where each row corresponds to a quantile in (0.01,0.02,0.03,...,0.98,0.99) and each column corresponds to a return period. The rows should be named as follows: \code{c("1\%","2\%",...,"99\%")}. The columns should be named as follows: \code{c("T=2","T=5",...,"T=100")} if your return periods are c(2, 5,...,100) years. A \code{quant_bay} list of the correct format can be obtained by using the function \code{\link[fixIDF]{compute_quantiles}} if you have MCMC parameter samples available.
}
  \item{maxit}{A scalar giving the maximum number of iterations before the algorithm gives up the search and declears non-convergence. Default is 1000.
}
  \item{save.history}{If \code{TRUE} the function saves and returns the return levels selected for each iteration. If \code{FALSE} it only returns the starting return levels and the final return levels.}


\item{seed}{A numeric that specifies a seed in \code{\link[set.seed]{set.seed}}. This can be used to replicate results. Also, if the algorithm does not converge for a specific seed, the function \code{fixcurves_alg} can be rerun with a different seed. A different seed might give convergence. Default is \code{NULL}, meaning that a random seed will be used.}


}
\details{
Since the function  adjusts the return levels such that they become increasing as a function of duration and return period, the input return levels must be given a unit such that this assumption makes sense. A suitable unit for annual maximum precipitation return levels would for example be mm, and not mm/hour.
}
\value{
\item{convergence}{If \code{TRUE}, the algorithm converged within \code{maxit} iterations. If \code{FALSE} it did not converge, i.e. no consistent solutions were found within the 1-99 \% posterior intervals when using our two possible search strategies.}
\item{winning.strategy}{Returns \code{"none"} if neither \code{strategy="up"} nor \code{strategy="down"} converges. Returns \code{"any"} if the return levels already were consistent according to the posterior medians.  Returns \code{"up"} if \code{strategy="up"} chose quantiles closer to the posterior median than \code{strategy="down"} or if it is the only converging solution. Likewise, it returns  \code{"down"} if \code{strategy="down"} chose quantiles closer to the posterior median than \code{strategy="up"} or if it is the only converging solution.}
\item{k}{The number of iterations needed to find a consistent set of curves for the \code{winning.strategy}. If \code{k=1}, the input curves were already consistent according to the posterior medians. If \code{k=0}, neither of the strategies converged within \code{maxit} iterations.}
\item{adjusted.curves}{If the algorithm converged for one of the strategies (or if no adjustments were needed) it contains the adjusted return levels stored in a matrix. This corresponds to the adjusted solution given by the method in \code{winning.strategy}. Each coulmn in the matrix represents a return period of interest, while each row represents a duration. If it is \code{NULL}, neither of the selection strategies were able to find a consistent solution.}
\item{unadjusted.curves}{Contains a matrix with the unadjusted, original return levels when the posterior medians are used as summary scores. Each coulmn represents a return period of interest, while each row represents a duration.}
\item{pvec}{A vector with one element per duration. For each duration it shows how far away the final chosen quantile is from the posterior median. For example does 0 mean that the posterior median was chosen, while 0.1 means that the 60 \% or 40 \% quantile was chosen.  The values are given for the \code{winning.strategy}.
}
\item{quantvec}{A vector with one element per duration. It contains the quantiles that were chosen for each duration represented in  \code{quant_bay} for the \code{winning.strategy}.}
\item{quantile.history}{A matrix that contains which quantile that was chosen for all iterations and durations for the \code{winning.strategy}. Each column represents an iteration, and each row represent one of the durations represented in \code{quant_bay}.}
\item{curve.history}{A list where each list element \code{$`k=..`} contains a matrix. This matrix contains the return levels chosen for a specific iteration \code{k} for the \code{winning.strategy}, with each column representing a return period and each row representing a duration. This list is only returned if \code{save.history==TRUE} is used as input.}
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Thea Roksvag <roksvag@nr.no>
}


\seealso{
Also see the documentation for \code{\link[fixIDF]{selection_alg}}. For  preperation of input variables, see \code{\link[fixIDF]{compute_quantiles}}.

The adjusted and unadjusted curves can be plotted by using \code{\link[fixIDF]{plotIDF}} and \code{\link[fixIDF]{plotGEV}}.

}
\examples{
#Extract the parameter samples from a specific precipitation station:
data("theta",package="fixIDF")
statnr=1
stations=unique(theta$stnr)[statnr]
parameter.samples=theta[theta$stnr==stations,]

#Compute quantiles:
quant_bay=compute_quantiles(parameter.samples,ret.periods=c(2,5,10,20,25,50,100,200))

#Perform the selection algorithm in order to find a set of consistent curves:
res_alg=fixcurves_alg(quant_bay,maxit=1000,save.history=TRUE,seed=3)

#Plot:
plotIDF(res_alg$unadjusted.curves)
plotIDF(res_alg$adjusted.curves)
}

 \keyword{ ~IDF }
 \keyword{ ~QDF }
