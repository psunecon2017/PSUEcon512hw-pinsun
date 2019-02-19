function rd=priceFOC(W,p,p2,index)
global L rho kappa fL v delta beta CRIT c lambda;
D=zeros(L,3);
for i=1:L
D(i,2)=exp(v-p(i))/(1+exp(v-p(i))+exp(v-(p2(i,index))));
D(i,3)=exp(v-p2(i,index))/(1+exp(v-p(i))+exp(v-(p2(i,index))));
D(i,1)=1-D(i,2)-D(i,3);
end
rd0=zeros(L,1);
  %  rd0(:)=1-(1-D(:,2)).*(p(:)-c(index)) ...
   %     -beta*W(index,:,2)'+beta*(D(:,1).*W(index,:,1)'+ ...
    %    D(:,2).*W(index,:,2)'+D(:,3).*W(index,:,3)');
for i=1:L
  rd0(i)=1-(1-D(i,2))*(p(i)-c(index)) ...
       -beta*W(index,i,2)+beta*(D(i,1)*W(index,i,1)+ ...
        D(i,2)*W(index,i,2)+D(i,3)*W(index,i,3));
end
%for i=1:L
  % rd0(i)=D(i,2)*(p(i)-c(index)) ...
   %    +beta*(D(i,1).*W(index,i,1)+ ...
    %    D(i,2).*W(index,i,2)+D(i,3).*W(index,i,3));
%end
rd=rd0;