clear all
l = txt2strlist('txt/Hedwig_l.txt'); %×óÊÖÆ×
r = txt2strlist('txt/Hedwig_r.txt'); %ÓÒÊÖÆ×

[pitchlistL,beatlistL,locationlistL] = strlist2pitchG(l);
[pitchlistR,beatlistR,locationlistR] = strlist2pitchG(r);

originalR = original(pitchlistR,beatlistR,locationlistR);
originalL = original(pitchlistL,beatlistL,locationlistL);
originalS = (originalR+originalL)./max(originalR+originalL);
sound(originalS,44100);
% audiowrite('Hedwig.mp4',originalS,44100)

pianoR = piano(pitchlistR,beatlistR,locationlistR);
pianoL = piano(pitchlistL,beatlistL,locationlistL);
pianoS = (pianoR+0.8.*pianoL)./max(pianoR+0.8.*pianoL);
sound(pianoS,44100);
audiowrite('Hedwig_piano1.mp4',pianoS,44100)

piano2R = piano2(pitchlistR,beatlistR,locationlistR);
piano2L = piano2(pitchlistL,beatlistL,locationlistL);
piano2S = (piano2R+0.8.*piano2L)./max(piano2R+0.8.*piano2L);
sound(piano2S,44100);
audiowrite('Hedwig_piano2.mp4',piano2S,44100)

test = txt2strlist('txt/test.txt');
[testp,testb,testl]=strlist2pitchC(test);
audio = piano2(testp,testb,testl);
audio = audio./max(audio);
sound(audio,44100);
audiowrite('LittleTigers.mp4',audio,44100)
