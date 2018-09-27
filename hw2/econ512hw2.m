% Econ 512 homework 2 Pin Sun
%% Problem 2^M
clear;
close all;
p=[1;1];
v=[2;2];
fVal=betrand(p,v);
iJac=inv(myJac('betrand',p,v));
maxit = 100; 
tol = 1e-6; 
tic
for iter = 1:maxit
    fnorm = norm(fVal);
    fprintf('iter %d: q(1) = %f, q(2) = %f, norm(f(x)) = %.8f\n', iter, p(1), p(2), norm(fVal));
    if norm(fVal) < tol
        break
    end
    d = - (iJac * fVal);
    p = p+d;
    fOld = fVal;
    fVal = betrand(p,v);
    u = iJac*(fVal - fOld);
    iJac = iJac + ( (d - u) * (d'*iJac) )/ (d'*u);
end
toc

%% Problem 3^M

clear; close all;
v=[2;2];
f1=@(p) 1-p(1)*(1-exp(v(1)-p(1))/(1+exp(v(1)-p(1))+exp(v(2)-p(2)))); 
f2=@(p) 1-p(2)*(1-exp(v(2)-p(2))/(1+exp(v(1)-p(1))+exp(v(2)-p(2))));
p=[1;1];
pold=[0.5;0.5];
f1Old=f1(pold);
f2Old=f2(pold);
tol = 1e-8;
maxit = 100;
pNew=zeros(2,1);
tic
for iter =1:maxit
    fVal1=f1(p);
    fVal2=f2(p);
    fprintf('iter %d: p(1) = %.8f, p(2) = %.8f,f1(p) = %.8f\n, f2(p)=%.8f \n',...
    iter, p(1,1),p(2,1), fVal1,fVal2);
    if norm([fVal1;fVal2]) < tol
        break
    else
        pNew(1,1) = p(1,1) - ( (p(1,1) - pold(1,1)) / (fVal1 - f1Old)...
        )* fVal1;
        pNew(2,1) = p(2,1) - ( (p(2,1) - pold(2,1)) / (fVal2 - f2Old)...
        )* fVal2;
        pold = p;
        p = pNew;
        f1Old = fVal1;  
        f2Old = fVal2;     
    end
end
toc

%% Problem 4^M

clear; close all;
v=[2;2];
f1=@(p) (1-exp(v(1)-p(1))/(1+exp(v(1)-p(1))+exp(v(2)-p(2)))); 
f2=@(p) (1-exp(v(2)-p(2))/(1+exp(v(1)-p(1))+exp(v(2)-p(2))));
p=[1;1];
pnew=zeros(2,1);
maxit = 100; 
tol = 1e-6; 
tic
for iter =1:maxit
  fVal1=f1(p);
  fVal2=f2(p);
  fprintf('iter %d: p(1) = %.8f, p(2) = %.8f,f1(p) = %.8f\n, f2(p)=%.8f \n', ...
  iter, p(1,1),p(2,1), fVal1, fVal2);
    pnew(1,1)=1/fVal1;
    % p1=[pnew(1,1),p(2,1)];
    %pnew(2,1)=1/f2(p1);
    pnew(2,1)=1/fVal2;
    if norm(p-pnew) < tol
        break
        else
        p=pnew;
    end  
end
toc

%% Problem 5^M
% Broyden method
%clear; clc; close all;
%vB=0:.2:3;
%numB=length(vB);
%maxit=100;
%p=zeros(2,numB);
%tol = 1e-6; 
%tic
%for i=1:numB
%  p1=[1;1];
 % for 
%end
% Gauss method
clear; clc; close all;
vB=0:.2:3;
numB=length(vB);
maxit=100;
p=zeros(2,numB);
tol = 1e-6; 
tic
for i=1:numB
  p1=[0.5;1];
  pold=[0.2;0.5];
  pnew=zeros(2,1);
  v=[2,vB(i)];
  f1=@(p) 1-p(1)*(1-exp(v(1)-p(1))/(1+exp(v(1)-p(1))+exp(v(2)-p(2)))); 
  f2=@(p) 1-p(2)*(1-exp(v(2)-p(2))/(1+exp(v(1)-p(1))+exp(v(2)-p(2))));
  f1Old=f1(pold);
  f2Old=f2(pold);
  for j=1:maxit
    fVal1=f1(p1);
    fVal2=f2(p1);
  if norm([fVal1;fVal2]) < tol
    p(1,i)=p1(1,1);
    p(2,i)=p1(2,1);
        break
    else
        pNew(1,1) = p1(1,1) - ( (p1(1,1) - pold(1,1)) / (fVal1 - f1Old)...
        )* fVal1;
        pNew(2,1) = p1(2,1) - ( (p1(2,1) - pold(2,1)) / (fVal2 - f2Old)...
        )* fVal2;
        pold = p1;
        p1 = pNew;
        f1Old = fVal1;  
        f2Old = fVal2;     
    end
    end
end
toc
plot(vB(:),p(1,:),vB(:),p(2,:))
legend('A price','B Price')


% final method (not good)

%clear; clc; close all;

%vB=0:.2:3;
%numB=length(vB);
%maxit=100;
%p=zeros(2,numB);
%tol = 1e-6; 
%tic
%for i=1:numB
%  p1=[0.5;1];
 % pnew=zeros(2,1);
%  v=[2,vB(i)];
%  f1=@(p) (1-exp(v(1)-p(1))/(1+exp(v(1)-p(1))+exp(v(2)-p(2)))); 
%  f2=@(p) (1-exp(v(2)-p(2))/(1+exp(v(1)-p(1))+exp(v(2)-p(2))));
 % for j=1:maxit
%    fVal1=f1(p1);
%    fVal2=f2(p1);
%    pnew(1,1)=1/fVal1;
    % p1=[pnew(1,1),p(2,1)];
    %pnew(2,1)=1/f2(p1);
 %   pnew(2,1)=1/fVal2;
  %  if norm(p1-pnew) < tol
  %    p(1,i)=p1(1,1);
  %    p(2,i)=p1(2,1);
  %      break
 %       else
 %       p1=pnew;
 %   end   
%  end
%end
%toc

%figure 
%[x,y,z]=meshgrid(p(1,:),p(2,:),vB(:,1)');
%mesh(x,y,z)






