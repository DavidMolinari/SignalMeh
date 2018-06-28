function binwrite(fid, bits)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ecriture d'un train binaire dans un fichier                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code à usage pédagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entrées/sorties                                         %
% fid = identifiant du fichier pour lire les données                 %
% bits = données binaires à écrire                                   %
% Attention : écriture d'un nombre entier d'octets avec bourrage de 0%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nb_octets = ceil(length(bits)/8);
for no = 1 : (nb_octets-1)
   octet = bin2dec(bits( no*8-7 : no*8 ));
   fwrite(fid,octet,'uint8');
end
octet = bin2dec(bits( nb_octets*8-7 : length(bits) ));
fwrite(fid,octet,'uint8');

