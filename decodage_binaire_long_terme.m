function [periode, gain_q] = decodage_binaire_long_terme(bits_periode, bits_gain)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D�odage binaire du pr�dicteur long terme                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code � usage p�dagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entr�es/sorties                                         %
% bits_periode = mot binaire de 7 bits codant la p�riode             %
% bits_gain = mot binaire de 3 bits codant le gain quantifi�         %
% periode = scalaire entier positif = p�riode fondementale           %
% gain_q = scalaire r�el = gain quantifi�                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% d�codage binaire de la p�riode
periode = bin2dec(bits_periode);

% d�codage binaire du gain
A = 2; % facteur d'�chelle
idx = bin2dec(bits_gain); % d�codage binaire
gain_q = exp(-idx/A); % quantification logarithmique inverse
