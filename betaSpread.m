function [sumXY, areaCurve]= betaSpread(meanPSF_G, fS)
%fS=filter size, set up so default=6 in future versions
%check to see if this function is available anywhere else and compare
%currently ignoring anything less than zero, double check necessity of this


%fS=6;
sqSz=(fS*2+1)*(fS*2+1);
psf1=meanPSF_G(1:sqSz);
psf1=reshape(psf1, fS*2+1,fS*2+1);


psf1(psf1<0)=0;
sumXY=[];
for i=1:(fS*2+1)
    for j=1:(fS*2+1)
        sumXY(i,j)=psf1(i,j)*((i-(fS+1))^2+(j-(fS+1))^2);
    end
end

sumXY=sum(sumXY(:))/sum(psf1(:));

sigma=round(sumXY^.5);
psf_t=psf1((fS+1-sigma):(fS+1+sigma),(fS+1-sigma):(fS+1+sigma));
areaCurve=sum(psf_t(:));

end
