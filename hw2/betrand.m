function [fval fjac]=betrand(p,v)
  
  % Evaluate function:
  DA=exp(v(1)-p(1))/(1+exp(v(1)-p(1))+exp(v(2)-p(2)));
  DB=exp(v(2)-p(2))/(1+exp(v(1)-p(1))+exp(v(2)-p(2)));
  fval(1)=1-p(1)*(1-DA);
  fval(2)=1-p(2)*(1-DB);
  fval=fval';
  % Evaluate Jacobian:
  fjac(1)=-(1-DA)-p(1)*DA*(1-DA);
  fjac(2)=-(1-DB)-p(2)*DB*(1-DB);