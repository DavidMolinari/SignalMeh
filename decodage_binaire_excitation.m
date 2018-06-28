function [pos,sgn,g_q] = decodage_binaire_excitation(bits_pos_sgn,bits_g,Nc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D�codage binaire de l'excitation cod�e                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code � usage p�dagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entr�es/sorties                                         %
% bits_pos_sgn = Nc mots binaires de 24 bits codant pos et sgn       %
% bits_g = Nc mots binaires de 6 bits codant les gains quantifi�s    %
% Nc = scalaire entier = nombre de composantes cod�es                %
% pos = matrice Ncx4 enti�re = positions des impulsions              %
% sgn = matrice Ncx4 enti�re = signes des impulsions                 %
% g_q = vecteur Ncx1 r�el = gains quantifi�s des composantes cod�es  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

base = 4; % base de d�composition temporelle
b_pos = 5; % nombre de bits de codage des posititions
b_sgn = 1; % nombre de bits de codage des signes
b_g = 6; % nombre de bits de codage des gains
A = 8; % facteur d'�chelle des gains

% d�codage des positions et des signes
bits_pos_sgn = reshape(bits_pos_sgn,Nc*base,b_pos+b_sgn); % r�cup�ration des mots binaires
bits_pos = bits_pos_sgn(:,1:b_pos); % s�paration des bits de position
bits_sgn = bits_pos_sgn(:,b_pos+b_sgn); % s�paration des bits de signe
pos = bin2dec(bits_pos)+1; % d�codage binaire
sgn = bin2dec(bits_sgn)*2-1; % d�codage binaire
pos = reshape(pos,Nc,base); % reconstitution de la matrice des positions 
sgn = reshape(sgn,Nc,base); % reconstitution de la matrice des gains

% d�codage des gains
bits_g = reshape(bits_g,Nc,b_g); % r�cup�ration des mots binaires
idx = bin2dec(bits_g); % d�codage binaire
g_q = exp(-idx/A); % quantification logarithmique inverse
