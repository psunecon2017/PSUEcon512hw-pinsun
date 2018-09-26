function J = myJac(f, x,y)
    fx = feval(f, x,y);
    J=zeros(length(fx),length(x));  %pre-allocate
    xperturb=x;
    h = max(norm(x), 1)*sqrt(eps);
    for i=1:length(fx)
      xperturb(i)=x(i)+h;
      J(:,i)=(feval(f,xperturb,y)-fx)/h;
      xperturb(i)=x(i);
    end
end