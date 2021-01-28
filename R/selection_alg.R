selection_alg=function(quant_bay,maxit=1000,strategy="up",save.history=TRUE,seed=NULL){
  if(is.null(seed)==FALSE){
    set.seed(seed)
  }

  curvehistory=list()
  n=length(quant_bay)
  bestguess=c()
  pvec=rep(0,n)
  quantilevec=rep("50%",n)
  quantvec=rep("50%",n)
  quantilehistory=quantvec

  names(pvec)=1:n
  possiblequants=rownames(quant_bay[[1]])
  possiblequants_temp=as.numeric(substr(possiblequants,1,nchar(possiblequants)-1))
  possiblequants_prob=possiblequants_temp
  possiblequants_prob=abs(50-possiblequants_prob)
  quants=list(name=possiblequants,prob=possiblequants_prob)

  convergence=TRUE

  #0: Initialize with medians:
  for(j in 1:n){
    bestguess=rbind(bestguess,quant_bay[[j]][which(rownames(quant_bay[[1]])=="50%"),])
  }

  bestguess_initial=bestguess

  #0: Start counter:
  k=1

  #Save curve history in a list:
  if(save.history==TRUE){
    curvehistory[[k]]=bestguess
  }

  #Check if posterior medians give consistent return levels:
  isCrossingF=crossing_check(bestguess)
  isNonMonotonicF=nonMonotonic_check(bestguess)

  while((sum(isNonMonotonicF)>0 | sum(isCrossingF)>0 ) & k < maxit) {
    #1: Identify problematic durations:
    problematic_curves=sort(unique(c(which(isCrossingF !=0 ,arr.ind=T)[,1],which(isNonMonotonicF==1))))

    #2: We draw one of the curves, denoted C*, from problematic_curves. This will be moved in this iteration:
    tochange=sample(problematic_curves,1)

    #Currently chosen quantile for C*
    currentQuant=quantvec[tochange]

    #Check which other curves C* crosses with:
    whocross=sort(unique(c(which(isCrossingF[tochange,]==1),problematic_curves[which(abs(tochange-problematic_curves)<0)])))

    if(sum(tochange<whocross)==length(whocross)){

      indchange=which(rownames(quant_bay[[1]])==currentQuant)-1

    }else if(sum(tochange>whocross)==length(whocross)){

      indchange=which(rownames(quant_bay[[1]])==currentQuant)+1

    }else{
      if(strategy=="up"){

        indchange=which(rownames(quant_bay[[1]])==currentQuant)+1

      }

      if(strategy=="down"){
        indchange=which(rownames(quant_bay[[1]])==currentQuant)-1
      }
    }

    #If we are outside our boundaries, we reset the curve to the posterior median:
    if(indchange> dim(quant_bay[[tochange]])[1] | indchange<1){
      indchange=which(rownames(quant_bay[[tochange]])=="50%") #Reset to median.
    }

    #Update our curve set accordingly:
    bestguess[tochange,]=quant_bay[[tochange]][indchange,]


    #Update probability vectors:
    quantvec[tochange]=rownames(quant_bay[[tochange]])[indchange]
    quantasnum=as.numeric(substr(quantvec[tochange],1,nchar(quantvec[tochange])-1))
    pvec[tochange]=abs(50-quantasnum)/100

    #Increase counter:
    k=k+1

    #Save quantile and curve history:
    quantilehistory=cbind(quantilehistory,quantvec)
    if(save.history==TRUE){
      curvehistory[[k]]=bestguess
      rownames(curvehistory[[k]])=names(quant_bay)
    }

    #Consistency check for the updated curve set:
    isCrossingF=crossing_check(bestguess)
    isNonMonotonicF=nonMonotonic_check(bestguess)

  }

  if(k ==maxit & (sum(isNonMonotonicF)>0 | sum(isCrossingF)>0 )){   #If we have met the stopping criterion indicating non-convergence:
    if(strategy=="up"){
      print(paste("Upwards algorithm didn't converge in ", maxit ," iterations.",sep=""))
    }
    if(strategy=="down"){
      print(paste("Downwards  algorithm didn't converge in ", maxit ," iterations.",sep=""))
    }


  }else if (k==1){ #If the posterior medians were consistent.
    print("No adjustments needed. The posterior medians give consistent curves.")
  }else{
    if(strategy=="up"){
      print(paste("Upwards algorithm converged in ", k ," iterations.",sep=""))
    }
    if(strategy=="down"){
      print(paste("Downwards algorithm converged in ", k ," iterations.",sep=""))
    }
  }

  quantilehistory=substr(quantilehistory,1,nchar(quantilehistory)-1)
  rownames(bestguess)=names(quant_bay)
  rownames(bestguess_initial)=names(quant_bay)
  names(pvec)=names(quant_bay)
  names(quantvec)=names(quant_bay)

  if(k>1){
    rownames(quantilehistory)=names(quant_bay)
    colnames(quantilehistory)=paste("k=",1:k,sep="")
    if(save.history==TRUE){
      names(curvehistory)=paste("k=",1:k,sep="")
    }
  }
  if(k==maxit){
  k=0
  convergence=FALSE
  bestguess=NULL
  pvec=NULL
  quantvec=NULL}


  return(list(convergence=convergence,k=k,adjusted.curves=bestguess,unadjusted.curves=bestguess_initial,pvec=pvec,quantvec=quantvec,quantile.history=quantilehistory,curve.history=curvehistory))
}
