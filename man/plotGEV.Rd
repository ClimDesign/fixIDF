\name{plotGEV}
\alias{plotGEV}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Plots IDF-curves with one curve per duration
}
\description{
Plots IDF-curves as GEV-curves with one curve per duration, return periods on the x-axis and return levels on the y-axis. The package \code{\link[ggplot2]{ggplot}} is used for plotting. Returns a \code{ggplot2} object.
}
\usage{
plotGEV(curves,ylim=NULL,textsize=20,yname="Precipitation (mm)",
        xname="Return period (yr)",legend.name="Duration (min)")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{curves}{A matrix containing return levels, typically in mm for IDF-curves and in m^3/s for QDF-curves. Each row corresponds to a return period and should be named as follows: c("T=2","T=3","T=5",...,"T=100") for your return periods of interest. These are typically given in years. Each column corresponds to a duration of interest and should be named as follows: c("dur=1","dur=3","dur=5") where the duration typically is given in minutes, hours or days. The \code{$adjusted.curves} and \code{$unadjusted.curves} matrices that are returned from \code{\link[fixIDF]{fixcurves_alg}}, \code{\link[fixIDF]{selection_alg}} and  \code{\link[fixIDF]{fixcurves_iso}} are of this exact format and can be directly inserted into the \code{plotIDF} function.
}

  \item{ylim}{A vector with two numbers, where the first number gives the minimum value of the y-axis and the second number gives the maximum value of the y-axis. For example \code{ylim=c(0,100)}. If \code{NULL} the y-axis limits  are determined by the maximum and minimum value in \code{curves}.
}
  \item{textsize}{ A number indicating the text size used in the plot.
}
  \item{yname}{y-axis title. Default is "Precipitation (mm)".
}
  \item{xname}{x-axis title. Default is "Return period (yr)".
}
  \item{legend.name}{legend title.  Default is "Duration (min)".
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
See also the other plot function for plotting IDF-curves with one curve per return period: \code{\link[fixIDF]{plotIDF}}.
}
\examples{
#Extract the parameter samples from a specific precipitation station:
data("theta",package="fixIDF")
statnr=1
stations=unique(theta$stnr)[statnr]
parameter.samples=theta[theta$stnr==stations,]

#Compute quantiles:
quant_bay=compute_quantiles(parameter.samples,
                        ret.periods=c(2,5,10,20,25,50,100,200))

#Perform the selection algorithm:
res_alg=fixcurves_alg(quant_bay,maxit=1000,save.history=TRUE,seed=3)

#Plot IDF-curves for unadjusted return levels:
plotGEV(res_alg$unadjusted.curves,ylim=c(0,100),yname="Return level (mm)",textsize=25)

#Plot IDF-curves for adjusted return levels:
plotGEV(res_alg$adjusted.curves,ylim=c(0,100),yname="Return level (mm)",textsize=25)


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
