plotHistory=function(res_alg,ylim=NULL,legend.name="Durations (min)",textsize=15){
  quantile.history=res_alg$quantile.history

  if(is.null(dim(quantile.history))==TRUE){
    print("The initial posterior medians were consistent. No history to show.")
    return(quantile.history)
  }else{
    changemax=which(apply(((apply(quantile.history,1,as.numeric))),2,max)!=50)
    changemin=which(apply(((apply(quantile.history,1,as.numeric))),2,min)!=50)
    endret=sort(unique(c(changemin,changemax)))

    quantile.history=quantile.history[endret,]

    if(is.null(dim(quantile.history))==TRUE){
      whichdur=names(which(res_alg$quantvec!="50%"))
      df=data.frame(y=as.numeric(as.vector(quantile.history)),it=rep(1:length(quantile.history),each=1),
                    dur=factor(rep(substr(whichdur,5,10),length(quantile.history)),
                               levels = sort(as.numeric(substr(whichdur,5,10)))))
    }else{

    df=data.frame(y=as.numeric(as.vector(quantile.history)),it=rep(1:dim(quantile.history)[2],each=dim(quantile.history)[1]),
                  dur=factor(rep(substr(rownames(quantile.history),5,10),dim(quantile.history)[2]),
                             levels = sort(as.numeric(substr(rownames(quantile.history),5,10)))))
    }



    if(is.null(ylim)==TRUE){

      if(is.null(dim(quantile.history))==TRUE){
        p=ggplot(df, aes(x=it, y = y,color=(dur),group=(dur))) +
          geom_line(lwd=1)+scale_color_manual(values=plasma(1),name=legend.name)+theme_bw()+xlab("Iteration")+
          ylab("Quantile chosen")+ theme(legend.title = element_text(size = textsize),
                                         legend.text = element_text(size=textsize),
                                         axis.text=element_text(size=textsize)
                                         ,axis.title=element_text(size=textsize))+ylim(c(0,100))
      }else{
      p=ggplot(df, aes(x=it, y = y,color=(dur),group=(dur))) +
        geom_line(lwd=1)+scale_color_manual(values=plasma(dim(quantile.history)[1]),name=legend.name)+theme_bw()+xlab("Iteration")+
        ylab("Quantile chosen")+ theme(legend.title = element_text(size = textsize),
                                       legend.text = element_text(size=textsize),
                                       axis.text=element_text(size=textsize)
                                       ,axis.title=element_text(size=textsize))+ylim(c(0,100))

      }
    }else{

      if(is.null(dim(quantile.history))==TRUE){
        p=ggplot(df, aes(x=it, y = y,color=(dur),group=(dur))) +
          geom_line(lwd=1)+scale_color_manual(values=plasma(1),name=legend.name)+theme_bw()+xlab("Iteration")+
          ylab("Quantile chosen")+ theme(legend.title = element_text(size = textsize),
                                         legend.text = element_text(size=textsize),
                                         axis.text=element_text(size=textsize)
                                         ,axis.title=element_text(size=textsize))+ylim(ylim)
      }else{
      p=ggplot(df, aes(x=it, y = y,color=as.factor(dur),group=as.factor(dur))) +
        geom_line(lwd=1)+scale_color_manual(values=plasma(dim(quantile.history)[1]),name=legend.name)+theme_bw()+xlab("Iteration")+
        ylab("Quantile chosen")+ theme(legend.title = element_text(size = textsize),
                                       legend.text = element_text(size=textsize),
                                       axis.text=element_text(size=textsize)
                                       ,axis.title=element_text(size=textsize))+ylim(ylim)
      }
    }

    return(p)
  }
}
