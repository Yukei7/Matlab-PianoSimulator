function strlist = txt2strlist(filepath)
%TXT2STRLIST ��txt��ȡ���Ӳ�ת�����ַ�������
%   input:txt�ļ�·��
%   output:strlist
%   ��ʽΪ����+����+����+������/blk+���ȣ��ָ���Ϊ ','
%   ����:do,re,mi,fa,so,la,si
%   ����:1,2,3,4,5,6,7
%   ����:s,e,ed,f,fd,h,hd,F
%   ����:u,b

fileID=fopen(filepath);
strcell=textscan(fileID,'%s','Delimiter',',');
fclose(fileID);
strcell = strcell{1};
strlist = string(strcell);
end

