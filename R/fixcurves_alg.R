fixcurves_alg=function(quant_bay,maxit=1000,save.history=TRUE,seed=NULL){

  upres=selection_alg(quant_bay,maxit,strategy="up",save.history=save.history,seed=seed)
  if(upres$k==1){ #No adjustments were needed.
    upres$winning.strategy="any"
    return(upres)
  }else{
    downres=selection_alg(quant_bay,maxit,strategy="down",save.history=save.history,seed=seed)

    convUp=upres$convergence
    convDown=downres$convergence

    conv=c(convUp,convDown)

    #Calculate RMSE (deviance from median for all curves):
    pvecs=c(sqrt(sum(upres$pvec^2)/length(upres$pvec)),sqrt(sum(downres$pvec^2)/length(downres$pvec)))

    #Did both converge?
    didConv=which(conv==TRUE)

    if(length(didConv)==0){#No convergence.
      print("No solution found.")
      upres$winning.strategy="none"
     return(upres)
    }else{
      ordering=order(pvecs)
      for(j in 1:length(ordering)){
        if(conv[ordering[j]]==TRUE){
          if(ordering[j]==1){
            print("Upwards alg. gives the best solution.")

            upres$winning.strategy="Up"

            return(upres)
          }else if( ordering[j]==2){
            print("Downwards alg. gives the best solution.")
            downres$winning.strategy="Down"
            return(downres)
          }
        }
      }
    }
  }
}
