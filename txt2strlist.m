function strlist = txt2strlist(filepath)
%TXT2STRLIST 从txt读取谱子并转化到字符串向量
%   input:txt文件路径
%   output:strlist
%   格式为音高+音区+长度+升降调/blk+长度，分隔符为 ','
%   音高:do,re,mi,fa,so,la,si
%   音区:1,2,3,4,5,6,7
%   长度:s,e,ed,f,fd,h,hd,F
%   升降:u,b

fileID=fopen(filepath);
strcell=textscan(fileID,'%s','Delimiter',',');
fclose(fileID);
strcell = strcell{1};
strlist = string(strcell);
end

