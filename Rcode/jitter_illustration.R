# make figure illustrating current (3.30) Stock Synthesis jitter setup
# 7/12/2019 based on illustration from meeting in Rick's office on 09/21/2016

if(Sys.info()["user"] == "Ian.Taylor"){
  SS_documentation.dir <- 'c:/SS/git/SS_documentation'
}



# arbitrary bounds
Pmin <- 1
Pmax <- 5

zmin <- qnorm(0.001)
## [1] -3.090232
zmax <- qnorm(0.999)
## [1] 3.090232

Pmean <- (Pmin + Pmax) / 2.0

Psigma <- (Pmax - Pmean) / zmax   # this value is the same as (Pmin - Pmean) / zmin;

getNewVal <- function(Pval, n = 1, jitter = 0.1, temp = NULL){
  # Pval is initial value
  # temp is uniform random 0-1 variable
  zval <- (Pval - Pmean) / Psigma;
  kval <- pnorm(zval);

  if(is.null(temp)){
    temp <- runif(n = n, min = 0, max = 1) #randu(radm);
  }

  kjitter <- kval + (jitter * ((2.00 * temp) - 1.)) # kjitter is between kval - jitter and kval + jitter

  zjitter <- qnorm(kjitter) #inv_cumd_norm(kjitter);
  NewVal <- (Psigma * zjitter) + Pmean
  NewVal[kjitter < 0.001] <- Pmin+0.1*(Pval-Pmin)
  NewVal[kjitter > 0.999] <- Pmax-0.1*(Pmax-Pval)

  return(data.frame(zval = zval, kval = kval,
                    temp = temp,
                    kjitter = kjitter,
                    zjitter = zjitter,
                    NewVal = NewVal))
} # end function

Pval1 <- 2.4
jitter <- 0.2
NewVal.info <- getNewVal(Pval1, temp = 0.2, jitter = jitter)


# repeat with vectors
Pval.vec <- seq(Pmin, Pmax, length = 1000)
# corresponding y values
zval.vec <- (Pval.vec - Pmean) / Psigma
kval.vec <- pnorm(zval.vec)

png(file.path(SS_documentation.dir, '/images/jitter_illustration.png'),
    width = 6, height = 5, res = 300, units = 'in', pointsize = 10)
par(mar=c(4,4,1,1))
plot(0,
     xlim = c(0.3,5.2), ylim = c(-0.2, 1),
     type='n', xlab = "Parameter space", ylab = "Transformed space",
     las = 1, axes=FALSE)
lines(Pval.vec, kval.vec, lwd = 3, las = 1)
abline(h = 0, lty=3)
abline(h = 1, lty=3)

points(Pval1, NewVal.info$kval, pch=16, cex=1.0, col=2)
#points(NewVal.info$NewVal, NewVal.info$kjitter, pch=16, cex=1.5)
arrows(x0 = Pval1, y0 = NewVal.info$kval,
       x1 = Pval1, y1 = NewVal.info$kjitter,
       length = 0.1, col=2, lwd=2)
text(x = 3.3, y = 0.6,
     labels = "Cumulative normal\nwith 0.001 and 0.999 quantiles\nset to Min and Max",
     col=1, pos=4)
text(x = Pval1, y = mean(c(NewVal.info$kval, NewVal.info$kjitter)),
     labels = "Random U(-jitter, jitter) value", col=2, pos=4)
text(x = 0.75, y = NewVal.info$kval,
     labels = "Distribution of \ntransformed init + \n  U(-jitter, jitter)",
     col='gray50', pos=4)
text(x = 2.8, y = -0.1,
     labels = "Distribution of \nnew initial values", col='gray50', pos=4)
text(x = 0.2, y = -0.12,
     labels = "Values < 0\nmapped\ninside bound", col='gray50', pos=4)
arrows(x0 = Pval1, y0 = NewVal.info$kjitter,
       x1 = NewVal.info$NewVal, y1 = NewVal.info$kjitter,
       length = 0.1, col=2, lwd=2)
axis(1, at = c(1, Pval1, 5),
     labels = c("Min", "Input\ninit", "Max"),
     padj = 0.5)
axis(1, at = NewVal.info$NewVal,
     labels = "New\ninit",
     col.axis = 'red',
     padj = 0.5)
axis(2, las = 1)

       
test <- getNewVal(Pval1, n=1e7, jitter = jitter)
hist.x <- hist(test$NewVal, plot=FALSE, breaks=50)
segments(x0 = hist.x$mids,
         x1 = hist.x$mids,
         y0 = -0.2,
         y1 = -0.2 + hist.x$density / 5,
       col='gray50', lend = 3, lwd=3)

