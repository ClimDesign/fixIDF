compute_quantiles=function(parameter.samples,ret.periods=c(2,5,10,20,25,50,100,200)){

  quant_bay=list()
  durs=sort(unique(parameter.samples$duration))

  for(d in 1:length(durs)){
    currentSample=parameter.samples[which(parameter.samples$duration==durs[d]),]

    allCurves=c()
    for(ii in ret.periods){
      allCurves=cbind(allCurves,compute_ret_level(location=currentSample$location,scale=currentSample$scale ,shape=currentSample$shape,ret.per=ii))
    }

    quant_bay[[d]]=apply(allCurves,2,quantile,probs=unique(round(seq(1,99,length.out=100),0)/100))
    rownames(quant_bay[[d]])=paste(1:99,"%",sep="")
    colnames(quant_bay[[d]])=paste("T=",ret.periods,sep="")

  }

  names(quant_bay)=paste("dur=",durs,sep="")


  return(quant_bay)
}
