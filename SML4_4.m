theta = [1,1,1,1]; 
N = 101;
X = linspace(-1,1,N);
X1 = 4.*X+4;
K = kernel(X,X1,theta)
exp(-(1/2)*X*inv(K)*X')
sqrt((2*pi)^N*det(K))
det(K)
sqrt(2*pi)^N
y = exp(-(1/2)*X*inv(K)*X')/sqrt((2*pi)^N*(det(K)))
% issymmetric(K)
% size(K)
% K = (K + K.') / 2;
% x = mvnrnd(0,K,10)
% zeros(size(X))
% y = mvnpdf(X,zeros(size(X)),K)