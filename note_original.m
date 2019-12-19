function voice = note_original(pitch, beat)
%NOTE_ORIGINAL 无音色单音符音频信号
alpha = beat * 16; %十六分音符的倍数
fs = 44100;
dt = 1/fs;
T = 1/fs*6399;
t = [0:dt:T];
[~, k] = size(t);
t = linspace(0,alpha*T,alpha*k);

% mod = normpdf(pi*t/t(end), 1.5, 0.5);
mod = sin(pi*t/t(end));
listsize = length(pitch(pitch~=0));
if listsize==0
    voice = mod .*0;
elseif listsize==1
    voice = mod .* cos(2*pi*pitch(1)*t);
else
    voice = mod .*0;
    for counts=1:listsize
        voice = voice + mod .* cos(2*pi*pitch(counts)*t);
    end
end
end

