\name{crossing_check}
\alias{crossing_check}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Check whether a set of curves are in the correct order or  if they cross}
\description{
Help function that takes a set of curves as input and check whether they cross or are in the wrong order. Correct order here means that curveset[1,]<= curveset[2,]<=curveset[3,]... element-wise. The function returns a matrix with zeroes and ones that visualizes which curves that are in the wrong order and/or cross.
}
\usage{
crossing_check(curveset)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{curveset}{A matrix containing return levels. Each row corresponds to a curve associated with a duration and each column corresponds to a return period. The curves must be ordered such that curveset[j,] corresponds to a lower duration than curveset[i,] when i>j.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
A matrix of zeroes and ones that shows which curves in curveset that cross. For example if the curve in curveset[1,] crosses (or is always larger) than the curve in curveset[3,], element (1,3) in the matrix is 1. Otherwise it is 0.
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
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
crossing_check(rbind(c(0.5,2.5,3.5),c(0.7,2.7,3.9),c(0.6,2.9,4)))

crossing_check(rbind(c(0.5,2.5,3.5),c(0.9,3,5),c(0.6,2.9,4)))

crossing_check(rbind(c(0.5,2.5,3.5),c(0.7,2.7,3.9),c(0.8,2.9,4)))

crossing_check(rbind(c(2.5,9,15),c(0.7,2.7,3.9),c(0.8,2.9,4)))
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
