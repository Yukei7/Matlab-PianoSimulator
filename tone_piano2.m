function sound = tone_piano2(pitch,beat,harmonictable)
%TONE_PIANO 采样钢琴音色
%   input:pitch,t,harmonictable
%   output:sound
%   基准音:
%   C1(32.7032),C2(65.4064Hz),C3(130.8128Hz)
%   C4(261.6256Hz),C5(523.2511Hz),C6(1046.5023Hz)
%   C7(2093.0045Hz)
alpha = beat * 16; %十六分音符的倍数
fs = 44100;
dt = 1/fs;
T = 1/fs*6399;
t = [0:dt:T];
[~, k] = size(t);
t = linspace(0,alpha*T,alpha*k);

if pitch < 43.6535
    loc=1;
elseif pitch < 87.3070
    loc=2;
elseif pitch<174.6141
    loc=3;
elseif pitch<349.2282
    loc=4;
elseif pitch<698.4565
    loc=5;
elseif pitch<1369.1292
    loc=6;
else
    loc=7;
end

harm_coef = harmonictable{loc}{1};
avg_envelope = harmonictable{loc}{2};
% Resample
len = length(avg_envelope);
if alpha < 2
    adjust_list = 2/len.*[zeros(1,round(0.5*len)),round(0.5*len)+1:len]+ones(1,len);
    avg_envelope = avg_envelope.*adjust_list';
end
newLen = length(t);
transformation_indexes = ceil((1:newLen)./newLen.*len);
avg_envelope = [avg_envelope; avg_envelope(end)];  % Avoid indexes out of range.
adapted_envelope = transpose(avg_envelope(transformation_indexes));

base_vector = zeros(1,newLen);
time_vector = t;
size_harm_coef = size(harm_coef);

% Create the sound.
for col_index = 1:size_harm_coef(2)
    angle_freq = 2 * pi * pitch * round(1.1*harm_coef(2, col_index)/harm_coef(2, 1));
    coef = harm_coef(1, col_index);
    phase = harm_coef(3, col_index);
    base_vector = base_vector + coef*sin(angle_freq*time_vector+phase);
end
% sound = base_vector.* adapted_envelope;
sound = (0.1.*normpdf(pi*t/t(end), 1.5, 0.5)+0.9.*adapted_envelope).*base_vector;
end