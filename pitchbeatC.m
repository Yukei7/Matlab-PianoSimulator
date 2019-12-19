function [pitch,beat,noteLocation] = pitchbeatC(note)
%PITCHBEAT ʶ��String�ַ��͵�������ת��Ϊ��Ӧ����Ƶ�ʺ�ʱ��
%   input:����+����+����+������/blk+����
%   output:[pitch,beat,noteLocation]
%   ����pitchbeat("so3hb")=[7,1/2,3]����bF3��������

charnote = char(note);
if contains(note,'blk')
    noteLocation = 0;
    noteChange = 0;
    notePitch = 0;
    noteBeat = charnote(4:end);
else
    location = regexp(charnote,'\d'); %����λ��
    noteLocation = str2num(charnote(regexp(charnote,'\d'))); %����
    notePitch = charnote(1:location-1); %����
    noteChange = 0;
    if contains(charnote(location+1:end),["u","b"])
        noteChange = charnote(end);
        noteBeat = charnote(location+1:end-1);
    else
        noteBeat = charnote(location+1:end);
    end
end

switch notePitch
    case 'do'
        pitch = 1;
    case 're'
        pitch = 3;
    case 'mi'
        pitch = 5;
    case 'fa'
        pitch = 6; 
    case 'so'
        pitch = 8;
    case 'la'
        pitch = 10;
    case 'si'
        pitch = 12;
    otherwise
        pitch = 0;
end
switch noteChange
    case 'u'
        pitch = pitch+1;
    case 'b'
        pitch = pitch-1;
end
switch noteBeat
    case 'F'
        beat = 1;
    case 'h'
        beat = 1/2;
    case 'f'
        beat = 1/4;
    case 'e'
        beat = 1/8;
    case 's'
        beat = 1/16;
    case 'fd'
        beat = 1/4+1/8;
    case 'hd'
        beat = 1/2+1/4;
    case 'ed'
        beat = 1/8+1/16;
end

