clc
filename = 'meteo.wav';
[y, Fs, nbits] = wavread(filename); % Lecture du fichier audio, audioread ne voulant pas fonctionner
N = 128; %nb echantillons
figure(4)
specgram(y,length(y),Fs);

[n,p] = size(y);
duree = length(y)/Fs;
fprintf('nom audio   : %s\n', filename);
fprintf('duree audio : %g sec\n', duree);
fprintf('fs          : %g\n', Fs);
fprintf('nbits       : %g\n', nbits);
figure(1);
subplot(2,1,1);
plot(y);
z = [];
zz = [];

title('Plot du signal de base');
tr = floor(n/N);
for k = 1:tr,
   debut = (k * N) - (N - 1);
   fin = (k * N);
   subplot(2,1,2);
   pp = y(debut:fin);
   h = hamming(128);
   hs = h.*pp;
   plot(hs, 'r');
   title('Hamming(128)');
end
figure(2)
for k = 1:tr,
   debut = (k * N) - (N - 1);
   fin = (k * N);
   subplot(2,1,2);
   z = [y(debut:fin); calcul_predicteur_court(y(debut:fin), N)];
   plot(calcul_predicteur_court(y(debut:fin), N), 'g');
   title('calcul predicteur court');
end

z = enf(y, 128, tr);
subplot(2,1,1);
plot(z, 'r');
title('enframe');
figure(3)

for k = 1:tr,
   dd = (k * N+1) - N;
   ff = (k * N+1);
   subplot(2,1,1);
   zz = [y(dd:ff); calcul_predicteur_court(y(dd:ff), N)];
   plot(calcul_predicteur_court(y(dd:ff), N), 'r');
   title('TODO: Predicteur Court');
end






