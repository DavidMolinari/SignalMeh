function [pos,sgn,g_q] = decodage_binaire_excitation(bits_pos_sgn,bits_g,Nc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Décodage binaire de l'excitation codée                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code à usage pédagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entrées/sorties                                         %
% bits_pos_sgn = Nc mots binaires de 24 bits codant pos et sgn       %
% bits_g = Nc mots binaires de 6 bits codant les gains quantifiés    %
% Nc = scalaire entier = nombre de composantes codées                %
% pos = matrice Ncx4 entière = positions des impulsions              %
% sgn = matrice Ncx4 entière = signes des impulsions                 %
% g_q = vecteur Ncx1 réel = gains quantifiés des composantes codées  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

base = 4; % base de décomposition temporelle
b_pos = 5; % nombre de bits de codage des posititions
b_sgn = 1; % nombre de bits de codage des signes
b_g = 6; % nombre de bits de codage des gains
A = 8; % facteur d'échelle des gains

% décodage des positions et des signes
bits_pos_sgn = reshape(bits_pos_sgn,Nc*base,b_pos+b_sgn); % récupération des mots binaires
bits_pos = bits_pos_sgn(:,1:b_pos); % séparation des bits de position
bits_sgn = bits_pos_sgn(:,b_pos+b_sgn); % séparation des bits de signe
pos = bin2dec(bits_pos)+1; % décodage binaire
sgn = bin2dec(bits_sgn)*2-1; % décodage binaire
pos = reshape(pos,Nc,base); % reconstitution de la matrice des positions 
sgn = reshape(sgn,Nc,base); % reconstitution de la matrice des gains

% décodage des gains
bits_g = reshape(bits_g,Nc,b_g); % récupération des mots binaires
idx = bin2dec(bits_g); % décodage binaire
g_q = exp(-idx/A); % quantification logarithmique inverse
