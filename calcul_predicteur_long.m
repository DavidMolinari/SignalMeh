function [periode,gain] = calcul_predicteur_long(signal)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul des coefficients du filtre pr�dicteur � long terme          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code � usage p�dagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entr�es/sorties                                         %
% signal = vecteur Nx1 r�el = une trame de signal                    %
% periode = scalaire entier positif = p�riode fondamentale           %
% gain = scalaire r�el = gain du pr�dicteur                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Valeur limites de la p�riode
periode_min = 20;
periode_max = 100;

max_lag = periode_max;
Rs = xcorr(signal,max_lag,'unbiased'); % auto-correlation non-biais�e
J = Rs(max_lag+periode_min:max_lag+periode_max);
[~,periode] = max(J);
periode = periode+periode_min-2;
gain = Rs(max_lag+periode+1)/Rs(max_lag+1);