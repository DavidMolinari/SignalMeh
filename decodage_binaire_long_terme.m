function [periode, gain_q] = decodage_binaire_long_terme(bits_periode, bits_gain)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Déodage binaire du prédicteur long terme                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code à usage pédagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entrées/sorties                                         %
% bits_periode = mot binaire de 7 bits codant la période             %
% bits_gain = mot binaire de 3 bits codant le gain quantifié         %
% periode = scalaire entier positif = période fondementale           %
% gain_q = scalaire réel = gain quantifié                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% décodage binaire de la période
periode = bin2dec(bits_periode);

% décodage binaire du gain
A = 2; % facteur d'échelle
idx = bin2dec(bits_gain); % décodage binaire
gain_q = exp(-idx/A); % quantification logarithmique inverse
