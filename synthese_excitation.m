function excitation = synthese_excitation(pos,sgn,g,Ns);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Synthèse de l'excitation codée sur le dictionnaire algébrique      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code à usage pédagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entrées/sorties                                         %
% pos = matrice Ncx4 entière = positions des impulsions              %
% sgn = matrice Ncx4 entière = signes des impulsions                 %
% g = vecteur Ncx1 réel = gains des composantes codées               %
% Ns = scalaire entier = longueur du signal à synthétiser            %
% excitation = vecteur Nsx1 réel = signal synthétisé                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% récupération du nombre de composantes à décoder
Nc = length(g);

% récupération des positions réelles
pos = 4*(pos-1) + ones(Nc,1)*[1 2 3 4];

% boucle sur les composantes
excitation = zeros(Ns,1);
for nc = 1 : Nc
      
    % calcul du mot de code correspondant
    codeword = zeros(Ns,1);
    codeword(pos(nc,:)) = sgn(nc,:);
    codeword = g(nc)*codeword;
    
    % mise à jour de l'exciation codée    
    excitation = excitation + codeword;
        
end
