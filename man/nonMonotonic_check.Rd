\name{nonMonotonic_check}
\alias{nonMonotonic_check}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Checks whether some vectors are non-monotonic
}
\description{
Help function used ot check whether some vectors are non-monotonic. The vectors are stored as rows in a matrix.
}
\usage{
nonMonotonic_check(curves)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{curves}{A matrix where each row represents a vector of numbers.
}
}
\details{
}
\value{Returns a vector that has equally many elements as there are rows in \code{curves}. An element is 1 if the corresponding row in \code{curves} is non-monotonic and 0 if it is monotonically increasing.
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Thea Roksvaag <roksvag@nr.no>
}

\examples{
curves=rbind(c(1,3,6),c(1,0.5,4),c(1,9,20))
nonMonotonic_check(curves)
#Returns c(0,1,0) because row 2 of the matrix
#is non-monotonic.
#Row 1 and row 3 are monotonically increasing.

}
