plotGEV=function(curves,ylim=NULL,textsize=20,yname="Precipitation (mm)",xname="Return period (yr)",legend.name="Duration (min)"){
  durationvec=as.numeric(substr(rownames(curves),5,nchar(rownames(curves))))
  pvec=as.numeric(substr(colnames(curves),3,nchar(colnames(curves))))

  df=data.frame(y=as.vector(curves),dur=rep(durationvec,dim(curves)[2]),pvec=rep(pvec,each=dim(curves)[1]))

  if(is.null(ylim)==TRUE){
    p=ggplot(df, aes(x=pvec, y = y,color=as.factor(dur),group=as.factor(dur))) +
      geom_line(lwd=0.9)+geom_point(cex=2)+scale_color_manual(values=alpha(viridis(dim(curves)[1]),1),name=legend.name)+theme_bw()+xlab(xname)+
      ylab(yname)+ theme(legend.title = element_text(size = textsize),
                         legend.text = element_text(size=textsize),
                         axis.text=element_text(size=textsize)
                         ,axis.title=element_text(size=textsize))
  }else{
    p=ggplot(df, aes(x=pvec, y = y,color=as.factor(dur),group=as.factor(dur))) +
      geom_line(lwd=0.9)+geom_point(cex=2)+scale_color_manual(values=alpha(viridis(dim(curves)[1]),1),name=legend.name)+theme_bw()+xlab(xname)+
      ylab(yname)+ theme(legend.title = element_text(size = textsize),
                         legend.text = element_text(size=textsize),
                         axis.text=element_text(size=textsize)
                         ,axis.title=element_text(size=textsize))+ylim(ylim)

  }

  return(p)

}
