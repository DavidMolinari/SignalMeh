function excitation = synthese_excitation(pos,sgn,g,Ns);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Synth�se de l'excitation cod�e sur le dictionnaire alg�brique      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code � usage p�dagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entr�es/sorties                                         %
% pos = matrice Ncx4 enti�re = positions des impulsions              %
% sgn = matrice Ncx4 enti�re = signes des impulsions                 %
% g = vecteur Ncx1 r�el = gains des composantes cod�es               %
% Ns = scalaire entier = longueur du signal � synth�tiser            %
% excitation = vecteur Nsx1 r�el = signal synth�tis�                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% r�cup�ration du nombre de composantes � d�coder
Nc = length(g);

% r�cup�ration des positions r�elles
pos = 4*(pos-1) + ones(Nc,1)*[1 2 3 4];

% boucle sur les composantes
excitation = zeros(Ns,1);
for nc = 1 : Nc
      
    % calcul du mot de code correspondant
    codeword = zeros(Ns,1);
    codeword(pos(nc,:)) = sgn(nc,:);
    codeword = g(nc)*codeword;
    
    % mise � jour de l'exciation cod�e    
    excitation = excitation + codeword;
        
end
