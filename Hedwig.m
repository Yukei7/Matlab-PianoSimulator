%% define the basic sound wave
clear all
fs = 44100; % Standard sample rate
dt = 1/fs; % Standard sampling time interval
T16 = 1/fs*6399; %To determine the time length of a  1/16 note, suggest as an odd number
t16 = [0:dt:T16];
[temp k] = size(t16);
t1 = linspace(0,16*T16,16*k);% An array with the same length as a full note
t2 = linspace(0,8*T16,8*k);
t2d = linspace(0,12*T16,12*k); % 1/2+1/4
t4 = linspace(0,4*T16,4*k);
t4d = linspace(0,6*T16,6*k);%A special array represents a 1/4+1/8 note
t8 = linspace(0,2*T16,2*k);
t8d = linspace(0,3*T16,3*k);
t16 = linspace(0,T16,k);

mod1 = sin(pi*t1/t1(end));% Defining a basic amplitude function (So that the sound won't suddenly occur or vanish
mod2 = sin(pi*t2/t2(end));
mod2fd = sin(pi*t2d/t2d(end));
mod4 = sin(pi*t4/t4(end));
mod4d = sin(pi*t4d/t4d(end));
mod8 = sin(pi*t8/t8(end));
mod8d = sin(pi*t8d/t8d(end));
mod16 = sin(pi*t16/t16(end));

%% Frequency and note List
f0 = 261.6; % Middle C
% f0 = 391.6; % G tone
ScaleTable = [1 2^(1/6) 2^(1/3) 2^(5/12) 2^(7/12) 2^(9/12) 2^(11/12)];%Other frequencies

% full notes
do1F = mod1.*cos(pi*ScaleTable(1)*f0*t1);
re1F = mod1.*cos(pi*ScaleTable(2)*f0*t1);
mi1F = mod1.*cos(pi*ScaleTable(3)*f0*t1);
fa1F = mod1.*cos(pi*ScaleTable(4)*2^(1/12)*f0*t1);
so1F = mod1.*cos(pi*ScaleTable(5)*f0*t1);
la1F = mod1.*cos(pi*ScaleTable(6)*f0*t1);
si1F = mod1.*cos(pi*ScaleTable(7)*f0*t1);
do2F = mod1.*cos(2*pi*ScaleTable(1)*f0*t1);
re2F = mod1.*cos(2*pi*ScaleTable(2)*f0*t1);
mi2F = mod1.*cos(2*pi*ScaleTable(3)*f0*t1);
fa2F = mod1.*cos(2*pi*ScaleTable(4)*2^(1/12)*f0*t1);
so2F = mod1.*cos(2*pi*ScaleTable(5)*f0*t1);
la2F = mod1.*cos(2*pi*ScaleTable(6)*f0*t1);
si2F = mod1.*cos(2*pi*ScaleTable(7)*f0*t1);
do3F = mod1.*cos(4*pi*ScaleTable(1)*f0*t1);
re3F = mod1.*cos(4*pi*ScaleTable(2)*f0*t1);
mi3F = mod1.*cos(4*pi*ScaleTable(3)*f0*t1);
fa3F = mod1.*cos(4*pi*ScaleTable(4)*2^(1/12)*f0*t1);
so3F = mod1.*cos(4*pi*ScaleTable(5)*f0*t1);

blkF = zeros(size(mod1));

% 1/2 notes
do1h = mod2.*cos(pi*ScaleTable(1)*f0*t2);
re1h = mod2.*cos(pi*ScaleTable(2)*f0*t2);
mi1h = mod2.*cos(pi*ScaleTable(3)*f0*t2);
fa1h = mod2.*cos(pi*ScaleTable(4)*2^(1/12)*f0*t2);
so1h = mod2.*cos(pi*ScaleTable(5)*f0*t2);
la1h = mod2.*cos(pi*ScaleTable(6)*f0*t2);
si1h = mod2.*cos(pi*ScaleTable(7)*f0*t2);
do2h = mod2.*cos(2*pi*ScaleTable(1)*f0*t2);
re2h = mod2.*cos(2*pi*ScaleTable(2)*f0*t2);
mi2h = mod2.*cos(2*pi*ScaleTable(3)*f0*t2);
fa2h = mod2.*cos(2*pi*ScaleTable(4)*2^(1/12)*f0*t2);
so2h = mod2.*cos(2*pi*ScaleTable(5)*f0*t2);
la2h = mod2.*cos(2*pi*ScaleTable(6)*f0*t2);
si2h = mod2.*cos(2*pi*ScaleTable(7)*f0*t2);
do3h = mod2.*cos(4*pi*ScaleTable(1)*f0*t2);
re3h = mod2.*cos(4*pi*ScaleTable(2)*f0*t2);
mi3h = mod2.*cos(4*pi*ScaleTable(3)*f0*t2);
fa3h = mod2.*cos(4*pi*ScaleTable(4)*2^(1/12)*f0*t2);
so3h = mod2.*cos(4*pi*ScaleTable(5)*f0*t2);
la3h = mod2.*cos(4*pi*ScaleTable(6)*f0*t2);
si3h = mod2.*cos(4*pi*ScaleTable(7)*f0*t2);

blkh = zeros(size(mod2));

% 1/2+1/4 notes
mi2hd = mod2fd.*cos(2*pi*ScaleTable(3)*f0*t2d);
so2hd = mod2fd.*cos(2*pi*ScaleTable(5)*f0*t2d);
si2hd = mod2fd.*cos(2*pi*ScaleTable(7)*f0*t2d);
do3hd = mod2fd.*cos(4*pi*ScaleTable(1)*f0*t2d);
re3hd = mod2fd.*cos(4*pi*ScaleTable(2)*f0*t2d);
mi3hd = mod2fd.*cos(4*pi*ScaleTable(3)*f0*t2d);
so3hd = mod2fd.*cos(4*pi*ScaleTable(5)*f0*t2d);

% 1/4+1/8 notes
mim1fd = mod4d.*cos(0.25*pi*ScaleTable(3)*f0*t4d);
mi0fd = mod4d.*cos(0.5*pi*ScaleTable(3)*f0*t4d);
do1fd = mod4d.*cos(pi*ScaleTable(1)*f0*t4d);
re1fd = mod4d.*cos(pi*ScaleTable(2)*f0*t4d);
mi1fd = mod4d.*cos(pi*ScaleTable(3)*f0*t4d);
fa1fd = mod4d.*cos(pi*ScaleTable(4)*2^(1/12)*f0*t4d);
so1fd = mod4d.*cos(pi*ScaleTable(5)*f0*t4d);
la1fd = mod4d.*cos(pi*ScaleTable(6)*f0*t4d);
si1fd = mod4d.*cos(pi*ScaleTable(7)*f0*t4d);
do2fd = mod4d.*cos(2*pi*ScaleTable(1)*f0*t4d);
re2fd = mod4d.*cos(2*pi*ScaleTable(2)*f0*t4d);
mi2fd = mod4d.*cos(2*pi*ScaleTable(3)*f0*t4d);
fa2fd = mod4d.*cos(2*pi*ScaleTable(4)*2^(1/12)*f0*t4d);
so2fd = mod4d.*cos(2*pi*ScaleTable(5)*f0*t4d);
la2fd = mod4d.*cos(2*pi*ScaleTable(6)*f0*t4d);
si2fd = mod4d.*cos(2*pi*ScaleTable(7)*f0*t4d);
do3fd = mod4d.*cos(4*pi*ScaleTable(1)*f0*t4d);
re3fd = mod4d.*cos(4*pi*ScaleTable(2)*f0*t4d);
mi3fd = mod4d.*cos(4*pi*ScaleTable(3)*f0*t4d);
fa3fd = mod4d.*cos(4*pi*ScaleTable(4)*2^(1/12)*f0*t4d);
so3fd = mod4d.*cos(4*pi*ScaleTable(5)*f0*t4d);
la3fd = mod4d.*cos(4*pi*ScaleTable(6)*f0*t4d);
si3fd = mod4d.*cos(4*pi*ScaleTable(7)*f0*t4d);
do4fd = mod4d.*cos(8*pi*ScaleTable(1)*f0*t4d);
re4fd = mod4d.*cos(8*pi*ScaleTable(2)*f0*t4d);

do2fdu = mod4d.*cos(2*pi*ScaleTable(1)*2^(1/12)*f0*t4d);
so2fdu = mod4d.*cos(2*pi*ScaleTable(5)*2^(1/12)*f0*t4d);
fa2fdb = mod4d.*cos(2*pi*ScaleTable(4)*f0*t4d);
si2fdb = mod4d.*cos(2*pi*ScaleTable(6)*2^(1/12)*f0*t4d);

blkfd = zeros(size(mod4d));
% 1/4 notes
do1f = mod4.*cos(pi*ScaleTable(1)*f0*t4);
re1f = mod4.*cos(pi*ScaleTable(2)*f0*t4);
mi1f = mod4.*cos(pi*ScaleTable(3)*f0*t4);
fa1f = mod4.*cos(pi*ScaleTable(4)*2^(1/12)*f0*t4);
so1f = mod4.*cos(pi*ScaleTable(5)*f0*t4);
la1f = mod4.*cos(pi*ScaleTable(6)*f0*t4);
si1f = mod4.*cos(pi*ScaleTable(7)*f0*t4);
do2f = mod4.*cos(2*pi*ScaleTable(1)*f0*t4);
re2f = mod4.*cos(2*pi*ScaleTable(2)*f0*t4);
mi2f = mod4.*cos(2*pi*ScaleTable(3)*f0*t4);
fa2f = mod4.*cos(2*pi*ScaleTable(4)*2^(1/12)*f0*t4);
so2f = mod4.*cos(2*pi*ScaleTable(5)*f0*t4);
la2f = mod4.*cos(2*pi*ScaleTable(6)*f0*t4);
si2f = mod4.*cos(2*pi*ScaleTable(7)*f0*t4);
do3f = mod4.*cos(4*pi*ScaleTable(1)*f0*t4);
re3f = mod4.*cos(4*pi*ScaleTable(2)*f0*t4);
mi3f = mod4.*cos(4*pi*ScaleTable(3)*f0*t4);
fa3f = mod4.*cos(4*pi*ScaleTable(4)*2^(1/12)*f0*t4);
so3f = mod4.*cos(4*pi*ScaleTable(5)*f0*t4);
la3f = mod4.*cos(4*pi*ScaleTable(6)*f0*t4);
si3f = mod4.*cos(4*pi*ScaleTable(7)*f0*t4);
do4f = mod4.*cos(8*pi*ScaleTable(1)*f0*t4);
re4f = mod4.*cos(8*pi*ScaleTable(2)*f0*t4);

so1fu = mod4.*cos(pi*ScaleTable(5)*2^(1/12)*f0*t4);
do2fu = mod4.*cos(2*pi*ScaleTable(1)*2^(1/12)*f0*t4);
so2fu = mod4.*cos(2*pi*ScaleTable(5)*2^(1/12)*f0*t4);
do3fu = mod4.*cos(4*pi*ScaleTable(1)*2^(1/12)*f0*t4);
re3fu =  mod4.*cos(4*pi*ScaleTable(2)*2^(1/12)*f0*t4);

si1fb = mod4.*cos(pi*ScaleTable(6)*2^(1/12)*f0*t4);
fa2fb = mod4.*cos(2*pi*ScaleTable(4)*f0*t4);
si2fb = mod4.*cos(2*pi*ScaleTable(6)*2^(1/12)*f0*t4);
si3fb = mod4.*cos(4*pi*ScaleTable(6)*2^(1/12)*f0*t4);

blkf = zeros(size(mod4));


% 1/8 notes
dom1e = mod8.*cos((2^(-2))*pi*ScaleTable(1)*f0*t8);
rem1e = mod8.*cos((2^(-2))*pi*ScaleTable(2)*f0*t8);
mim1e = mod8.*cos((2^(-2))*pi*ScaleTable(3)*f0*t8);
fam1e = mod8.*cos((2^(-2))*pi*ScaleTable(4)*2^(1/12)*f0*t8);
fam1eb = mod8.*cos((2^(-2))*pi*ScaleTable(4)*f0*t8);
som1e = mod8.*cos((2^(-2))*pi*ScaleTable(5)*f0*t8);
lam1e = mod8.*cos((2^(-2))*pi*ScaleTable(6)*f0*t8);
sim1e = mod8.*cos((2^(-2))*pi*ScaleTable(7)*f0*t8);
do0e = mod8.*cos(0.5*pi*ScaleTable(1)*f0*t8);
re0e = mod8.*cos(0.5*pi*ScaleTable(2)*f0*t8);
mi0e = mod8.*cos(0.5*pi*ScaleTable(3)*f0*t8);
fa0e = mod8.*cos(0.5*pi*ScaleTable(4)*2^(1/12)*f0*t8);
fa0eb = mod8.*cos(0.5*pi*ScaleTable(4)*f0*t8);
so0e = mod8.*cos(0.5*pi*ScaleTable(5)*f0*t8);
la0e = mod8.*cos(0.5*pi*ScaleTable(6)*f0*t8);
si0e = mod8.*cos(0.5*pi*ScaleTable(7)*f0*t8);
do1e = mod8.*cos(pi*ScaleTable(1)*f0*t8);
re1e = mod8.*cos(pi*ScaleTable(2)*f0*t8);
mi1e = mod8.*cos(pi*ScaleTable(3)*f0*t8);
fa1e = mod8.*cos(pi*ScaleTable(4)*2^(1/12)*f0*t8);
so1e = mod8.*cos(pi*ScaleTable(5)*f0*t8);
la1e = mod8.*cos(pi*ScaleTable(6)*f0*t8);
si1e = mod8.*cos(pi*ScaleTable(7)*f0*t8);
do2e = mod8.*cos(2*pi*ScaleTable(1)*f0*t8);
re2e = mod8.*cos(2*pi*ScaleTable(2)*f0*t8);
mi2e = mod8.*cos(2*pi*ScaleTable(3)*f0*t8);
fa2e = mod8.*cos(2*pi*ScaleTable(4)*2^(1/12)*f0*t8);
so2e = mod8.*cos(2*pi*ScaleTable(5)*f0*t8);
la2e = mod8.*cos(2*pi*ScaleTable(6)*f0*t8);
si2e = mod8.*cos(2*pi*ScaleTable(7)*f0*t8);
do3e = mod8.*cos(4*pi*ScaleTable(1)*f0*t8);
re3e = mod8.*cos(4*pi*ScaleTable(2)*f0*t8);
mi3e = mod8.*cos(4*pi*ScaleTable(3)*f0*t8);
fa3e = mod8.*cos(4*pi*ScaleTable(4)*2^(1/12)*f0*t8);
so3e = mod8.*cos(4*pi*ScaleTable(5)*f0*t8);
la3e = mod8.*cos(4*pi*ScaleTable(6)*f0*t8);
si3e = mod8.*cos(4*pi*ScaleTable(7)*f0*t8);

do1eu = mod8.*cos(pi*ScaleTable(1)*2^(1/12)*f0*t8);
so1eu = mod8.*cos(pi*ScaleTable(5)*2^(1/12)*f0*t8);
do2eu = mod8.*cos(2*pi*ScaleTable(1)*2^(1/12)*f0*t8);
so2eu = mod8.*cos(2*pi*ScaleTable(5)*2^(1/12)*f0*t8);
do3eu = mod8.*cos(4*pi*ScaleTable(1)*2^(1/12)*f0*t8);
so3eu = mod8.*cos(4*pi*ScaleTable(5)*2^(1/12)*f0*t8);
do4eu = mod8.*cos(8*pi*ScaleTable(1)*2^(1/12)*f0*t8);

si1eb = mod8.*cos(pi*ScaleTable(6)*2^(1/12)*f0*t8);
fa2eb = mod8.*cos(2*pi*ScaleTable(4)*f0*t8);
si2eb = mod8.*cos(2*pi*ScaleTable(6)*2^(1/12)*f0*t8);
fa3eb = mod8.*cos(4*pi*ScaleTable(4)*f0*t8);
si3eb = mod8.*cos(4*pi*ScaleTable(6)*2^(1/12)*f0*t8);

blke = zeros(size(mod8));

% 1/8+1/16 notes
do1ed = mod8d.*cos(pi*ScaleTable(1)*f0*t8d);
re1ed = mod8d.*cos(pi*ScaleTable(2)*f0*t8d);
mi1ed = mod8d.*cos(pi*ScaleTable(3)*f0*t8d);
fa1ed = mod8d.*cos(pi*ScaleTable(4)*2^(1/12)*f0*t8d);
so1ed = mod8d.*cos(pi*ScaleTable(5)*f0*t8d);
la1ed = mod8d.*cos(pi*ScaleTable(6)*f0*t8d);
si1ed = mod8d.*cos(pi*ScaleTable(7)*f0*t8d);
do2ed = mod8d.*cos(2*pi*ScaleTable(1)*f0*t8d);
re2ed = mod8d.*cos(2*pi*ScaleTable(2)*f0*t8d);
mi2ed = mod8d.*cos(2*pi*ScaleTable(3)*f0*t8d);
fa2ed = mod8d.*cos(2*pi*ScaleTable(4)*2^(1/12)*f0*t8d);
so2ed = mod8d.*cos(2*pi*ScaleTable(5)*f0*t8d);
la2ed = mod8d.*cos(2*pi*ScaleTable(6)*f0*t8d);
si2ed = mod8d.*cos(2*pi*ScaleTable(7)*f0*t8d);
do3ed = mod8d.*cos(4*pi*ScaleTable(1)*f0*t8d);
re3ed = mod8d.*cos(4*pi*ScaleTable(2)*f0*t8d);
mi3ed = mod8d.*cos(4*pi*ScaleTable(3)*f0*t8d);
fa3ed = mod8d.*cos(4*pi*ScaleTable(4)*2^(1/12)*f0*t8d);
so3ed = mod8d.*cos(4*pi*ScaleTable(5)*f0*t8d);
la3ed = mod8d.*cos(4*pi*ScaleTable(6)*f0*t8d);
si3ed = mod8d.*cos(4*pi*ScaleTable(7)*f0*t8d);
do4ed = mod8d.*cos(8*pi*ScaleTable(1)*f0*t8d);
re4ed = mod8d.*cos(8*pi*ScaleTable(2)*f0*t8d);

% 1/16 notes
dom1s = mod16.*cos(0.25*pi*ScaleTable(1)*f0*t16);
rem1s = mod16.*cos(0.25*pi*ScaleTable(2)*f0*t16);
mim1s = mod16.*cos(0.25*pi*ScaleTable(3)*f0*t16);
fam1s = mod16.*cos(0.25*pi*ScaleTable(4)*2^(1/12)*f0*t16);
fam1sb = mod16.*cos(0.25*pi*ScaleTable(4)*f0*t16);
som1s = mod16.*cos(0.25*pi*ScaleTable(5)*f0*t16);
lam1s = mod16.*cos(0.25*pi*ScaleTable(6)*f0*t16);
sim1s = mod16.*cos(0.25*pi*ScaleTable(7)*f0*t16);
do0s = mod16.*cos(0.5*pi*ScaleTable(1)*f0*t16);
re0s = mod16.*cos(0.5*pi*ScaleTable(2)*f0*t16);
mi0s = mod16.*cos(0.5*pi*ScaleTable(3)*f0*t16);
fa0s = mod16.*cos(0.5*pi*ScaleTable(4)*2^(1/12)*f0*t16);
fa0sb = mod16.*cos(0.5*pi*ScaleTable(4)*f0*t16);
so0s = mod16.*cos(0.5*pi*ScaleTable(5)*f0*t16);
la0s = mod16.*cos(0.5*pi*ScaleTable(6)*f0*t16);
si0s = mod16.*cos(0.5*pi*ScaleTable(7)*f0*t16);
do1s = mod16.*cos(pi*ScaleTable(1)*f0*t16);
re1s = mod16.*cos(pi*ScaleTable(2)*f0*t16);
mi1s = mod16.*cos(pi*ScaleTable(3)*f0*t16);
fa1s = mod16.*cos(pi*ScaleTable(4)*2^(1/12)*f0*t16);
fa1sb = mod16.*cos(pi*ScaleTable(4)*f0*t16);
so1s = mod16.*cos(pi*ScaleTable(5)*f0*t16);
la1s = mod16.*cos(pi*ScaleTable(6)*f0*t16);
si1s = mod16.*cos(pi*ScaleTable(7)*f0*t16);
do2s = mod16.*cos(2*pi*ScaleTable(1)*f0*t16);
re2s = mod16.*cos(2*pi*ScaleTable(2)*f0*t16);
mi2s = mod16.*cos(2*pi*ScaleTable(3)*f0*t16);
fa2s = mod16.*cos(2*pi*ScaleTable(4)*2^(1/12)*f0*t16);
so2s = mod16.*cos(2*pi*ScaleTable(5)*f0*t16);
la2s = mod16.*cos(2*pi*ScaleTable(6)*f0*t16);
si2s = mod16.*cos(2*pi*ScaleTable(7)*f0*t16);
do3s = mod16.*cos(4*pi*ScaleTable(1)*f0*t16);
re3s = mod16.*cos(4*pi*ScaleTable(2)*f0*t16);
mi3s = mod16.*cos(4*pi*ScaleTable(3)*f0*t16);
fa3s = mod16.*cos(4*pi*ScaleTable(4)*2^(1/12)*f0*t16);
so3s = mod16.*cos(4*pi*ScaleTable(5)*f0*t16);
la3s = mod16.*cos(4*pi*ScaleTable(6)*f0*t16);
si3s = mod16.*cos(4*pi*ScaleTable(7)*f0*t16);
do4s = mod16.*cos(8*pi*ScaleTable(1)*f0*t16);
re4s = mod16.*cos(8*pi*ScaleTable(2)*f0*t16);

do1su = mod16.*cos(pi*ScaleTable(1)*2^(1/12)*f0*t16);
do2su = mod16.*cos(2*pi*ScaleTable(1)*2^(1/12)*f0*t16);
do3su = mod16.*cos(4*pi*ScaleTable(1)*2^(1/12)*f0*t16);
so3su = mod16.*cos(4*pi*ScaleTable(5)*2^(1/12)*f0*t16);

fa3sb = mod16.*cos(4*pi*ScaleTable(4)*f0*t16);
si1sb = mod16.*cos(pi*ScaleTable(6)*2^(1/12)*f0*t16);
si2sb = mod16.*cos(2*pi*ScaleTable(6)*2^(1/12)*f0*t16);
si3sb = mod16.*cos(4*pi*ScaleTable(6)*2^(1/12)*f0*t16);


%% Melody
r = [blkh,blke,si2e,mi3ed,so3s,fa3e,mi3f,si3e,la3fd,fa3fd,mi3ed,so3s,fa3e,re3fu,fa3eb,...
    si2h,blke,si2e,mi3ed,so3s,fa3e,mi3f,si3e,...
    re3f+so3f+re4f,do4eu,do3f+fa3f+do4f,so3eu,do3ed+mi3ed+do4ed,si3s,si3eb,si2fb,so3e,mi3h,blke,so3e,...
    si3f,so3e,si3f,so3e,do4f,si3e,si3fb,fa3e,so3ed,si3s,si3eb,si2fb,si2e,si3h,blke,so3e,si3f,so3e,si3f,so3e,...
    re3f+so3f+re4f,do4eu,do3f+fa3f+do4f,so3eu,do3ed+mi3ed+do4ed,si3s,si3eb,si2fb,so3e,mi3hd,blkh,blkf,...
    si1ed+mi2ed,so2s,fa2e,si1f+mi2f,si2e,si1fd+mi2fd+la2fd,si1fd+mi2fd+fa2fd,si1ed+mi2ed,so2s,fa2e,fa1f+re2f,fa2eb,...
    so1h+si1h,blke,si1e,si1ed+mi2ed,so2s,fa2e,si1f+mi2f,si2e,re2f+so2f+si2fb+re3f,do3eu,do2f+fa2fb+so2fu+do3f,so2e,...
    do2ed+mi2ed+do3ed,si2s,si2eb,si1fb,so2e,...
    si1s+mi2s,so1s,mi2s,si1s,so2s,mi2s,si2s,so2s,re3s,si2s,fa3s,re3s,si3s,si2s,mi3s,si2s,so3s,si2s,si3s,si2s,mi3s,si2s,so3s,si2s,...
    do4s,do3s,mi3s,do3s,si3s,si2s,si3sb,si2sb,do3su,si2s,fa3s,si2s,so3s,si2s,mi3s,si3s,si3sb,si2s,si2sb,do2su,fa2s,do2s,do3s,mi2s,...
    si3s,mi3s,so3s,si2s,mi3s,so2s,si2s,so2s,mi3s,si2s,so3s,mi3s,si3s,si2s,mi3s,si2s,so3s,si2s,si3s,si2s,mi3s,si2s,so3s,si2s,...
    re3s+re4s,si3sb,so3s,re3s,do2eu+do3eu,do2s+do3s,so3su,fa3sb,do3s,so2eu+so3e,...
    do3s+do4s,mi3s,do3s,si2s+si3s,si2eb+si3eb,si1sb+si2sb,do2su,fa2s,si2s,so2e+so3e,...
    mi2s+mi3s,si2s,so2s,mi2s,si1s,so1s,mi1f,blke];

l = [blkh,blkf,mi2fd,mi2fd,mi2fd,mi2fd,mi2fd,si2fdb,mi2f,so2e,si2f,si1e,mi2fd,mi2fd,...
    re2fd+so2fd+si2fdb,do2fd+fa2fdb+so2fdu,do2fd+mi2fd+la2fd,do2fdu+mi2fd+fa2fd,mi2f,so2e,si2f,si1e,...
    mi2f,so2e,si2f,si1e,mi2f,so2e,do3f,si1e,mi2f,so2e,do2f,so2e,mi2f,so2e,si2f,si1e,mi2f,so2e,si2f,so2e,...
    re2fd+so2fd+si2fdb,do2fd+fa2fdb+so2fdu,si1fd+mi2fd+so2fd,do2fdu+mi2fd+fa2fd,mi2f,so2e,si2f,si1e,mi2f,so2e,si2f,si1e,...
    mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,...
    mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,mi1e,so0s,re1s,si1fb,fa0sb,do1s,so1fu,la0s,mi1s,do2f,fa0s,do1su,si1fb,...
    mi1e,mi1e,mi1e,mi1e,mi1e,mi1e+so1e,mi1e+si1e,mi1e+si1e,mi1e+so1e,mi1e+si1e,mi1e+si1e,mi1e+so1e,...
    mi1e+do2e,mi1e+do2e,mi1e+si1e,mi1e+si1eb,mi1e+si1e,mi1e+fa1e,mi1e+so1e,mi1s+so1s,mi1s+si1s,mi1e+si1eb,mi1e+si1e,mi1e+si1e,mi1e+do2e,...
    mi1e+si1e,mi1e+si1e,mi1e+si1e,mi1e+si1e,mi1e+si1e,mi1e+so1e,mi1e+si1e,mi1e+si1e,mi1e+so1e,mi1e+si1e,mi1e+si1e,mi1e+so1e,...
    som1e+so0e,re1e,si1eb,fam1eb+fa0eb,do1e,so1eu,...
    lam1e+la0e,mi1e,do2e,fam1e+fa0e,do1eu,si1eb,...
    si1e,mi1e,si0e,mim1fd+mi0fd];


s = (l+r)/max(l+r);
% audiowrite('Hedwig.flac',s,fs);%Save the music to a file