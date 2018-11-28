function [nlogvalue]=optgq(y)
dat=load('hw5.mat');
% Moments
m0=1;
m1=y(1);
m2=y(2)^2+m1^2;
m3=m1^3+3*m1*y(2)^2;
m4=m1^4+6*m1^2*y(2)^2+3*y(2)^4;
m5=m1^5+10*m1^3*y(2)^2+15*m1*y(2)^4;
mom=[m0,m1,m2,m3,m4,m5];
x0=[ones(1,20)/20, linspace(-1.7,2,20)];
options=optimset('Algorithm','Levenberg-Marquardt');
wbeta = fsolve(@(x)FindNormPointsWeights(x,mom), x0,options);
w=wbeta(1:length(x0)/2);
beta=wbeta((length(x0)/2+1):end);
N=20;
logv=0;
for i=1:N
    sumT=0;
    for j=1:length(w)
    sumT=sumT+...
    w(j)*prod((1+exp(-(beta(j)*...
    dat.data.X(i,:)+y(3)*dat.data.Z(i,:)))).^(-dat.data.Y(i,:)).*(exp(-(beta(j)*...
    dat.data.X(i,:)+y(3)*dat.data.Z(i,:)))/(1+exp(-(beta(j)*...
   dat.data.X(i,:)+y(3)*dat.data.Z(i,:))))).^(1-dat.data.Y(i,:)));
    end
    logv=logv+log(sumT);
end
nlogvalue=-logv/2000;

