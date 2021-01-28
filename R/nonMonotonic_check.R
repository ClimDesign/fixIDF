nonMonotonic_check=function(curves){

  monvec=rep(0,dim(curves)[1])

  for(j in 1:dim(curves)[1]){
    x=curves[j,]

    monvec[j]=all(x == cummax(x))
  }

  monvec[which(monvec==0)]=2

  return(monvec-1)
}
