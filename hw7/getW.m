function W=getW(Vin)

global L rho kappa fL v delta beta CRIT c;

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
cont=zeros(L,L,3);
%for w_1=1:L
    %for w_2=1:L
        cont(:,:,1)=Prob_tran(:,:,1)*(Vin*Prob_tran(:,:,1)');
        cont(:,:,2)=Prob_tran(:,:,2)*(Vin*Prob_tran(:,:,1)');
        cont(:,:,3)=Prob_tran(:,:,1)*(Vin*Prob_tran(:,:,2)');
    %end
%end
%for w_1=1:L
    %for w_2=1:L
      %  cont(w_1,w_2,1)=Prob_tran(w_1,:,1)*(Vin*Prob_tran(w_2,:,1)');
      %  cont(w_1,w_2,2)=Prob_tran(w_1,:,2)*(Vin*Prob_tran(w_2,:,1)');
      %  cont(w_1,w_2,3)=Prob_tran(w_1,:,1)*(Vin*Prob_tran(w_2,:,2)');
   % end
%end
W=cont;