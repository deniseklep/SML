sigma = [0.14, -0.3,0.0,0.2;
        -0.3, 1.16, 0.2, -0.8;
        0.0, 0.2, 1.0, 1.0;
        0.2,-0.8,1.0,2.0]; 

lambda = inv(sigma)
cov_prior = inv(lambda(1:2,1:2))

m = [1,0,1,2]';
% mean = m(1:2) + sigma(1:2,3:4)*inv(sigma(3:4,3:4))*([0,0]' - m(3:4))

mean_prior = m(1:2) + inv(lambda(1:2,1:2))*lambda(1:2,3:4)*([0,0]'-m(3:4))

mt = mvnrnd(mean_prior,cov_prior)
x1 = -1:0.1:3; 
x2 = -3:0.1:1;
[X,Y] = meshgrid(x1,x2);
x = [X(:),Y(:)];  
pdf = mvnpdf(x,mean_prior',cov_prior');
pdf = reshape(pdf,length(x2),length(x1));
surf(x1,x2,pdf)

covt = [2.0, 0.8;
        0.8, 4.0];
data = mvnrnd(mt,covt,1000);
save('data.txt','data','-ascii')

mean_est = sum(data,1)/1000
% maaktniksuithoejehetnoemt = data-mean_est;
cov_est = zeros(2,2);

for i=1:1000
    cov_est =  cov_est + ((data(i,:)-mean_est)'*(data(i,:)-mean_est));
end
cov_unb = cov_est/999 ;
cov_est = cov_est/1000;

for i=1:1000
    cov_post = inv(inv(cov_prior)+inv(covt));
    mean_post = cov_post * ((inv(covt)*data(i,:)')+(inv(cov_prior)*mean_prior)); 
    cov_prior = cov_post; 
    mean_prior = mean_post;
end


cov_post
mean_post
mt
% 
% X = mvnrnd(mean_post',cov_post',1000);
% posterior = mvnpdf(X,mean_post',cov_post');
% X(find(posterior == max(posterior)))

% posterior = mvnpdf(data, mean_post', cov_post')

mean_map = zeros(1000,2); 
for i=1:1000
   posterior = mvnpdf(data(1:i,:),mean_post',cov_post');
   max_post = find(posterior == max(posterior));
   mean_map(i,:) = data(max_post(1),:);   
end

% data = load('data.txt'); 

mean_mls = zeros(1000,2); 
for i=1:length(data)
    mean_ml = mean_ml + (data(i,:)-mean_ml)/i;
    mean_mls(i,:) = mean_ml;
end

mt(1)

figure;
plot(1:1:1000,mean_mls(:,1),1:1:1000,mean_map(:,1),1:1:1000,mt(1)*ones(1000,1),'k:')


% mean_mls
% mean_map
