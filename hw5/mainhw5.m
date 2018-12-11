% Econ 512 homework 4 Pin Sun, Nov, 2018

%% Question 1
%
clear;
close all; 
dat=load('hw5.mat');
% Moments
m0=1;
m1=0.1;
m2=1+m1^2;
m3=m1^3+3*m1;
m4=m1^4+6*m1^2+3;
m5=m1^5+10*m1^3+15*m1;
mom=[m0,m1,m2,m3,m4,m5];
x0=[ones(1,20)/20, -2.7:0.3:3];
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
    dat.data.X(i,:)))).^(-dat.data.Y(i,:)).*(exp(-(beta(j)*...
    dat.data.X(i,:)))/(1+exp(-(beta(j)*...
    dat.data.X(i,:))))).^(1-dat.data.Y(i,:)));
    end
    logv=logv+log(sumT);
end
logv
% this if incorrect answer, try checking what is wrong with your
% loglikelihood function
%% Question 2
%
clear;
close all; 
dat=load('hw5.mat');
rng(1234);
beta=randn(100,1)+0.1*ones(100,1);
beta=beta';
sumT=0;
N=20;
logv=0;
for i=1:N
    sumT=0;
    for j=1:length(beta)
    sumT=sumT+...
    1/length(beta)*prod((1+exp(-(beta(j)*...
    dat.data.X(i,:)))).^(-dat.data.Y(i,:)).*(exp(-(beta(j)*...
    dat.data.X(i,:)))/(1+exp(-(beta(j)*...
    dat.data.X(i,:))))).^(1-dat.data.Y(i,:)));
    end
    logv=logv+log(sumT);
end
logv
% again, something is wrong with the computation of the loglikelihood
%% Question 3
%
clear;
close all;
para0=[0.1,1,0];
A=[0,-1,0];
b=0;
[para1,nlog1]=fmincon(@(x)optgq(x),para0,A,b);
[para2,nlog2]=fmincon(@(x)optmc(x),para0,A,b);
para1
logv1=-2000*nlog1
para2
logv2=-2000*nlog1
% parameter estimates are wrong, I suspect because of the mistake in the
% function computation. the paremeter estimates resulting from different
% techniques should be very close to one another
%% Question 4
%
clear;
close all; 
para0=[0.1,0.1,0.1,0.1,0.2,0.3];
[para,nlog]=fminsearch(@(x)optmcfor4(x),para0);
beta0=para(1)
beta1=para(2)
sigma_beta=abs(para(3))
sigma_u=sqrt(para(4)^2+para(5)^2)
sigma_ubeta=para(3)*para(4)
gamma=para(6)
logval=-nlog*2000
%% Question 5
%