% Econ 512 homework 3 Pin Sun, Oct, 2018

%% Question 1
%
clear;
close all; 
dat=load('hw3.mat');
numy=length(dat.y);
fun=@(beta)-sum(-exp(dat.X(:,1)*beta(1)+dat.X(:,2)*beta(2)+ ...
dat.X(:,3)*beta(3)+dat.X(:,4)*beta(4)+dat.X(:,5)*beta(5) ...
+dat.X(:,6)*beta(6))+dat.y(:,1).*(dat.X(:,1)*beta(1)+dat.X(:,2)*beta(2)+ ...
dat.X(:,3)*beta(3)+dat.X(:,4)*beta(4)+dat.X(:,5)*beta(5) ...
+dat.X(:,6)*beta(6)))/numy;
%options = optimset('PlotFcns',@optimplotfval, 'Display','iter');
beta0 = 1/10*ones(6,1);
tic
beta=fminsearch(fun,beta0)
%beta=fminsearch(fun,beta0,options)
toc
%% Question 2
% Broyden Method
clear;
close all;
dat=load('hw3.mat');
beta = 1/100*ones(6,1);
fVal=loglike(dat.y,dat.X,beta')
iJac=inv(myJac('loglike',dat.y,dat.X,beta'));
maxit = 100; 
tol = 1e-6; 
tic
for iter = 1:maxit
    fnorm = norm(fVal);
    %fprintf('iter %d: q(1) = %f, q(2) = %f, norm(f(x)) = %.8f\n', iter, p(1), p(2), norm(fVal));
    if norm(fVal) < tol
        break
    end
    d = - (iJac * fVal);
    beta = beta+d;
    fOld = fVal;
    fVal = loglike(dat.y,dat.X,beta');
    u = iJac*(fVal - fOld);
    iJac = iJac + ( (d - u) * (d'*iJac) )/ (d'*u);
end
toc
beta

%% Question 3
% Computation Method: trust-region-reflective algorithm
clear;
close all; 
dat=load('hw3.mat');
numy=length(dat.y);
fun=@(beta)(-exp(dat.X(:,1)*beta(1)+dat.X(:,2)*beta(2)+ ...
dat.X(:,3)*beta(3)+dat.X(:,4)*beta(4)+dat.X(:,5)*beta(5) ...
+dat.X(:,6)*beta(6))+dat.y(:,1))/numy;
%options = optimset('PlotFcns',@optimplotfval, 'Display','iter');
beta0 =  1/100*ones(6,1);
tic
beta=lsqnonlin(fun,beta0)
toc

%% Question 4

clear;
close all; 
dat=load('hw3.mat');
numy=length(dat.y);
fun=@(beta)sum((-exp(dat.X(:,1)*beta(1)+dat.X(:,2)*beta(2)+ ...
dat.X(:,3)*beta(3)+dat.X(:,4)*beta(4)+dat.X(:,5)*beta(5) ...
+dat.X(:,6)*beta(6))+dat.y(:,1)).^2)/numy;
%options = optimset('PlotFcns',@optimplotfval, 'Display','iter');
beta0 =1/100*ones(6,1);
tic
beta=fminsearch(fun,beta0)
%beta=fminsearch(fun,beta0,options)
toc

%% Question 5
clear;
close all;
a=0.01:0.1:.51;
beta1=zeros(length(a),6);
beta2=beta1;
beta3=beta1;
beta4=beta1;
Tm=zeros(4,length(a));
for i=1:length(a)
    dat=load('hw3.mat');
    
% First Approach

numy=length(dat.y);
fun1=@(beta)-sum(-exp(dat.X(:,1)*beta(1)+dat.X(:,2)*beta(2)+ ...
dat.X(:,3)*beta(3)+dat.X(:,4)*beta(4)+dat.X(:,5)*beta(5) ...
+dat.X(:,6)*beta(6))+dat.y(:,1).*(dat.X(:,1)*beta(1)+dat.X(:,2)*beta(2)+ ...
dat.X(:,3)*beta(3)+dat.X(:,4)*beta(4)+dat.X(:,5)*beta(5) ...
+dat.X(:,6)*beta(6)))/numy;
beta = a(i)*ones(6,1);
tic
beta1(i,:)=fminsearch(fun1,beta);
Tm(1,i)=toc;

% Second Approach

beta =a(i)*ones(6,1);
fVal=loglike(dat.y,dat.X,beta');
iJac=inv(myJac('loglike',dat.y,dat.X,beta'));
maxit = 100; 
tol = 1e-6; 
tic
for iter = 1:maxit
    fnorm = norm(fVal);
    if norm(fVal) < tol
        break
    end
    d = - (iJac * fVal);
    beta = beta+d;
    fOld = fVal;
    fVal = loglike(dat.y,dat.X,beta');
    u = iJac*(fVal - fOld);
    iJac = iJac + ( (d - u) * (d'*iJac) )/ (d'*u);
end
Tm(2,i)=toc;
beta2(i,:)=beta;

% Third Approach

fun3=@(beta)(-exp(dat.X(:,1)*beta(1)+dat.X(:,2)*beta(2)+ ...
dat.X(:,3)*beta(3)+dat.X(:,4)*beta(4)+dat.X(:,5)*beta(5) ...
+dat.X(:,6)*beta(6))+dat.y(:,1))/numy;
beta =  a(i)*ones(6,1);
tic
beta3(i,:)=lsqnonlin(fun3,beta);
Tm(3,i)=toc;

% Fourth Approach

fun4=@(beta)sum((-exp(dat.X(:,1)*beta(1)+dat.X(:,2)*beta(2)+ ...
dat.X(:,3)*beta(3)+dat.X(:,4)*beta(4)+dat.X(:,5)*beta(5) ...
+dat.X(:,6)*beta(6))+dat.y(:,1)).^2)/numy;
beta =a(i)*ones(6,1);
tic
beta4(i,:)=fminsearch(fun4,beta);
Tm(4,i)=toc;

end



