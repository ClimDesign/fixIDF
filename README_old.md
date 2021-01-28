# fixIDF

Package: fixIDF

Type: R package 

Title: fixIDF - Adjusting IDF-curves such that they become consistent across durations and return periods
        
Version: 1.0

Date: 2020-01-21

Author: Thea Roksvåg

Depends: isotonic.pen, ggplot2, viridis,stats

Maintainer: Thea RoksvÃ¥g <roksvag@nr.no>

Description: 

An intensity duration frequency (IDF) curve shows the relationship between rainfall intensities (return levels), the duration of the intensity and how 
often the intensity is expected to occur over time (frequency or return period). Often, IDF curves are fitted to annual maximum precipitation data, 
one duration at the time, independently of other durations. However, this can give inconsistent return levels across return periods and durations. 
This package includes two functions for adjusting IDF-curves such that they become consistent across return periods and durations: fixcurves_alg() and fixcurves_iso().

The function fixcurves_alg() is suitable for adjusting return levels that are obtained from any Bayesian method. It takes the return levels' 1-99 % posterior <
quantiles as input together with the associated durations and return periods. The algorithm searches for  a consistent set of curves within the  
1-99 % posterior quantiles and tries to find solutions that are as close as possible to the posterior medians of the initial Bayesian model.

The function fixcurves_iso() is suitable for adjusting return levels that are estimated by any statistical or process-based method. 
It takes return levels as input, together with associated durations and return periods.  The return levels are adjusted by using isotonic regression through the 
function iso_pen() from the package  isotonic.pen().

The functions fixcurves_alg() and fixcurves_iso() adjust the return levels such that they become monotonically increasing as a function of duration and return period. 
Hence, the input return levels must be given a unit such that this assumption makes sense. A suitable unit for the input precipitation return levels would for example be mm, 
and not mm/hour.

Plot functions for plotting the adjusted IDF-curves are available through the functions plotIDF() and plotGEV().

The functions fixcurves_alg() and fixcurves_iso() can also be used to adjust QDF curves. Again, the input return levels must be 
given a unit such that it makes sense that the return levels increase as a function of duration and return period.
