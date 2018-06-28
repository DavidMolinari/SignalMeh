function [periode,gain] = calcul_predicteur_long(signal)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul des coefficients du filtre prédicteur à long terme          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code à usage pédagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entrées/sorties                                         %
% signal = vecteur Nx1 réel = une trame de signal                    %
% periode = scalaire entier positif = période fondamentale           %
% gain = scalaire réel = gain du prédicteur                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Valeur limites de la période
periode_min = 20;
periode_max = 100;

max_lag = periode_max;
Rs = xcorr(signal,max_lag,'unbiased'); % auto-correlation non-biaisée
J = Rs(max_lag+periode_min:max_lag+periode_max);
[~,periode] = max(J);
periode = periode+periode_min-2;
gain = Rs(max_lag+periode+1)/Rs(max_lag+1);