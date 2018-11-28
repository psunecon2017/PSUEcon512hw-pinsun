function [nlogvalue]=optmcfor4(x)
dat=load('hw5.mat');
Mu=[x(1);x(2)];
U=[x(3), x(4);0,x(5)];
rng(1234);
Num=20;
Z=randn(2,Num);
biNorm = repmat(Mu, 1, Num) + U' * Z;
beta=biNorm(1,:);
u=biNorm(2,:);
logv=0;
N=20;
for i=1:N
    sumTT=0;
    for k=1:length(u)
    sumT=0;
    for j=1:length(beta)
    sumT=sumT+...
    1/length(beta)*prod((1+exp(-(beta(j)*...
    dat.data.X(i,:)+x(6)*dat.data.Z(i,:)+u(k)))).^(-dat.data.Y(i,:)).*(exp(-(beta(j)*...
    dat.data.X(i,:)+x(6)*dat.data.Z(i,:)+u(k)))/(1+exp(-(beta(j)*...
    dat.data.X(i,:)+x(6)*dat.data.Z(i,:)+u(k))))).^(1-dat.data.Y(i,:)));
    end
    sumTT=sumTT+1/length(u)*sumT;
    end
    logv=logv+log(sumTT);
end
nlogvalue=-logv/2000;
