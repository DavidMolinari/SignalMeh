clc
[x,fs] = wavread('meteo.wav');

%windowing
numSamples = length(y);
frameLength = 128;
subplot(3,1,1);
fUn = y(1:128)
plot(fUn);
title('Frame 1');

numFrames = floor(numSamples/frameLength);
for frame = 1:numFrames,
   firstSample = (frame * frameLength) - (frameLength - 1);
   lastSample = (frame * frameLength);
   subplot(3,1,2);
   shortTimeFrame = y(firstSample:lastSample);
   h = hamming(128);
   hs = h.*shortTimeFrame;
   plot(hs, 'r');
   title('Hamming(128)');

end
for frame = 1:numFrames,
   firstSample = (frame * frameLength) - (frameLength - 1);
   lastSample = (frame * frameLength);
   subplot(3,1,3);
   plot(calcul_predicteur_court(y(firstSample:lastSample), frameLength), 'g');
   title('calcul predicteur court');
end

fprintf('p1\n');
