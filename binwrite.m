function binwrite(fid, bits)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ecriture d'un train binaire dans un fichier                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code � usage p�dagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entr�es/sorties                                         %
% fid = identifiant du fichier pour lire les donn�es                 %
% bits = donn�es binaires � �crire                                   %
% Attention : �criture d'un nombre entier d'octets avec bourrage de 0%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nb_octets = ceil(length(bits)/8);
for no = 1 : (nb_octets-1)
   octet = bin2dec(bits( no*8-7 : no*8 ));
   fwrite(fid,octet,'uint8');
end
octet = bin2dec(bits( nb_octets*8-7 : length(bits) ));
fwrite(fid,octet,'uint8');

