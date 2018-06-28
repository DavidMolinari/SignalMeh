function [bits_lsp,lsp_q] = codage_binaire_lsp(lsp)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quantification et codage binaire des LSP du prédicteur court terme %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code à usage pédagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entrées/sorties                                         %
% lsp = vecteur Px1 réel = Line Spectrum Pairs                       %
% bits_lsp = P mots binaires de 6 bits codant les lsp quantifiés     %
% lsp_q = vecteur Px1 réel = lsp quantifiés (décodeur dans le codeur)%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% codage binaire différentiel des lsp
P = length(lsp); % recupération de la taille des lsp
A = 200; % facteur d'échelle
b = 6; % longueur des mots binaires
lsp = sort(lsp,'ascend'); % tri par ordre croissant pour le différentiel
delta = zeros(size(lsp)); % transformation différentielle
delta(1) = lsp(1);
delta(2:end) = lsp(2:end)-lsp(1:end-1);
idx = round(A*delta); % quantification uniforme
idx = min(idx,2^b-1); % saturation par valeur supérieure
idx = max(idx,0); % saturation par valeur inférieure
bits_lsp = dec2bin(idx,b); % codage en binaire sur b bits
bits_lsp = reshape(bits_lsp,1,b*P); % mise en série des mots binaires

% décodage local pour la suite
delta_q = idx/A; % quantification uniforme inverse
lsp_q = cumsum(delta_q); % différentiel inverse
lsp_q = sort(lsp_q,'descend'); % tri par ordre décroissant