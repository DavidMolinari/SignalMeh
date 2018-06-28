function [bits_periode, bits_gain, gain_q] = codage_binaire_long_terme(periode,gain)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quantification et codage binaire du prédicteur long terme          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code à usage pédagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entrées/sorties                                         %
% periode = scalaire entier positif = période fondamentale           %
% gain = scalaire réel = gain du prédicteur                          %
% bits_periode = mot binaire de 7 bits codant la période             %
% bits_gain = mot binaire de 3 bits codant le gain quantifié         %
% gain_q = scalaire réel = gain quantifié (décodeur dans le codeur)  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% codage binaire de la période
b_periode = 7; % nombre de bits de codage
bits_periode = dec2bin(periode,b_periode); % codage binaire sur b_periode bits

% quantification du gain
A = 2; % facteur d'échelle
b_gain = 3; % nombre de bits de codage
idx = round(-A*log(gain)); % quantification logarithmique
idx = min(idx,2^b_gain-1); % saturation par valeur supérieure
idx = max(idx,0); % saturation par valeur inférieure
gain_q = exp(-idx/A); % quantification logarithmique inverse
bits_gain = dec2bin(idx,b_gain); % codage binaire sur b_gain bits