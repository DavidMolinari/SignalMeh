function [bits_pos_sgn, bits_g] = codage_binaire_excitation(pos,sgn,g)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quantification et codage binaire de l'excitation codée             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code à usage pédagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entrées/sorties                                         %
% pos = matrice Ncx4 entière = positions des impulsions              %
% sgn = matrice Ncx4 entière = signes des impulsions                 %
% g = vecteur Ncx1 réel = gains des composantes codées               %
% bits_pos_sgn = Nc mots binaires de 24 bits codant pos et sgn       %
% bits_g = Nc mots binaires de 6 bits codant les gains quantifiés    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% récupération des dimensions
[Nc,base] = size(pos);

% codage conjoint des positions et des signes
b_pos = 5; % nombre de bits de codage des posititions
b_sgn = 1; % nombre de bits de codage des signes
pos = reshape(pos-1,Nc*base,1); % conversion et mise en série des valeurs
bits_pos = dec2bin(pos,b_pos); % codage binaire sur b_pos bits
sgn = reshape(0.5*(sgn+1),Nc*base,1); % conversion et mise en série des valeurs
bits_sgn = dec2bin(sgn,b_sgn); % codage binaire sur b_sgn bits
bits_pos_sgn = [bits_pos, bits_sgn]; % concaténation des mots binaire
bits_pos_sgn = reshape(bits_pos_sgn,1,Nc*base*(b_pos+b_sgn)); % mise en série des mots binaires

% quantification et codage des gains
A = 8; % facteur d'échelle
b_g = 6; % nombre de bits de codage des gains
idx = round(-A*log(g)); % quantification logarithmique
idx = min(idx,2^b_g-1); % saturation par valeur supérieure
idx = max(idx,0); % saturation par valeur inférieure
bits_g = dec2bin(idx,b_g); % codage binaire sur b_g bits
bits_g = reshape(bits_g,1,Nc*b_g); % mise en série des mots binaires