clear all
beat = 1/2;
alpha = beat * 16;

fs = 44100;
dt = 1/fs;
T = 1/fs*4000;
t = [0:dt:T];
[~, k] = size(t);
t = linspace(0,alpha*T,alpha*k);

[ys,~]=audioread('Piano/73.ogg');

N = length(ys);
tt = (0:N-1)/fs;%��ʾʵ��ʱ��
yf = fft(ys);
f = fs/N*(0:round(N/2)-1);
subplot(211);
plot(tt,ys,'g');%����ʱ����
xlabel('Time / (s)');ylabel('Amplitude');
title('�źŵĲ���');
grid;
subplot(212);
plot(f,abs(yf(1:round(N/2))));
xlabel('Frequency / (s)');ylabel('Amplitude');
title('�źŵ�Ƶ��');
grid;

[upper_envelope, lower_envelope] = envelope(ys, ceil(fs/500), 'rms');

avg_envelope = (upper_envelope - lower_envelope); % Kick out the DC component
avg_envelope = avg_envelope / max(avg_envelope); % Standarization
plot(avg_envelope)