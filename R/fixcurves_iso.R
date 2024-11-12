fixcurves_iso=function(quant_bay=NULL,unadjusted.curves.df=NULL){
  if(is.null(quant_bay)==TRUE & is.null(unadjusted.curves.df)==TRUE){
    print("Insert either a set of posterior quantiles or a table of posterior medians.")
  }

  curves=c()

  if(is.null(unadjusted.curves.df)==FALSE){
    durs=sort(as.numeric(unique(unadjusted.curves.df$durations)))
    for(i in 1:length(durs)){
      currentdata=unadjusted.curves.df[which(unadjusted.curves.df$durations==durs[i]),]
      curves= rbind(curves,currentdata$ret.levels[order(currentdata$ret.periods)])
    }
    rownames(curves)=paste("dur=",durs,sep="")
    colnames(curves)=paste("T=",sort(unique(unadjusted.curves.df$ret.periods)),sep="")

  }else{
    ind50=which(rownames(quant_bay[[1]])=="50%")

    for(j in 1:length(quant_bay)){
      curves=rbind(curves,quant_bay[[j]][ind50,])
    }
    rownames(curves)=names(quant_bay)
  }

  xmat=cbind(rep(as.numeric(substr(rownames(curves),5,nchar(rownames(curves)))),times=dim(curves)[2]),
             rep(as.numeric(substr(colnames(curves),3,nchar(colnames(curves)))),each=dim(curves)[1]))

  ys=as.numeric(curves,byrows=FALSE)
  colnames(xmat)=c("dur","T")

  if(sum(nonMonotonic_check(curves))==0 & sum(crossing_check(curves))==0){
    adjustedcurves=oldcurves=curves

    print("No adjustments needed. The posterior medians are consistent.")
    return(list(did.adjustments=FALSE,adjusted.curves=adjustedcurves,unadjusted.curves=oldcurves,xmat=xmat,yobs=ys,ypred=ys))

  }else{
    newcurves=iso_pen(xmat=xmat,y=ys,pen=FALSE)
    adjustedcurves=matrix(newcurves$fit,ncol=dim(curves)[2],nrow=dim(curves)[1],byrow=FALSE)

    rownames(adjustedcurves)=rownames(curves)
    colnames(adjustedcurves)=colnames(curves)
    return(list(did.adjustments=TRUE,adjusted.curves=adjustedcurves,unadjusted.curves=curves))  #xmat=xmat,yobs=ys,ypred=newcurves$fit
  }
}

