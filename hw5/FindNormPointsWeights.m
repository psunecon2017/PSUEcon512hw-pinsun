function [ ret] = FindNormPointsWeights(wx,mom)
% System of Equations to solve for nodes and weights of point Gaussian
% Quadrature: 
  % Moments 0-5 of the normal distribution are:
  mom1 = mom';
  num1=length(wx)/2;
  %w is the weights, x are the nodes
  w = wx(1:num1); 
  x = wx((num1+1):end)';
  
  % Discrete approximation of moments 0-5 using these nodes and weights.
  rhs = [ w*ones(num1,1), w*x, w*(x.^2), w*(x.^3), w*(x.^4), w*(x.^5) ]';
  
  %Equations we want to solve:
  ret = mom1 - rhs;
end