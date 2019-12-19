function [pitchlist,beatlist,locationlist] = strlist2pitchG(strlist)
%STRLIST2PITCH 音符字符串转换到频率时长音区向量（矩阵），G大调
%   input:音符字符串列表
%   output:[pitchlist,beatlist,locationlist]
%   将音符字符串转化成音高、时长、音区向量（矩阵）
%   若有和弦音符，对应在音高和音区矩阵的不同行（最多支持4个音）
%   若为休止符，对应音高和音区列全为0
%   格式为音高+音区+长度+升降调/blk+长度，和弦用'+'连接
%   音高:do,re,mi,fa,so,la,si
%   音区:1,2,3,4,5,6,7
%   长度:s,e,ed,f,fd,h,hd,F
%   升降:u,b

pitchlist = zeros(4,length(strlist));
locationlist = zeros(4,length(strlist));
beatlist = zeros(1,length(strlist));
for counts=1:length(strlist)
    note = strlist(counts);
    if contains(note,'+')
        notes = regexp(note,'+','split'); % 和弦字符串分割到notes
        chordPitchList=zeros(4,1);
        chordLocationList=zeros(4,1);
        chordCount=1;
        for singleNote=notes
            [notePitch,noteBeat,noteLocation] = pitchbeatG(singleNote);
            chordPitchList(chordCount,1)=notePitch;
            chordLocationList(chordCount,1)=noteLocation;
            chordCount = chordCount+1;
        end
        pitchlist(:,counts)=chordPitchList;
        locationlist(:,counts)=chordLocationList;
        beatlist(counts)=noteBeat;
    else
        [notePitch,noteBeat,noteLocation] = pitchbeatG(note);
        pitchlist(1,counts)=notePitch;
        locationlist(1,counts)=noteLocation;
        beatlist(counts)=noteBeat;
    end
end

end

