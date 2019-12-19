function wav = adsr_envelope(attack,decay,sustain,release,wavin,t)
%ADSR_ENVELOPE adsr_envelope(attack,decay,sustain,release,wavin,t)
% 输入:
%   <float> attack
%   <float> decay
%   <float> sustain
%   <float> release
%   <row vector> t: 时间序列
%   <row vector> wavin: 波形
% 返回值:
%   <row vector> wav: 包络调制后的波形

N = length(t);
ta = t(1:floor(attack*N));     % time sequence for Attack
td = t(floor(attack*N)+1:floor((attack+decay)*N));    % time sequence for Decay
ts = t(floor((attack+decay)*N)+1:floor((1-release)*N));
tr = t(floor((1-release)*N)+1:end);    % time sequence for Release

wa = wavin(1:floor(attack*N));
wd = wavin(floor(attack*N)+1:floor((attack+decay)*N));
ws = wavin(floor((attack+decay)*N)+1:floor((1-release)*N));
wr = wavin(floor((1-release)*N)+1:end);

ea = (1-10.^(-ta))/(1-10.^(-ta(end)));    % envelope for Attack
ed = (1-sustain)*(exp(-(td-td(end)))-1)/(exp(-(td(1)-td(end)))-1)+sustain;  % envelope for Decay
es = sustain;            % envelope for Sustain
er = sustain*(10.^(sustain-(tr-tr(1))/(tr(end)-tr(1))*sustain)-1)/(10.^sustain-1);    % envelope for Release
wav = [ea.*wa, ed.*wd, es.*ws, er.*wr];
end
