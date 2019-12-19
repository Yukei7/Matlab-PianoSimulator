function [pitchlist,beatlist,locationlist] = strlist2pitchG(strlist)
%STRLIST2PITCH �����ַ���ת����Ƶ��ʱ���������������󣩣�G���
%   input:�����ַ����б�
%   output:[pitchlist,beatlist,locationlist]
%   �������ַ���ת�������ߡ�ʱ������������������
%   ���к�����������Ӧ�����ߺ���������Ĳ�ͬ�У����֧��4������
%   ��Ϊ��ֹ������Ӧ���ߺ�������ȫΪ0
%   ��ʽΪ����+����+����+������/blk+���ȣ�������'+'����
%   ����:do,re,mi,fa,so,la,si
%   ����:1,2,3,4,5,6,7
%   ����:s,e,ed,f,fd,h,hd,F
%   ����:u,b

pitchlist = zeros(4,length(strlist));
locationlist = zeros(4,length(strlist));
beatlist = zeros(1,length(strlist));
for counts=1:length(strlist)
    note = strlist(counts);
    if contains(note,'+')
        notes = regexp(note,'+','split'); % �����ַ����ָnotes
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

