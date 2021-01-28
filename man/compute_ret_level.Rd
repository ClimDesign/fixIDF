\name{compute_ret_level}
\alias{compute_ret_level}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Compute the return level for a three parameter GEV-distribution
}
\description{
Computes the return level corresponding to a return period of interest according to a three parameter GEV-distribution.
}
\usage{
compute_ret_level(location,scale,shape,ret.per)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{location}{A location parameter. Could be any number.

}
  \item{scale}{A scale (standard deviation) parameter. Must be larger than 0.

}
  \item{shape}{A shape parameter. Could be any number.
}
  \item{ret.per}{ Return period in years. Any number larger than 1.
}
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
\value{The return level corresponding to the return period of interest is returned.
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
compute_ret_level(location=20,scale=1,shape=1,ret.per=100)
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
