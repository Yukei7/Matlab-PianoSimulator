function voice = note_piano2(pitch, beat, harmonictable)
%NOTE_PIANO2 ������������������ɫ�ĵ�������/������Ƶ�ź�
%   input:[pitch, beat]
%   output:voice
alpha = beat * 16; %ʮ���������ı���
fs = 44100;
dt = 1/fs;
T = 1/fs*6399;
t = [0:dt:T];
[~, k] = size(t);
t = linspace(0,alpha*T,alpha*k);

listsize = length(pitch(pitch~=0));
if listsize==0
    voice = zeros(1,length(t));
elseif listsize==1
    voice = tone_piano2(pitch(1),beat,harmonictable);
else
    voice = zeros(1,length(t));
    for count=1:listsize
        voice = voice + tone_piano2(pitch(count),beat,harmonictable);
    end
end
end
