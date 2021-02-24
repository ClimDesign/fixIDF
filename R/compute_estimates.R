compute_estimates=function(parameter.samples,ret.periods=c(2,5,10,20,25,50,100,200),type="median"){

  durs=sort(as.numeric(unique(parameter.samples$duration)))

  z=c()
  for(d in 1:length(durs)){
    currentSample=parameter.samples[which(parameter.samples$duration==durs[d]),]

    allCurves=c()
    for(ii in ret.periods){
      allCurves=cbind(allCurves,compute_ret_level(location=currentSample$location,scale=currentSample$scale ,shape=currentSample$shape,ret.per=ii))
    }

    if(type=="median"){
    z=c(z,apply(allCurves,2,median))
    }else{
      z=c(z,apply(allCurves,2,mean))
    }

  }

  unadjusted.curves.df=data.frame(ret.periods=rep(ret.periods,times=length(durs)),durations=rep(durs,each=length(ret.periods)),ret.levels=z)


  return(unadjusted.curves.df)
}
