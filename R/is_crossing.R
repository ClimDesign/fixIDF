is_crossing=function(vec.min,vec.max){
  #Check if vec.min is larger than vec.max. This is done element wise.

  return(which(vec.min>vec.max))
}