hist.y <- hist(test$kjitter, plot=FALSE, breaks=20)
segments(x0 = 0.5 + hist.y$density / 10,
         x1 = 0.5,
         y0 = hist.y$mids,
         y1 = hist.y$mids,
         col = 'gray50', lend = 3, lwd=4)
dev.off()

###########################################################################
##### SS source code from SS_objfunc.tpl:
###########################################################################

##  /*  SS_Label_FUNCTION 27 Check_Parm */
## FUNCTION dvariable Check_Parm(const int iparm, const int& PrPH, const double& Pmin, const double& Pmax, const int& Prtype, const double& Pr, const double& Psd, const double& jitter, const prevariable& Pval)
##   {
##     RETURN_ARRAYS_INCREMENT();
##     const double bound=0.001;
##     const dvariable zmin = inv_cumd_norm(bound);    // z value for Pmin
##     const dvariable zmax = inv_cumd_norm((1.0-bound));    // z value for Pmax
##     const dvariable Pmean = (Pmin + Pmax) / 2.0;
##     dvariable NewVal;
##     // dvariable temp;
##     dvariable Psigma, zval, kval, kjitter, zjitter, temp;

##     NewVal=Pval;
##     if((Pmin<=-99 || Pmax>=999) && PrPH>=0)
##       {N_warn++; warning<<" jitter not done unless parameter min & max are in reasonable parameter range "<<Pmin<<" "<<Pmax<<endl;}
##     else if(Pmin>Pmax)
##     {N_warn++; cout<<" EXIT - see warning "<<endl; warning<<" parameter min > parameter max "<<Pmin<<" > "<<Pmax<<" for parm: "<<iparm<<endl; cout<<" fatal error, see warning"<<endl; exit(1);}
##     else if(Pmin==Pmax && PrPH>=0)
##     {N_warn++; warning<<" parameter min is same as parameter max"<<Pmin<<" = "<<Pmax<<" for parm: "<<iparm<<endl;}
##     else if(Pval<Pmin && PrPH>=0)
##     {N_warn++; warning<<" parameter init value is less than parameter min "<<Pval<<" < "<<Pmin<<" for parm: "<<iparm<<endl; NewVal=Pmin;}
##     else if(Pval>Pmax && PrPH>=0)
##     {N_warn++; warning<<" parameter init value is greater than parameter max "<<Pval<<" > "<<Pmax<<" for parm: "<<iparm<<endl; NewVal=Pmax;}
##     else if(jitter>0.0 && PrPH>=0)
##     {
##       // temp=log((Pmax-Pmin+0.0000002)/(NewVal-Pmin+0.0000001)-1.)/(-2.);   // transform the parameter
##       // temp += randn(radm) * jitter;
##       // NewVal=Pmin+(Pmax-Pmin)/(1.+mfexp(-2.*temp));

##       // generate jitter value from cumulative normal given Pmin and Pmax
##       Psigma = (Pmax - Pmean) / zmax;   // Psigma should also be equal to (Pmin - Pmean) / zmin;
      
##       if (Psigma < 0.00001)    // how small a sigma is too small?
##       {
##           N_warn++;
##           cout<<" EXIT - see warning "<<endl;
##           warning<<" in Check_Parm jitter:  Psigma < 0.00001 "<<Psigma<<endl;
##           cout<<" fatal error in jitter, see warning"<<endl; exit(1);
##       }
##       zval = (Pval - Pmean) / Psigma;  //  current parm value converted to zscore
##       kval = cumd_norm(zval);
##       temp=randu(radm);
##       kjitter = kval + (jitter * ((2.00 * temp) - 1.));  // kjitter is between kval - jitter and kval + jitter
##       if (kjitter < bound)
##       {
##           NewVal=Pmin+0.1*(Pval-Pmin);
##       }
##       else if (kjitter > (1.0-bound))
##       {
##           NewVal=Pmax-0.1*(Pmax-Pval);
##       }
##       else
##       {
##           zjitter = inv_cumd_norm(kjitter);
##           NewVal = (Psigma * zjitter) + Pmean;
##       }
##       echoinput<<"jitter (min, max, old, new):  "<<Pmin<<" "<<Pmax<<" "<<Pval<<" "<<NewVal<<endl;
##     }

##     //  now check prior
##     if(Prtype>0)
##     {
##       if(Psd<=0.0) {N_warn++; cout<<"fatal error in prior check, see warning"<<endl; warning<<"FATAL:  A prior is selected but prior sd is zero. Prtype: "<<Prtype<<" Prior: "<<Pr<<" Pr_sd: "<<Psd<<" for parm: "<<iparm<<endl; exit(1);}
##     }

##     RETURN_ARRAYS_DECREMENT();
##     return NewVal;
##   }
