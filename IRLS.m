function  [w,z]  = IRLS( phi,t,w_init,iter)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
w_prev = w_init;

for i=1:iter
    y = 1./(1+exp(phi*-w_prev));
    R = diag(y.*(1-y));
    z = phi*w_prev - inv(R)*(y-t);
    w = inv(phi'*R*phi)*phi'*R*z;
    w_prev = w;  
end


end

