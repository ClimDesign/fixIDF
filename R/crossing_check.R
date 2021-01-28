crossing_check=function(curveset){
  #Checks if curves are crossing (or in wrong order).

  mat=matrix(0,nrow=dim(curveset)[1],ncol=dim(curveset)[1])
  for(j in 1:dim(curveset)[1]){
    for(k in 1:dim(curveset)[1]){
      if(j<k){
        if(length(is_crossing(curveset[j,],curveset[k,]))>0){
          mat[j,k]=1
        }
      }else if (j>k){
        if(length(is_crossing(curveset[k,],curveset[j,]))>0){
          mat[j,k]=1
        }
      }
    }
  }
  return(mat)
}
