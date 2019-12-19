function voice = note_piano(pitch, beat)
%NOTE_PIANO 产生钢琴音色的单个音符/和弦音频信号
%   input:[pitch, beat]
%   output:voice
alpha = beat * 16; %十六分音符的倍数
fs = 44100;
dt = 1/fs;
T = 1/fs*6399;
t = [0:dt:T];
[~, k] = size(t);
t = linspace(0,alpha*T,alpha*k);

% mod = sin(pi*t/t(end));
% mod = ones(1,length(t));
mod = adsr_envelope(0.05,0.8,0.1,0.05,ones(1,length(t)),t);

listsize = length(pitch(pitch~=0));
if listsize==0
    voice = mod .*0;
elseif listsize==1
    voice = mod .* tone_piano(pitch(1),t);
else
    voice = mod .*0;
    for count=1:listsize
        voice = voice + mod .* tone_piano(pitch(count),t);
    end
end
end

