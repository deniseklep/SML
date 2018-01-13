function [ mu_k,sigma_k, pi_k ] = EM2( X,K )
    N = size(X(1,:),1);
    mu_k = zeros(K,4);
    sigma_k = zeros(K,4,4);
    pi_k = 1/K*ones(K,1);
    for i=1:K
        mu_k(i,:) = [((mean(X(:,1))+1)-(mean(X(:,1)-1))).*rand()+(mean(X(:,1))-1);
                     ((mean(X(:,2))+1)-(mean(X(:,2)-1))).*rand()+(mean(X(:,2))-1);
                     ((mean(X(:,3))+1)-(mean(X(:,3)-1))).*rand()+(mean(X(:,3))-1);
                     ((mean(X(:,4))+1)-(mean(X(:,4)-1))).*rand()+(mean(X(:,4))-1)];
        
        sigma_k(i,:,:) = eye(4).*(4*rand()+2);
        

    end
    
    logl=0;
    for i=1:size(X(:,1),1)
       ll =0;
        for k=1:K
            ll = ll + pi_k(k).*exp(-X(i,:)*reshape(sigma_k(k,:,:),[4,4])*X(i,:)'+mu_k(k,:)*X(i,:)');
        end
       logl = logl +  log(ll);
    end
    
    for i=1:40
        gamma = zeros([N,K]);
        for j=1:size(X(:,1),1)
            pi_j = 0;
            for k=1:K
                pi_j = pi_j + pi_k(k).*exp(-X(j,:)*reshape(sigma_k(k,:,:),[4,4])*X(j,:)'+mu_k(k,:)*X(j,:)');
%                 gamma = pi_k(k)*(exp(-X'*sigma_k*X + mu_k'*X))
                
            end
            for k=1:K
                gamma(j,k) = pi_k(k).*exp(-X(j,:)*reshape(sigma_k(k,:,:),[4,4])*X(j,:)'+mu_k(k,:)*X(j,:)') / pi_j ;
            end
           
        end
        
        for k=1:K
           N_k = sum(gamma(:,k));
           mu_k(k,:) = (1/N_k) .* (sum(gamma(:,k).*X));
           sigma_k(k,:,:) = 0;
           for j=1:size(X(:,1))
                sigma_k(k,:,:) = reshape(sigma_k(k,:,:),[4,4]) + gamma(j,k).*((X(j,:)-mu_k(k,:))'*(X(j,:)-mu_k(k,:)));
           end
           sigma_k(k,:,:) = sigma_k(k,:,:)./N_k;
           pi_k(k) = N_k/N;
        end
        
        logl=0;
        for j=1:N
           ll =0;
            for k=1:K
                ll = ll + pi_k(k).*exp(-X(j,:)*reshape(sigma_k(k,:,:),[4,4])*X(j,:)'+mu_k(k,:)*X(j,:)');
            end
           logl = logl +  log(ll);
        end
        logl;
    end
%     scatter(mu_k(:,1), mu_k(:,2), 20, 'green');
    size(gamma)
    [m,z] = max(gamma,[],2);
    z = z/K; 
%     z = reshape(z)
    size(z)
%     z
    figure()
    mycolormap = colormap('Jet');
    d64 = [0:63]/63; % 
    c = interp1(d64, mycolormap,z);
    dotsize = 10;
    scatter(X(:,1), X(:,2),dotsize,c;
end

