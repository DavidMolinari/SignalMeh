function a = conversion_lsp_inv(lsp)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conversion des LSPs en coefficients du prédicteur à court terme    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Olivier Derrien - SEATECH - 2017                                   %
% Code à usage pédagogique uniquement                                %
% Utilisation industrielle ou commerciale interdite                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Descriptif entrées/sorties                                         %
% lsp = vecteur Px1 réel = Line Spectrum Pairs                       %
% a = [aP ... a1] = vecteur Px1 réel = coefficients du prédicteur    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% désentrelacement
rd1 = lsp(2:2:end);
rd2 = lsp(1:2:end-1);

% ajout des symétriques et des valeurs évidentes
rd1 = [1; rd1; -rd1];
rd2 = [0; rd2; -rd2];

% conversion en complexes et calcul des polynomes intermédiaires
rd1 = exp(1i*rd1*pi);
rd2 = exp(1i*rd2*pi);
Bd1 = real(poly(rd1))';
Bd2 = real(poly(rd2))';

% obtention des coefficients du filtre prédicteur
a = 0.5*(Bd1-Bd2);
a = a(2:end-1);





