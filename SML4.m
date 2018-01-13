%f = sin(x)
data = load('a010_irlsdata.txt','-ASCII');
X = data(:,1:2); C = data(:,3); 

x_prev = 1; 
for i=1:5
   x = x_prev + (1/sin(x_prev)) * cos(x_prev);
   x_prev = x; 
end


phi = [[1,0.3];
       [1,0.44];
       [1,0.46];
       [1,0.6]];
t = [1,0,1,0]';
w_prev = [1.0,1.0]';
[w,z] = IRLS(phi,t,w_prev,5);

% db = (-log((1./y)-1)/w_prev)
% y = 1./(1+exp(-([1,0.45]*w_prev))); %decision boundary
% just a random set as an example
% x = randn(1000,2);
% "class probabilities"
% cl = 1./(1+exp(-x(:,1))); 

% this seems to work
mycolormap = colormap('Jet');
d64 = [0:63]/63; % 
c = interp1(d64, mycolormap,C);
dotsize = 10;
scatter(X(:,1),X(:,2),dotsize,c,'fill');
xlabel('x_1');
ylabel('x_2');
title('a nice scatterplot');
colorbar; % what do the colors mean?

phi = ones([size(X,1),3]);
phi(:,2:3) = X;
w_init = [0,0,0]';
[w,z] = IRLS(phi,C,w_init,5);
z = sign(sign(z)+1); 

figure()
mycolormap = colormap('Jet');
d64 = [0:63]/63; % 
c = interp1(d64, mycolormap,z);
dotsize = 10;
scatter(X(:,1),X(:,2),dotsize,c,'fill');
xlabel('x_1');
ylabel('x_2');
title('a nice scatterplot');
colorbar; % what do the colors mean?

covar = 0.2*eye(2);
m1 = [0,0];
m2 = [1,1];
% phi1 = mvnrnd(m1,covar,100)
% phi2 = mvnrnd(m2,covar,100)
% phi = [phi1;phi2]

phi1 = zeros([size(X(:,1)),1]);
phi2 = zeros([size(X(:,1)),1]);

for i=1:size(X(:,1))
    phi1(i) = exp(-X(i,:)*covar*X(i,:)'+m1*X(i,:)');
    phi2(i) = exp(-X(i,:)*covar*X(i,:)'+m2*X(i,:)');
end

phi = [phi1,phi2];

figure()
mycolormap = colormap('Jet');
d64 = [0:63]/63; % 
c = interp1(d64, mycolormap,z);
dotsize = 10;
scatter(phi(:,1), phi(:,2),dotsize);
xlabel('phi_1');
ylabel('phi_2');
title('a very extremely nice scatterplot');
colorbar; % what do the colors mean? 

phi3 = ones([1000,3]);
phi3(:,2:3) = phi;

[w,z] = IRLS(phi3,C,w_init,5);

X = load('a011_mixdata.txt', '-ASCII');
figure()
hist(X(4));
figure()
scatter(X(:,1), X(:,4));
figure()
scatter3(X(:,1), X(:,2), X(:,4));

K=2;
EM2(X,K)
