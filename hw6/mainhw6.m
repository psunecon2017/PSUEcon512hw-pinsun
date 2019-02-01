% Econ 512 homework 6 Pin Sun, Jan, 2019

%% Question 2
%
clear;
close all;
p0=0.5;
rho=0.5;
sigmau=0.1;
Ngrid=21;
[pprob,pgrid]=tauchen(Ngrid,p0,rho,sigmau)

%% Question 3
%
delta=0.95; % Discount factor
s0=100; % Initial Stock of lumber
Lens=length(s0);
Num=1000;
s=zeros(Lens,Num);
for i=1:Lens
    s(i,:)=linspace(0,s0(i),Num);
end
v=zeros(Num,Ngrid); Tv=v; 
x=zeros(Num,Num,Ngrid);
r=x;
%fv=zeros(Num,Num,Ngrid,Lens);
Replication=1000;
for j=1:Ngrid

    x(:,:,j)=repmat(s(1,:),Num,1)-repmat(s(1,:)',1,Num);

end
x(find(x<0))=1e10;
tic
    for k=1:Replication
    for j=1:Ngrid
        % Tv(:,j,i)=prob(j,:)*v(:,j,i);
        ev=(pprob(j,:)*v(:,:,i)')';
        r(:,:,j)=pgrid(j)*x(:,:,j)-0.2*x(:,:,j).^(3/2)+delta*repmat(ev,1,Num);
        vopt=max(r(:,:,j));
        Tv(:,j)=vopt';
    end
    dif = max(reshape((abs((Tv-v)./v)),Num*Ngrid,1));
    %if mod(k,10)==0
    %formatSpec='at %4.0f th iteration, the dif is %2.4f';
    %fprintf(formatSpec,iter,dif);
    %disp(' ');
    %end
    if dif <1e-4
       break
    else
                v(:,:) = Tv(:,:);
    end
    end
toc
    spolicy=zeros(Num,Ngrid);
    sprime=spolicy;
    for i=1:Ngrid
        [vvalue,sindex]=max(r(:,:,i));
        spolicy(:,i)=sindex';
        v(:,i)=vvalue';
    end
    for i=1:Num
        for j=1:Ngrid
        sprime(i,j)=s(spolicy(i,j));
        end
    end
pindex1=find(abs(pgrid-0.9*ones(1,Ngrid))==min(abs(pgrid-0.9*ones(1,Ngrid))));
pindex2=find(abs(pgrid-ones(1,Ngrid))==min(abs(pgrid-ones(1,Ngrid))));
pindex3=find(abs(pgrid-1.1*ones(1,Ngrid))==min(abs(pgrid-1.1*ones(1,Ngrid))));
figure
subplot(3,1,1)
plot(v(:,pindex1),s(:));
title('p=0.9')
xlabel('Initial Stock')
ylabel('Firm Value')
subplot(3,1,2)
plot(v(:,pindex2),s(:));
title('p=1.0')
xlabel('Initial Stock')
ylabel('Firm Value')
subplot(3,1,3)
plot(v(:,pindex3),s(:));
title('p=1.1')
xlabel('Initial Stock')
ylabel('Firm Value')

% the values are off, I think you misspecified updating

%% Question 4
%
figure
subplot(3,1,1)
index1=10;
plot(sprime(index1,:),pgrid(:));
title(['Current Stock=',num2str(s(index1))])
xlabel('Price')
ylabel('Next Stock')
subplot(3,1,2)
index2=500;
plot(sprime(index2,:),pgrid(:));
title(['Current Stock=',num2str(s(index2))])
xlabel('Price')
ylabel('Next Stock')
subplot(3,1,3)
index3=900;
plot(sprime(index3,:),pgrid(:));
title(['Current Stock=',num2str(s(index3))])
xlabel('Price')
ylabel('Next Stock')

% the policy is also wrong

%% Question 5
%
sit=100;
pit=1;
ep=zeros(1,21);
pq1=ep;
pq2=ep;
sp=zeros(3,21);
sp(:,1)=sit;
ep(1)=pit;
pq1(1)=pit;
pq2(1)=pit;
for i=1:20
    ep(i+1)=p0+rho*ep(i);
    pq1(i+1)=norminv(0.95,ep(i+1),sigmau);
    pq2(i+1)=norminv(0.05,ep(i+1),sigmau);
    pindex1=find(abs(pgrid-ep(i)*ones(1,Ngrid))==min(abs(pgrid-ep(i) ...
        *ones(1,Ngrid))));
    pindex2=find(abs(pgrid-pq1(i)*ones(1,Ngrid))==min(abs(pgrid-pq1(i) ...
        *ones(1,Ngrid))));
    pindex3=find(abs(pgrid-pq2(i)*ones(1,Ngrid))==min(abs(pgrid-pq2(i) ...
        *ones(1,Ngrid))));
    sindex1=find(abs(s-sp(1,i)*ones(1,Num))==min(abs(s-sp(1,i) ...
        *ones(1,Num))));
    sindex2=find(abs(s-sp(2,i)*ones(1,Num))==min(abs(s-sp(2,i) ...
        *ones(1,Num))));
    sindex3=find(abs(s-sp(3,i)*ones(1,Num))==min(abs(s-sp(3,i) ...
        *ones(1,Num))));
    sp(1,i+1)=sprime(sindex1,pindex1);
    sp(2,i+1)=sprime(sindex1,pindex2);
    sp(3,i+1)=sprime(sindex1,pindex3);
end

figure
plot(0:19,sp(1,2:21),'r',0:19,sp(2,2:21),'g',0:19,sp(3,2:21),'g');
xlabel('Period')
ylabel('Next Stock')
legend({'Expected Value','90% Confidence','90% Confidence'},'Location','northeast')

%% Question 6
%

clear;
close all;
p0=0.5;
rho=0.5;
sigmau=0.1;
Ngrid=5;
[pprob,pgrid]=tauchen(Ngrid,p0,rho,sigmau);

delta=0.95;
s0=100; % Initial Stock of lumber
Lens=length(s0);
Num=1000;
s=zeros(Lens,Num);
for i=1:Lens
    s(i,:)=linspace(0,s0(i),Num);
end
v=zeros(Num,Ngrid); Tv=v; 
x=zeros(Num,Num,Ngrid);
r=x;
%fv=zeros(Num,Num,Ngrid,Lens);
Replication=1000;
for j=1:Ngrid

    x(:,:,j)=repmat(s(1,:),Num,1)-repmat(s(1,:)',1,Num);

end
x(find(x<0))=1e10;
tic
    for k=1:Replication
    for j=1:Ngrid
        % Tv(:,j,i)=prob(j,:)*v(:,j,i);
        ev=(pprob(j,:)*v(:,:,i)')';
        r(:,:,j)=pgrid(j)*x(:,:,j)-0.2*x(:,:,j).^(3/2)+delta*repmat(ev,1,Num);
        vopt=max(r(:,:,j));
        Tv(:,j)=vopt';
    end
    dif = max(reshape((abs((Tv-v)./v)),Num*Ngrid,1));
    %if mod(k,10)==0
    %formatSpec='at %4.0f th iteration, the dif is %2.4f';
    %fprintf(formatSpec,iter,dif);
    %disp(' ');
    %end
    if dif <1e-4
       break
    else
                v(:,:) = Tv(:,:);
    end
    end
toc
    spolicy=zeros(Num,Ngrid);
    sprime=spolicy;
    for i=1:Ngrid
        [vvalue,sindex]=max(r(:,:,i));
        spolicy(:,i)=sindex';
        v(:,i)=vvalue';
    end
    for i=1:Num
        for j=1:Ngrid
        sprime(i,j)=s(spolicy(i,j));
        end
    end
pindex1=find(abs(pgrid-0.9*ones(1,Ngrid))==min(abs(pgrid-0.9*ones(1,Ngrid))));
pindex2=find(abs(pgrid-ones(1,Ngrid))==min(abs(pgrid-ones(1,Ngrid))));
pindex3=find(abs(pgrid-1.1*ones(1,Ngrid))==min(abs(pgrid-1.1*ones(1,Ngrid))));
figure
subplot(3,1,1)
plot(v(:,pindex1),s(:));
title('p=0.9')
xlabel('Initial Stock')
ylabel('Firm Value')
subplot(3,1,2)
plot(v(:,pindex2),s(:));
title('p=1.0')
xlabel('Initial Stock')
ylabel('Firm Value')
subplot(3,1,3)
plot(v(:,pindex3),s(:));
title('p=1.1')
xlabel('Initial Stock')
ylabel('Firm Value')

figure
subplot(3,1,1)
index1=10;
plot(sprime(index1,:),pgrid(:));
title(['Current Stock=',num2str(s(index1))])
xlabel('Price')
ylabel('Next Stock')
subplot(3,1,2)
index2=500;
plot(sprime(index2,:),pgrid(:));
title(['Current Stock=',num2str(s(index2))])
xlabel('Price')
ylabel('Next Stock')
subplot(3,1,3)
index3=900;
plot(sprime(index3,:),pgrid(:));
title(['Current Stock=',num2str(s(index3))])
xlabel('Price')
ylabel('Next Stock')