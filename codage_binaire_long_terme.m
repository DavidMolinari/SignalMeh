function [bits_periode, bits_gain, gain_q] = codage_binaire_long_terme(periode,gain)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quantification et codage binaire du pr�dicteur long terme          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code � usage p�dagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entr�es/sorties                                         %
% periode = scalaire entier positif = p�riode fondamentale           %
% gain = scalaire r�el = gain du pr�dicteur                          %
% bits_periode = mot binaire de 7 bits codant la p�riode             %
% bits_gain = mot binaire de 3 bits codant le gain quantifi�         %
% gain_q = scalaire r�el = gain quantifi� (d�codeur dans le codeur)  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% codage binaire de la p�riode
b_periode = 7; % nombre de bits de codage
bits_periode = dec2bin(periode,b_periode); % codage binaire sur b_periode bits

% quantification du gain
A = 2; % facteur d'�chelle
b_gain = 3; % nombre de bits de codage
idx = round(-A*log(gain)); % quantification logarithmique
idx = min(idx,2^b_gain-1); % saturation par valeur sup�rieure
idx = max(idx,0); % saturation par valeur inf�rieure
gain_q = exp(-idx/A); % quantification logarithmique inverse
bits_gain = dec2bin(idx,b_gain); % codage binaire sur b_gain bits