function [nlogvalue]=optmc(x)
dat=load('hw5.mat');
rng(1234);
beta=randn(100,1)*x(2)+x(1)*ones(100,1);
beta=beta';
logv=0;
N=20;
for i=1:N
    sumT=0;
    for j=1:length(beta)
    sumT=sumT+...
    1/length(beta)*prod((1+exp(-(beta(j)*...
    dat.data.X(i,:)+x(3)*dat.data.Z(i,:)))).^(-dat.data.Y(i,:)).*(exp(-(beta(j)*...
    dat.data.X(i,:)+x(3)*dat.data.Z(i,:)))/(1+exp(-(beta(j)*...
   dat.data.X(i,:)+x(3)*dat.data.Z(i,:))))).^(1-dat.data.Y(i,:)));
    end
    logv=logv+log(sumT);
end
nlogvalue=-logv/2000;