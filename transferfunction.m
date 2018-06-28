% Construct four transfer functions that 
% make signal perfext reconstruction.
%
% Plot the corresponding transfer functions 
% for analysis.
%
%
% Author: Yuqi Zhang, 14/12 2015


z = tf('z');
p1 = -1/32*2;
p2 = 1/8*2;
p3 = p1;
g0 = 1/2*(1+1/z)^2;
h1 = 1/2*(1+1/(-z))^2;
h0 = 2*(1+1/z)^2*(p1+p2*1/z+p3/z/z);
g1 = -2*(1-1/z)^2*(p1-p2/z+p3/z/z);
[numh1,denh1] = tfdata(h1,'v');
[numg1,deng1] = tfdata(g1,'v');
[numh0,denh0] = tfdata(h0,'v');
[numg0,deng0] = tfdata(g0,'v');
[gg0,w] = freqz(numg0,deng0);
hh1 = freqz(numh1,denh1);
gg1 = freqz(numg1,deng1);
hh0 = freqz(numh0,denh0);
figure(1)
plot(w/pi, 20*log10(abs(gg0)));
hold on
plot(w/pi,20*log10(abs(hh1)));
legend('G0','H1');
xlabel('Normalized frequency');
ylabel('Amplitude(dB)');
title('Frequency response');
grid on
figure(2)
plot(w/pi, 20*log10(abs(gg1)));
hold on
plot(w/pi,20*log10(abs(hh0)));
legend('G1','H0');
xlabel('Normalized frequency');
ylabel('Amplitude(dB)');
title('Frequency response');
grid on
