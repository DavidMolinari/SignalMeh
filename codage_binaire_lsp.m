function [bits_lsp,lsp_q] = codage_binaire_lsp(lsp)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quantification et codage binaire des LSP du pr�dicteur court terme %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code � usage p�dagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entr�es/sorties                                         %
% lsp = vecteur Px1 r�el = Line Spectrum Pairs                       %
% bits_lsp = P mots binaires de 6 bits codant les lsp quantifi�s     %
% lsp_q = vecteur Px1 r�el = lsp quantifi�s (d�codeur dans le codeur)%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% codage binaire diff�rentiel des lsp
P = length(lsp); % recup�ration de la taille des lsp
A = 200; % facteur d'�chelle
b = 6; % longueur des mots binaires
lsp = sort(lsp,'ascend'); % tri par ordre croissant pour le diff�rentiel
delta = zeros(size(lsp)); % transformation diff�rentielle
delta(1) = lsp(1);
delta(2:end) = lsp(2:end)-lsp(1:end-1);
idx = round(A*delta); % quantification uniforme
idx = min(idx,2^b-1); % saturation par valeur sup�rieure
idx = max(idx,0); % saturation par valeur inf�rieure
bits_lsp = dec2bin(idx,b); % codage en binaire sur b bits
bits_lsp = reshape(bits_lsp,1,b*P); % mise en s�rie des mots binaires

% d�codage local pour la suite
delta_q = idx/A; % quantification uniforme inverse
lsp_q = cumsum(delta_q); % diff�rentiel inverse
lsp_q = sort(lsp_q,'descend'); % tri par ordre d�croissant