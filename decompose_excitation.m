function [pos,sgn,g] = decompose_excitation(signal,Nc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Décomposition de l'excitation sur le dictionnaire algébrique       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code à usage pédagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entrées/sorties                                         %
% signal = vecteur Nsx1 réel = signal à décomposer                   %
% Nc = scalaire entier positif = nombre de composantes codées        %
% pos = matrice Ncx4 entière = positions des impulsions              %
% sgn = matrice Ncx4 entière = signes des impulsions                 %
% g = vecteur Ncx1 réel = gains des composantes codées               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% paramètres de codage
Ns = length(signal);

% itérations du Matching Pursuit
pos = zeros(Nc,4);
sgn = zeros(Nc,4);
g = zeros(Nc,1);
for nc = 1 : Nc
      
    % détermination des séquences de positions et de signes optimales
    [~,idx1] = max(abs(signal(1:4:Ns-3)));
    [~,idx2] = max(abs(signal(2:4:Ns-2)));
    [~,idx3] = max(abs(signal(3:4:Ns-1)));
    [~,idx4] = max(abs(signal(4:4:Ns)));
    pos_idx = [idx1,idx2,idx3,idx4];
    pos_nc = 4*(pos_idx-1)+[1 2 3 4];
    sgn_nc = sign(signal(pos_nc));
    g_nc = 1/4*sum(abs(signal(pos_nc)));
    codeword = zeros(Ns,1);
    codeword(pos_nc) = sgn_nc;
    codeword = g_nc*codeword;
    
    % soustraction du mot de code optimal    
    signal = signal - codeword;
    
    % mise en forme des sorties
    pos(nc,:) = pos_idx;
    sgn(nc,:) = sgn_nc';
    g(nc) = g_nc;
    
end
