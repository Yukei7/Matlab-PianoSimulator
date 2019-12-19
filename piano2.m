function sound = piano2(pitchlist,beatlist,locationlist)
%PIANO2 通过拟合产生钢琴音色的音频信号
%   input:[pitchlist,beatlist,locationlist]
%   output:sound

listsize = length(beatlist);
pitch = pitchtable();
newPitch = zeros(4,listsize);
[rowidx,colidx]=find(pitchlist~=0);
for count=1:length(rowidx)
    row = rowidx(count);
    col = colidx(count);
    newPitch(row,col)=pitch(pitchlist(row,col),locationlist(row,col));
end
sound=[];
last_end_index=0;
harmonictable = InitializeHarmonic();
for count=1:length(beatlist)
    notevoice = note_piano2(newPitch(:,count),beatlist(count),harmonictable);
    sound = [sound,notevoice];
end
end

