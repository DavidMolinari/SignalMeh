# TP de codage compressif
## David MOLINARI, STMN1

### 1. Première version du codec : analyse/synthèse et prédiction linéaire


- Lecture du signal de parole dans un fichier audio au format wav.
- Calcul du nombre total de trames de 128 échantillons (16 ms) dans le signal.
- Initialisation du signal de sortie comme un vecteur vide.
- Boucle sur les trames
- Extraction de la portion de signal correspondant à la trame courante.
- Concaténation du signal de trame (inchangé pour l'instant) à la fin de vecteur de sortie.

```matlab
filename = 'meteo.wav';
[y, Fs] = audioread(filename);
N = 128; %nb echantillons
figure()
nb = round(length(y)/N)-1;
specgram(y,nb,Fs);
title('Specgram');
sigSortie = [];
conc = [];
for i = 1:nb
  if(i~=1)
  ff = y(1:128);
  [ct]  = calcul_predicteur_court(ff, N); 
  [periode,gain] = calcul_predicteur_long(ff); 
  conc =  [e;ff];
end

fprintf('nom audio   : %s\n', filename);
fprintf('duree audio : %g sec\n', duree);
fprintf('fs          : %g\n', Fs);
fprintf('nb trames   : %g\n', nb);

```
<img src="https://i.imgur.com/fjkyfSW.png" />

- Signal de base
```matlab
[y, Fs] = audioread(filename);
plot(y, 'r');
title("Signal de base");
```


<img src="https://i.imgur.com/Qc9h7oc.png" />



- Signal de sortie 
```matlab
tmax = length(y);
en(1:tmax) = y(1:tmax);
erreur = norm(en) -  norm(y);


plot(en);
ssortie = sprintf("Signal de sortie avec comme erreur : %d",erreur);
title(ssortie);
```
<img src="https://i.imgur.com/jblFsVd.png" />



- Partie Analyse  & Synthése
```matlab
[n,p] = size(y);
duree = length(y)/Fs;
fprintf('nom audio   : %s\n', filename);
fprintf('duree audio : %g sec\n', duree);
fprintf('fs          : %g\n', Fs);
%fprintf('nbits       : %g\n', nbits);

for i = 1:nb
  if(i~=1)
  sigT = y(1:128);
  sigS(1:128)=sigT;
  esig =  [e;sigT];
  [ct]  = calcul_predicteur_court(sigT, N);%calcul predicteur court
  [periode,gain] = calcul_predicteur_long(sigT);%calcul predicteur long
  [bits_periode,bits_gain,gain_q] = codage_binaire_long_terme(periode,gain);%codage LT
  [periode,gain] = decodage_binaire_long_terme(bits_periode,bits_gain);%decodage LT
  lsp = conversion_lsp(ct);%codage Lsp
  [bits_lsp,lsp_q] = codage_binaire_lsp(ct);%codage CT
  lsp_q = decodage_binaire_lsp(bits_lsp);%decodage CT
  ct = conversion_lsp_inv(lsp); %decodage Lsp
  
  for t= 1:N
    r1(t)= esig(128+t);
    for x= N-1:0
      r1(t) = r1(t) + ct(x+1) * esig(N+t-x-1);
    end
  end
  r1total = [r1prec r1];
  for t= 1:N
    r2(t) = r1(t) - gain * r1total(128+t-periode);
  end
  for t= 1:N
    r3(t) = r2(t) + gain * r1total(128+t-periode);
  end
  
  sfat = sprec;
  for t= 1:N
    s(t)= r3(t);
    for x= N-1:0
      s(t) = s(t) - ct(x+1) * sfat(128+t-x-1);
    end
    sfat = [sfat s(t)];
  end 
  if(i == nb)
  Analyse = sigT;
  Synthese = s;
  trameLTA = r1;
  trameLTS = r3;
end
sigS(a:a+127) = s;
r1prec = r1;
sprec = s;
e = y(a:a+127);

end
if(i == 1)
e = y(a:a+127);
sprec = y(a:a+127)';
r1prec = y(a:a+127)';
sigS(a:a+127) = y(a:a+127);

end
a = a+127;
end
```
<img src="https://i.imgur.com/dhotXG2.png" />
<img src="https://i.imgur.com/tfZPATZ.png" />


- R1 / R2 / R3

```matlab
  for t= 1:N
    r1(t)= esig(128+t);
    for x= N-1:0
      r1(t) = r1(t) + ct(x+1) * esig(N+t-x-1);
    end
  end
  r1total = [r1prec r1];
  for t= 1:N
    r2(t) = r1(t) - gain * r1total(128+t-periode);
  end
  for t= 1:N
    r3(t) = r2(t) + gain * r1total(128+t-periode);
  end
  ```


- Ecriture avec audiowrite et obtention d'un .wav identique à celui de base

```
en(1:tmax) = y(1:tmax);
erreur = norm(en) -  norm(y);
audiowrite("meteosortie.wav",en,Fs);
```





Code complet ou mis en ligne sur cette url : https://gist.github.com/DavidMolinari/45d5c24e664a58d2bf121e15887b5385:
```matlab
close all;
filename = 'meteo.wav';
[y, Fs] = audioread(filename);
N = 128; %nb echantillons
figure()
specgram(y,round(length(y)/N)-1,Fs);
title('Specgram');
nb = round(length(y)/N)-1;
sigSortie = [];
r1= [];
r2= [];
r3= [];
r1prec = [];
sprec =[];
e = [];
tmax = length(y);
a =1;
[n,p] = size(y);
duree = length(y)/Fs;
fprintf('nom audio   : %s\n', filename);
fprintf('duree audio : %g sec\n', duree);
fprintf('fs          : %g\n', Fs);
for i = 1:nb
  if(i~=1)
  sigT = y(1:128);
  sigS(1:128)=sigT;
  esig =  [e;sigT];
  [ct]  = calcul_predicteur_court(sigT, N);%calcul predicteur court
  [periode,gain] = calcul_predicteur_long(sigT);%calcul predicteur long
  [bits_periode,bits_gain,gain_q] = codage_binaire_long_terme(periode,gain);%codage LT
  [periode,gain] = decodage_binaire_long_terme(bits_periode,bits_gain);%decodage LT
  lsp = conversion_lsp(ct);%codage Lsp
  [bits_lsp,lsp_q] = codage_binaire_lsp(ct);%codage CT
  lsp_q = decodage_binaire_lsp(bits_lsp);%decodage CT
  ct = conversion_lsp_inv(lsp); %decodage Lsp
  for t= 1:N
    r1(t)= esig(128+t);
    for x= N-1:0
      r1(t) = r1(t) + ct(x+1) * esig(N+t-x-1);
    end
  end
  r1total = [r1prec r1];
  for t= 1:N
    r2(t) = r1(t) - gain * r1total(128+t-periode);
  end
  for t= 1:N
    r3(t) = r2(t) + gain * r1total(128+t-periode);
  end
  sfat = sprec;
  for t= 1:N
    s(t)= r3(t);
    for x= N-1:0
      s(t) = s(t) - ct(x+1) * sfat(128+t-x-1);
    end
    sfat = [sfat s(t)];
  end 
  if(i == nb)
  Analyse = sigT;
  Synthese = s;
  lta = r1;
  lts = r3;
end
sigS(a:a+127) = s;
r1prec = r1;
sprec = s;
e = y(a:a+127);
end
if(i == 1)
e = y(a:a+127);
sprec = y(a:a+127)';
r1prec = y(a:a+127)';
sigS(a:a+127) = y(a:a+127);
end
a = a+127;
end
en(1:tmax) = y(1:tmax);
erreur = norm(en) -  norm(y);
audiowrite("meteosortie.wav",en,Fs);
fprintf('Nombres de trames : %d\n',nb);
figure();
subplot(3,3,1);
plot(y, 'r');
title("Signal de base");
subplot(3,3,2);
plot(en);
ssortie = sprintf("Signal de sortie avec comme erreur : %d",erreur);
title(ssortie);
subplot(3,3,3);
plot(Analyse)
title("Analyse");
subplot(3,3,4);
plot(Synthese)
title("Synthese");
subplot(3,3,5);
plot(lta)
title("R1");
subplot(3,3,6);
plot(lts)
title("R3");
```
