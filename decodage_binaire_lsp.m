function lsp_q = decodage_binaire_lsp(bits_lsp)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D�codage binaire des LSPs du pr�dicteur � court terme              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code � usage p�dagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entr�es/sorties                                         %
% bits_lsp = P mots binaires de 6 bits codant les lsp quantifi�s     %
% lsp_q = vecteur Px1 r�el = LSP quantifi�s                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% d�codage binaire diff�rentiel des lsp
A = 200; % facteur d'�chelle
b = 6; % nombre de bits par mot binaire
P = length(bits_lsp)/b; % r�cup�ration du nombre de lsp
bits_lsp = reshape(bits_lsp,P,b); % r�cup�ration des mots binaires
idx = bin2dec(bits_lsp); % d�codage binaire
delta_q = idx/A; % quantification uniforme inverse
lsp_q = cumsum(delta_q); % diff�rentiel inverse
lsp_q = sort(lsp_q,'descend'); % tri par ordre d�croissant

