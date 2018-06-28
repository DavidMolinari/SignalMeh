
N = length(signal);
covariance = zeros(P+1,1);
for k = 0:P
    covariance(k+1) = signal(k+1:N)'*signal(1:N-k)/N;
end
a = -inv(toeplitz(covariance(1:P)))*covariance(2:P+1);
sigma2 = [1; a]'*covariance;
a = flipud(a);
