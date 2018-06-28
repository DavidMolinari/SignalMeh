function a = calcul_predicteur_court(signal, P)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul des coefficients du filtre prédicteur à court terme         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code à usage pédagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entrées/sorties                                         %
% signal = vecteur Nx1 réel = une trame de signal                    %
% P = scalaire entier positif = odre de prédiction                   %
% a = [aP ... a1] = vecteur Px1 réel = coefficients du prédicteur    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = length(signal);
covariance = zeros(P+1,1);
for k = 0:P
    covariance(k+1) = signal(k+1:N)'*signal(1:N-k)/N;
end
a = -inv(toeplitz(covariance(1:P)))*covariance(2:P+1);
sigma2 = [1; a]'*covariance;
a = flipud(a);
