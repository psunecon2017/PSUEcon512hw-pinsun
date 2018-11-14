% Econ 512 homework 4 Pin Sun, Oct, 2018

%% Question 1
%
clear;
close all; 
Num=1e5;
[n, w] = qnwequi(Num, [0 0], [1, 1], 'N');
Sum0=n(:,1).^2+n(:,2).^2;
Pie=4/Num*sum(Sum0(:,1)<=1)
%% Question 2
%
clear;
close all; 
Num=1e5;
[n, w] = qnwequi(Num, [0 0], [1, 1], 'N');
% you are using points from QMC here, but you should have generated NC
% points instead
Pie(:)=Int_simp(@(x) 4*((n(:,1).^2+x.^2)<=1), 0, 1, 1000);
sum(Pie)/Num

%% Question 3
%
clear;
close all; 
Num=1e3;
[n, w] = qnwequi(Num, [0 0], [1, 1], 'N');
Pie=4/Num*sum(sqrt(1-n(:,1).^2))

%% Question 4
%
clear;
close all; 
Pie=Int_simp(@(x) 4*sqrt(1-x.^2), 0, 1, 1000)

%% Question 5
%
clear;
close all; 
seed = 8673310;
rng(seed);
data1=rand(100,2,200);
data2=rand(1000,2,200);
data3=rand(10000,2,200);
Err1=0;
Err2=0;
Err3=0;
Pie1=zeros(200,1);
Pie2=zeros(200,1);
Pie3=zeros(200,1);
for i=1:200
    sum1=data1(:,1,i).^2+data1(:,2,i).^2;
    Pie1(i,1)=4/100*sum(sum1(:,1)<=1);
    Err1=Err1+(Pie1(i,1)-pi)^2/200;
    sum2=data2(:,1,i).^2+data2(:,2,i).^2;
    Pie2(i,1)=4/1000*sum(sum2(:,1)<=1);
    Err2=Err2+(Pie2(i,1)-pi)^2/200;
    sum3=data3(:,1,i).^2+data3(:,2,i).^2;
    Pie3(i,1)=4/10000*sum(sum3(:,1)<=1);
    Err3=Err3+(Pie3(i,1)-pi)^2/200;
end
Err1
Err2
Err3
Num=[100,1000,10000];
Err11=zeros(3,1);
Err21=zeros(3,1);
for i=1:3
    [n, w] = qnwequi(Num(i), [0 0], [1, 1], 'N');
    Pie11=4/Num(i)*sum(sqrt(1-n(:,1).^2));
    Err11(i,1)=(Pie11-pi)^2;
    Pie21=Int_simp(@(x) 4*sqrt(1-x.^2), 0, 1, Num(i));
    Err21(i,1)=(Pie21-pi)^2;
end
Err11
Err21
