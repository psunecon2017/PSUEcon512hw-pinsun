% Econ 512 homework 7 Pin Sun, Feb, 2019
%  all is good
%%Question 1
clc;
close all;
clear;
tic;
params;
replication=1e4;
V=5*ones(L,L); % Initial guess for value function 
TV=V;
p=10*ones(L,L); % Initial guess best response
Tp=p;
tic
for i=1:replication
        p2=p;
        W=getW(V);
    for j=1:L
        %for k=1:L
            %Tp(j,k)=fsolve(@(p1)priceFOC_n(W,p1,p2,j,k),8);
        %end
        %options = optimset('TolX', 1e-12, 'TolFun', 1e-12);
        Tp(j,:)=fsolve(@(p1)priceFOC(W,p1,p2,j),10*ones(1,L)); %,options);
        DD=zeros(3,L);
        DD(1,:)=exp(v-(Tp(j,:)))./(1+exp(v-(Tp(j,:)))+exp(v-(p2(:,j)')));
        DD(2,:)=exp(v-(p2(:,j)'))./(1+exp(v-(Tp(j,:)))+exp(v-(p2(:,j)')));
        DD(3,:)=1-DD(1,:)-DD(2,:);
        TV(j,:)=DD(1,:).*(Tp(j,:)-c(j))+beta*(DD(3,:).*W(j,:,1)+ ...
            DD(1,:).*W(j,:,2)+DD(2,:).*W(j,:,3));
    end
    diff=max(max(max(abs((TV-V)./(V)))),  max(max(abs((Tp-p)./(p)))));
    if diff<CRIT
        break;
    else
        %Tp(find(Tp<0))=0;
        V=lambda*TV+(1-lambda)*V;
        p=lambda*Tp+(1-lambda)*p;
    end
end
toc

%% Question 1
figure(1)
mesh(V)
title('Value Function');

%% Question 2
Prob_tran=zeros(L,L); % transition matrix
Prob_tran(1,1,1)=1;
Prob_tran(1,1,2)=1-(1-delta);
Prob_tran(1,2,2)=1-Prob_tran(1,1,2);
Prob_tran(L,L,2)=1;
Prob_tran(L,(L-1),1)=1-(1-delta)^L;
Prob_tran(L,L,1)=1-Prob_tran(L,(L-1),1);
for i=2:(L-1)
    Prob_tran(i,i-1,1)=1-(1-delta)^i;
    Prob_tran(i,i,1)=1-Prob_tran(i,i-1,1);
    Prob_tran(i,i,2)=1-(1-delta)^i;
    Prob_tran(i,i+1,2)=1-Prob_tran(i,i,2);
end
D1=exp(v-p)./(1+exp(v-p)+exp(v-p'));
D2=D1';
Distribution_1=zeros(L,L);
Distribution_1(1,1)=1; % Initial distribution
Distribution_2=Distribution_1;
Distribution_3=Distribution_1;
D01=D2;
D10=D1;
D00=1-D1-D2;
for i=1:10
Distribution_1=(Prob_tran(:,:,1)'*((D00.*Distribution_1)*Prob_tran(:,:,1)))+ ...
       (Prob_tran(:,:,1)'*((D01.*Distribution_1)*Prob_tran(:,:,2)))+ ...
        (Prob_tran(:,:,2)'*((D10.*Distribution_1)*Prob_tran(:,:,1)));
end
figure(2)
mesh(Distribution_1)
title('Distribution of States(t=10)');

for i=1:20
Distribution_2=(Prob_tran(:,:,1)'*((D00.*Distribution_2)*Prob_tran(:,:,1)))+ ...
       (Prob_tran(:,:,1)'*((D01.*Distribution_2)*Prob_tran(:,:,2)))+ ...
        (Prob_tran(:,:,2)'*((D10.*Distribution_2)*Prob_tran(:,:,1)));
    
end
figure(3)
mesh(Distribution_2)
title('Distribution of States(t=20)');
for i=1:30
Distribution_3=(Prob_tran(:,:,1)'*((D00.*Distribution_3)*Prob_tran(:,:,1)))+ ...
       (Prob_tran(:,:,1)'*((D01.*Distribution_3)*Prob_tran(:,:,2)))+ ...
        (Prob_tran(:,:,2)'*((D10.*Distribution_3)*Prob_tran(:,:,1)));
end
figure(4)
mesh(Distribution_3)
title('Distribution of States(t=20)');

%% Question 3

Distribution_steady=ones(L,L)/(L*L);
%Distribution_steady(1,1)=1;
TD=Distribution_steady;
for i=1:replication
    TD=(Prob_tran(:,:,1)'*((D00.*Distribution_steady)*Prob_tran(:,:,1)))+ ...
       (Prob_tran(:,:,1)'*((D01.*Distribution_steady)*Prob_tran(:,:,2)))+ ...
        (Prob_tran(:,:,2)'*((D10.*Distribution_steady)*Prob_tran(:,:,1)));
    if max(max(abs((TD-Distribution_steady))))<1e-4
        break
    else
        Distribution_steady=TD;
    end
end
figure(5)
mesh(Distribution_steady)
title('Staionary Distribution of States');










