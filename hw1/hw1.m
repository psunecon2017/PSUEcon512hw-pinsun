% use double percent marks to divide into sections

% Econ512 homework 1 Pin Sun

%% Problem 1

X=[1 1.5 3 4 5 7 9 10];
Y1=-1+0.5*X;
Y2=-2+0.5*X.^2;
plot(X,Y1,X,Y2);
legend('Y1=-1+0.5X','Y2=-2+0.5X^2')

%% Problem 2

X=linspace(-10,20,200)';
sum(X)

%% Problem 3
A=[2 4 6; 1 7 5; 3 12 4];
b=[-2;3;10];
C=A'*b
AA=A'*A;
D=AA\b
Ab=A'*b;
E=sum(Ab)
F=A;
F(:,3)=[];
F(2,:)=[];
F
% Gauss-Seidel method ( cannot use it because here it is not a contraction mapping)
%Q=tril(A);
%x=[1;1;1]; % initial guessing
%maxit=100;
%tol=1e-5;
%for it = 1:maxit
  %  dx = Q\(b - A*x);
   % x = x + dx;
   % if norm(dx) < tol 
   %     fprintf('Converged: x(1) = %.4f, iter = %d\n', x(1), it);
   %     break
    %end
   % if mod(it, 1)==0
   %     fprintf('it: %d \t norm(dx) = %.4f\n', it, norm(dx)); 
   % end
%end
%norm(eye(4)-Q\A)
x=A\b

%% Problem 4
B=blkdiag(A,A,A,A,A)
% better to use kron() function as it's faster and saves space

%B=blkdiag(diag(diag(A)),diag(diag(A)),diag(diag(A)), ...
%diag(diag(A)),diag(diag(A)))

%% Problem 5
%rng(100);
A=normrnd(10,5,[5,3]);
[n,m]=size(A);
% see answer key, it can be done with much less code
for i=1:n
  for j=1:m
    if A(i,j)<10 
      A(i,j)=0;
      else
      A(i,j)=1;
      end
      end
end
A 
%% Problem 6

% csvread replaces NaN with zero, it makes the estimates of coefficients a
% little biased

data0=csvread('datahw1.csv');
[numr,numc]=size(data0);
%num1=numr/4; 
%for i=1:num1
  %d1=(i-1)*4+1;
  %d2=i*4;
  %if data0(d1,2)~=89 || data0(d2,2)~=93
   % fprintf('The panel data is not balanced')
   % break
   % end
%end
data1=ones(numr,4);
data2=zeros(numr,1);
for i=1:numr
  data1(i,2)=data0(i,3);
  data1(i,3)=data0(i,4);
  data1(i,4)=data0(i,6);
  data2(i,1)=data0(i,5);
end
XX=data1'*data1;
%Q=tril(XX);
betahat=XX\data1'*data2; 
err2hat=sum((data2-data1*betahat)'*(data2-data1*betahat))/(numr-4);
varbetahat=XX\(err2hat*eye(4));
stdbetahat=sqrt(varbetahat)

%b=eye(4);
%mL = eye(size(XX));
%mU = XX;
%nEq = length(b);
%for c = 1:nEq-1
 %   for r = c+1:nEq
 %       mL(r,c) =  mU(r,c)/mU(c,c);
 %       mU(r,:) =  mU(r,:) - mU(c,:)*mL(r,c);
        %[mU; mL]; %Output Suprressed
 %   end
%end
%y = mL\b;
%mx = mU\y





















 

