[y,Fs,nbits]=wavread('meteo.wav');

%Using filterbanks and quantization techniques to achieve audio signal
%compression.
%to achieve 32kbit/s, we know that the corresponding sample
%rate of y1_down, y21_down and y20_down are 4000, 2000 and 2000,
%Which lead to a expression for quantized bits is 
%4xx + 2yy + 2zz = 32.
%xx is the number of bits for y1_down
%yy is the number of bits for y21_down
%zz is the number of bits for y20_down
%
%Output:
%   y = compressed output audio signals
%   Fs = output sampling rate
%   nbits = number of output bits
%
%
%Author: Yuqi Zhang, 15/12 2015

result = zeros(5,9,9);
delay_filter1= dfilt.delay(9);
y_delay = filter(delay_filter1,y); 

for xx = 2:6
    for yy = 2:10
        for zz = 2:10
            if 4*xx+2*yy+2*zz > 32
                continue;
            end

%implement highpass part.
[numh1,denh1] = tfdata(h1,'v');
y1 = filter(numh1,denh1,y);
y1_down1 = downsample(y1,2);
%quantization
scalingy1=max(abs(y1_down1))/(1-pow2(-xx));
y1quantized = scalingy1*double(fixed(xx, y1_down1/scalingy1));
%
delay_filter= dfilt.delay(3);
y1_down = filter(delay_filter,y1quantized); 
y1_up = upsample(y1_down,2);
[numg1,deng1] = tfdata(g1,'v');
y1_final = filter(numg1,deng1,y1_up);

%implement lowpass part.
[numh0,denh0] = tfdata(h0,'v');
y0 = filter(numh0,denh0,y);
y0_down = downsample(y0,2);

%implement second filter bank part.
%Similarly first deal with highpass part
y21 = filter(numh1,denh1,y0_down);
y21_down = downsample(y21,2);
%quantization
scalingy21=max(abs(y21_down))/(1-pow2(-yy));
y21quantized = scalingy21*double(fixed(yy, y21_down/scalingy21));
%
y21_up = upsample(y21quantized,2);
[numg1,deng1] = tfdata(g1,'v');
y21_final = filter(numg1,deng1,y21_up);

%Then deal with lowpass part.
y20 = filter(numh0,denh0,y0_down);
y20_down = downsample(y20,2);
%quantization
scalingy20=max(abs(y20_down))/(1-pow2(-zz));
y20quantized = scalingy20*double(fixed(zz, y20_down/scalingy20));
%
y20_up = upsample(y20quantized,2);
[numg0,deng0] = tfdata(g0,'v');
y20_final = filter(numg0,deng0,y20_up);

%combine second filter bank.
y2_final = y21_final + y20_final;

%continue implementing lowpass of first filter bank.
y0_up = upsample(y2_final,2);
y0_final = filter(numg0,deng0,y0_up);

%combine different frequency
y_final = y1_final + y0_final;
sqnr = sum(y.^2)/sum((y_final-y_delay).^2);
result(xx-1,yy-1,zz-1) = sqnr;
        end
    end
end
figure();
subplot(2,1,1)
ggg=slice(result,1:5,1:5,1:9);
colorbar;
title('SQNR')
xlabel('y-1');
ylabel('x-1');
zlabel('z-1');
colorbar;
subplot(2,1,2)
ggg=slice(result,1:5,1:5,1:9);
view(-45,-30);
colorbar;
title('SQNR')
xlabel('y-1');
ylabel('x-1');
zlabel('z-1');
