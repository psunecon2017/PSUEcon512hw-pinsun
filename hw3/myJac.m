function J = myJac(f,y,X,beta)
    fbeta = feval(f,y,X,beta);
    J=zeros(length(fbeta),length(beta));  %pre-allocate
    betaperturb=beta;
    h = max(norm(beta), 1)*sqrt(eps);
    for i=1:length(fbeta)
      betaperturb(i)=beta(i)+h;
      J(:,i)=(feval(f,y,X,betaperturb)-fbeta)/h;
      betaperturb(i)=beta(i);
    end
end
