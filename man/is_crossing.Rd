\name{is_crossing}
\alias{is_crossing}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Returns indices for which one vector is larger than another vector
}
\description{
Help function used to check which of the numbers in one vector that is larger than the numbers in another vector. This is done element wise and is used to detect whether two curves are crossing or in the wrong order in the function \code{\link[fixIDF]{crossing_check}}. Vector indices for which vec.min is larger than vec.max are returned.

}
\usage{
is_crossing(vec.min,vec.max)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{vec.min}{
A vector containing numbers.
}
  \item{vec.max}{
A vector containing numbers. It should have the same length as vec.min.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{Returns vector indices for which vec.min is larger than vec.max. If all elements in vec.min is smaller than vec.max it returns integer(0).
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
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
is_crossing(c(1,2,5),c(2,4,1))
#Returns 3 because element 3 in vec.min is larger than element 3 in vec.max.

is_crossing(c(1,5,5),c(2,4,1))
#Returns 2 and 3 because elements 2 and 3 in vec.min is larger than elements 2 and 3 in vec.max.

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
