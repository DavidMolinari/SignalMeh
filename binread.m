function [bitstream, erreur] = binread(fid, nb_octets)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lecture d'un train binaire dans un fichier                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code � usage p�dagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entr�es/sorties                                         %
% fid = identifiant du fichier pour lire les donn�es                 %
% nb_octets = nombre d'octets � lire                                 %
% bitstream = train binaire correspondant aux donn�es lues           %
% erreur = code d'erreur de lecture                                  %
% erreur = 0 : lecture OK                                            %
% erreur = 1 : fichier invalide ou fin de fichier                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

erreur = 0;
bitstream = [];
for no = 1 : nb_octets
   [octet, succes] = fread(fid,1,'uint8');
   if (succes == 1)
      bitstream = [bitstream, dec2bin(octet, 8)];
   else
      erreur = 1;
      break;
   end
end

