compute_ret_level=function(location,scale,shape,ret.per){
 zGumbel=c()
 zGEV=c()

 gumbelind=which(shape==0)
 if(length(gumbelind)>0){
 locationGumbel=location[gumbelind]
 scaleGumbel=scale[gumbelind]
 zGumbel=locationGumbel-scaleGumbel*log(-log(1-1/ret.per))
 }

 GEVind=which(shape!=0)

 if(length(GEVind)>0){
   locationGEV=location[GEVind]
   scaleGEV=scale[GEVind]
   shapeGEV=shape[GEVind]
   zGEV=locationGEV-(shapeGEV/scaleGEV)^{-1}*(1-(-log(1-1/ret.per))^{-shapeGEV})
 }

 zall=rep(0,length(location))
 if(length(gumbelind)>0){
    zall[gumbelind]=zGumbel
 }

 if(length(GEVind)>0){
   zall[GEVind]=zGEV
 }

return(zall)
}


#compute_ret_level=function(location,scale,shape,ret.per){
 # z=c()

  #for(j in 1:length(location)){
  #if(shape[j]==0){
   # z=c(z,location[j]-scale[j]*log(-log(1-1/ret.per)))

#  }else{
 #   z=c(z,location[j]-(shape[j]/scale[j])^{-1}*(1-(-log(1-1/ret.per))^{-shape[j]}))
  #}
  #}

#return(z)
#}
