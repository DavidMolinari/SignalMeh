function lsp_q = decodage_binaire_lsp(bits_lsp)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Décodage binaire des LSPs du prédicteur à court terme              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code à usage pédagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entrées/sorties                                         %
% bits_lsp = P mots binaires de 6 bits codant les lsp quantifiés     %
% lsp_q = vecteur Px1 réel = LSP quantifiés                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% décodage binaire différentiel des lsp
A = 200; % facteur d'échelle
b = 6; % nombre de bits par mot binaire
P = length(bits_lsp)/b; % récupération du nombre de lsp
bits_lsp = reshape(bits_lsp,P,b); % récupération des mots binaires
idx = bin2dec(bits_lsp); % décodage binaire
delta_q = idx/A; % quantification uniforme inverse
lsp_q = cumsum(delta_q); % différentiel inverse
lsp_q = sort(lsp_q,'descend'); % tri par ordre décroissant

