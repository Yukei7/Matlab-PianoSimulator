function voice = original(pitchlist,beatlist,locationlist)
%ORIGINAL 产生无音色的音频信号
%   input:[pitchlist,beatlist,locationlist]
%   output:sound

listsize = length(beatlist);
pitch = pitchtable();
newPitch = zeros(4,listsize);
[rowidx,colidx]=find(pitchlist~=0);
for counts=1:length(rowidx)
    row = rowidx(counts);
    col = colidx(counts);
    newPitch(row,col)=pitch(pitchlist(row,col),locationlist(row,col));
end
voice=[];
for counts=1:length(beatlist)
    notevoice = note_original(newPitch(:,counts),beatlist(counts));
    voice = [voice,notevoice];
end

end

