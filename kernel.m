function [ K ] = kernel( x1,x2,theta )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N = size(x1,2);
K = zeros(N);
for i=1:N
   for j=1:N
       
%         x(i)^2-x(j)^2y
%         sum(x(i)^2-x(j)^2)
        K(i,j) = theta(1)*exp(-(theta(2)/2)*(x1(i)'*x1(i)+x2(j)'*x2(j)-2*x1(i)'*x2(j)))+theta(3)+theta(4)*x1(i)'*x2(j);
   end
%    K(i,:) = theta(1)*exp()
end
end

