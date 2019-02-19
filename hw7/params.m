clear;

global L rho kappa fL v delta beta CRIT c lambda;

L=30; % number of know-how level
rho=0.85; % learning parameter
kappa=10; % cost parameter
fL=15; % initial level for flat cost
v=10; % Quality
delta=0.03; % Depreciation 
beta=1/1.05; % Discount rate
CRIT=1e-4; 
lambda=0.95; % for dampening step

eta=log(rho)/log(2); % learning curve papameters
c=zeros(L,1); % cost
c(1:(fL-1))=kappa*(1:(fL-1)).^eta;
c(fL:L)=kappa*(fL*ones(L-fL+1,1)).^eta;

