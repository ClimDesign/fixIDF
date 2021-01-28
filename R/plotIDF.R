plotIDF=function(curves,ylim=NULL,textsize=20,yname="Precipitation (mm)",xname="Duration (min)",legend.name="Return period (yr)"){
  durationvec=as.numeric(substr(rownames(curves),5,nchar(rownames(curves))))
  pvec=as.numeric(substr(colnames(curves),3,nchar(colnames(curves))))

  df=data.frame(y=as.vector(curves),dur=rep(durationvec,dim(curves)[2]),pvec=rep(pvec,each=dim(curves)[1]))

  if(is.null(ylim)==TRUE){
    p=ggplot(df, aes(x=dur, y = y,color=as.factor(pvec),group=as.factor(pvec))) +
      geom_line(lwd=1)+geom_point(cex=2)+scale_color_manual(values=viridis(dim(curves)[2]),name=legend.name)+theme_bw()+xlab(xname)+
      ylab(yname)+ theme(legend.title = element_text(size = textsize),
                         legend.text = element_text(size=textsize),
                         axis.text=element_text(size=textsize)
                         ,axis.title=element_text(size=textsize))
  }else{
    p=ggplot(df, aes(x=dur, y = y,color=as.factor(pvec),group=as.factor(pvec))) +
      geom_line(lwd=1)+geom_point(cex=2)+scale_color_manual(name=legend.name,values=viridis(dim(curves)[2]))+theme_bw()+xlab(xname)+
      ylab(yname)+ylim(ylim)+ theme(legend.title = element_text(size = textsize),
                                    legend.text = element_text(size=textsize),
                                    axis.text=element_text(size=textsize),
                                    axis.title=element_text(size=textsize))

  }

  return(p)
}
