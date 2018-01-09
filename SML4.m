%f = sin(x)
x_prev = 1; 

for i=1:5
   x = x_prev + (1/sin(x_prev)) * cos(x_prev)
   x_prev = x; 
end


phi = [[1,0.3];
       [1,0.44];
       [1,0.46];
       [1,0.6]];
% y = phi(:,2)'
t = [1,0,1,0];
w_prev = [1.0,1.0]';
R = diag(y.*(1.-y));
for i=1:5
%     y.*(1-y)
%     w_prev.*w_prev
%     (phi*w_prev')
%     inv(R)
%     (y-t)
%     z = (phi*w_prev)-(inv(R))*(y-t)';
%     w = inv(phi'*R*phi)*phi'*R*z
%     -(phi*w_prev)
%     exp(  -(phi*w_prev))
%     1+(exp(  -(phi*w_prev)))
%     1/(1+(exp(  -(phi*w_prev))))
    y = 1./(1+exp(-(phi*w_prev)));
    R = diag(y.*(1.-y));
    z = (phi*w_prev)-(inv(R))*(y'-t)';
    w = inv(phi'*R*phi)*phi'*R*z
%     w = w_prev - inv(phi'*R*phi)*phi'*(y'-t)'
    w_prev = w;
end