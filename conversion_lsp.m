function lsp = conversion_lsp(a)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conversion des coefficients du pr�dicteur � court terme en LSPs    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code � usage p�dagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entr�es/sorties                                         %
% a = [aP ... a1] = vecteur Px1 r�el = coefficients du pr�dicteur    %
% lsp = vecteur Px1 r�el = Line Spectrum Pairs                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% recup�ration de l'ordre du filtre pr�dicteur
P = length(a);

% polynomes interm�diaires
A1 = [0; a; 1];
A2 = flipud(A1);
B1 = A1+A2;
B2 = A1-A2;

% calcul des racines et conversion en angles
r1 = angle(roots(B1))/pi;
r2 = angle(roots(B2))/pi;

% supression des valeurs �videntes et des sym�triques
r1 = sort(r1,'descend');
r2 = sort(r2,'descend');
r1 = r1(2:P/2+1);
r2 = r2(1:P/2);

% enrelacement
lsp = zeros(P,1);
lsp(2:2:end) = r1;
lsp(1:2:end-1) = r2;






