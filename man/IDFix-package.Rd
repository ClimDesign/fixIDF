\name{fixIDF-package}
\alias{fixIDF}
\docType{package}
\title{
fixIDF - Adjusting IDF-curves such that they become consistent across durations and return periods
}
\description{
An intensity duration frequency (IDF) curve shows the relationship between rainfall intensities (return levels), the duration of the intensity and how often the intensity is expected to occur over time (frequency or return period). Often, IDF curves are fitted to annual maximum precipitation data, one duration at the time, independently of other durations. However, this can give inconsistent return levels across return periods and durations. This package includes two functions for adjusting IDF-curves such that they become consistent across return periods and durations: \code{\link[fixIDF]{fixcurves_alg}} and \code{\link[fixIDF]{fixcurves_iso}}.

The function \code{\link[fixIDF]{fixcurves_alg}} is suitable for adjusting return levels that are obtained from any Bayesian method. It takes the return levels' 1-99 \% posterior quantiles as input together with the associated durations and return periods. The algorithm searches for  a consistent set of curves within the  1-99 \% posterior quantiles and tries to find solutions that are as close as possible to the posterior medians of the initial Bayesian model.

The function \code{\link[fixIDF]{fixcurves_iso}} is suitable for adjusting return levels that are estimated by any statistical or process-based method. It takes return levels as input, together with associated durations and return periods.  The return levels are adjusted by using isotonic regression through the function \code{\link[isotonic.pen]{iso_pen}} from the package  \code{\link[isotonic.pen]{isotonic.pen}}.

The functions \code{\link[fixIDF]{fixcurves_alg}}  and \code{\link[fixIDF]{fixcurves_iso}} adjust the return levels such that they become monotonically increasing as a function of duration and return period. Hence, the input return levels must be given a unit such that this assumption makes sense. A suitable unit for the input precipitation return levels would for example be mm, and not mm/hour.

Plot functions for plotting the adjusted IDF-curves are available through the functions \code{\link[fixIDF]{plotIDF}} and \code{\link[fixIDF]{plotGEV}}.

The functions \code{\link[fixIDF]{fixcurves_alg}} and  \code{\link[fixIDF]{fixcurves_iso}} can also be used to adjust QDF curves. Again, the input return levels must be given a unit such that it makes sense that the return levels increase as a function of duration and return period.

}
\details{
\tabular{ll}{
Package: \tab fixIDF\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2021-01-20\cr
License: \tab GPL\cr
}
}
\author{
Thea Roksvaag.

Maintainer: Thea Roksvaag <roksvag@nr.no>

}
\references{
Paper to be submitted...
}
\keyword{ package }

