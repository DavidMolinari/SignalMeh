function a = calcul_predicteur_court(signal, P)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul des coefficients du filtre pr�dicteur � court terme         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code � usage p�dagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entr�es/sorties                                         %
% signal = vecteur Nx1 r�el = une trame de signal                    %
% P = scalaire entier positif = odre de pr�diction                   %
% a = [aP ... a1] = vecteur Px1 r�el = coefficients du pr�dicteur    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = length(signal);
covariance = zeros(P+1,1);
for k = 0:P
    covariance(k+1) = signal(k+1:N)'*signal(1:N-k)/N;
end
a = -inv(toeplitz(covariance(1:P)))*covariance(2:P+1);
sigma2 = [1; a]'*covariance;
a = flipud(a);
