function sound = piano(pitchlist,beatlist,locationlist)
%PIANO ����������ɫ����Ƶ�ź�
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
for count=1:length(beatlist)
    notevoice = note_piano(newPitch(:,count),beatlist(count));
    sound = [sound,notevoice];
end
end

