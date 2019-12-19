%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Final Project: Piano Sound Synthesis
% By: Teng Wei Jian
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% NOTES:
% 1) This is a function that synthesizes the sound of a piano. It takes the
% frequency of the note to be modeled as an input and returns the signal
% of the synthesized note as an output. The function will also play the
% sound once.
% 2) The code is divided into two parts, the first part will model the
% force signal of the piano hammer and the second part will model the
% piano string. Extra notes regarding each part will be included at the
% beginning of each section.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output=pianoGenerator(f0,timeL)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART I: PIANO HAMMER MODEL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1) As detailed in the report, the model is defaulted to simulate the
% force of the hammer strike for a C4 string with the initial velocity
% of 4 m/s.
% 2) The parameters of the hammer can be changed according to the measured
% values (if available). Otherwise the same force signal will be used to
% simulate ALL the notes.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fs=44100; % Sampling frequency
N=65; % Number of spatial grid points
L=0.62; % Length of the piano wire
Ms=3.93/1000; % Mass of the piano wire
Mh=2.97/1000; % Mass of the hammer
K=4.5*10^9; % Hammer stiffness coefficient
T=670; % Tension in the piano wire
p=2.5; % Stiffness non-linear component
alpha=0.12; % Relative striking position
b1=0.5; % Damping coefficient
b3=6.25*10^-9; % Damping coefficient
epsilon=3.82*10^-5; % String stiffness parameter
v=4; % Initial hammer velocity
R0=sqrt(T*Ms/L); % Wave impedance of the piano wire
i0=round(alpha*N); % Striking position of the hammer
c=sqrt(T/(Ms/L)); % Wave speed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Defining the coefficients of the wave equation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D=1+b1/Fs+2*b3*Fs;
r=c*N/(Fs*L);
a1=( 2 - 2*r^2 + b3*Fs - 6*epsilon*N^2*r^2 )/D;
a2=( -1 + b1/Fs + 2*b3*Fs )/D;
a3=( r^2*( 1 + 4*epsilon*N^2 ) )/D;
a4=( b3*Fs - epsilon*N^2*r^2 )/D;
a5=( -b3*Fs )/D;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initializing some variables %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input_length=1000;
y=zeros(N,input_length); % Displacement of the string
yh=zeros(1,input_length); % Displacement of the hammer
F=zeros(1,input_length); % Force signal output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initializing the values for the first few time steps of the simulation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y(:,1)=0;
yh(2)=v/Fs;
y(1,2)=0;
y(N,2)=0;
y(2:N-1,2)=(y(3:N,1)+y(1:N-2,1))/2;
F(2)=K*abs(yh(2)-y(i0,2))^p;
y(1,3)=0;
y(N,3)=0;
y(2:N-1,3)=y(3:N,2)+y(1:N-2,2)-y(2:N-1,1);
y(i0,3)=y(i0+1,2)+y(i0-1,2)-y(i0,1)+((1/Fs)^2*N*F(2))/Ms;
yh(3)=2*yh(2)-yh(1)-((1/Fs)^2*F(2))/Mh;
F(3)=K*abs(yh(3)-y(i0,3))^p;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loop through the remaining time steps, implementing the finite difference
% hammer and string model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for n=4:input_length
 y(1,n)=0;
 y(N,n)=0;
 y(2,n)= a1*y(2,n-1)+a2*y(2,n-2)+...
 a3*(y(3,n-1)+y(1,n-1))+...
 a4*(y(4,n-1)-y(2,n-1))+...
 a5*(y(3,n-2)+y(1,n-2)+y(2,n-3));
 y(N-1,n)= a1*y(N-1,n-1)+a2*y(N-1,n-2)+...
 a3*(y(N,n-1)+y(N-2,n-1))+...
 a4*(y(N-3,n-1)-y(N-1,n-1))+...
 a5*(y(N,n-2)+y(N-2,n-2)+y(N-1,n-3));
 y(3:N-2,n)= a1*y(3:N-2,n-1)+a2*y(3:N-2,n-2)+...
 a3*(y(4:N-1,n-1)+y(2:N-3,n-1))+...
 a4*(y(5:N,n-1)+y(1:N-4,n-1))+...
  a5*(y(4:N-1,n-2)+y(2:N-3,n-2)+y(3:N-2,n-3));

 y(i0,n)= a1*y(i0,n-1)+a2*y(i0,n-2)+...
 a3*(y(i0+1,n-1)+y(i0-1,n-1))+...
 a4*(y(i0+2,n-1)+y(i0-2,n-1))+...
 a5*(y(i0+1,n-2)+y(i0-1,n-2)+y(i0,n-3))+...
 ((1/Fs)^2*N*F(n-1))/Ms;

 yh(n)=2*yh(n-1)-yh(n-2)-((1/Fs)^2*F(n-1))/Mh;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Check for when the hammer is no longer in contact with the string %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 if (yh(n)-y(i0,n))>0
 F(n)=K*abs(yh(n)-y(i0,n))^p;
 else
 F(n)=0;
 end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Changes the force signal into a veolcity to be fed into the digital
% waveguide model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v=F/(2*R0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART I: PIANO STRING MODEL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1) For easier reference the variables used will be listed here:
%
% al Loss Filter coefficient
% gl Loss Filter gain
% ad Dispersion Filter coefficient
% ap_num Number of allpass filters used in the Dispersion Filter
% offtune Variation in the Tuning Filter to make sure the three
% waveguides have different frequency
% N Length of the entire delay line of the waveguide model
% M Length of the two parallel delay lines
% P Difference between the exact delay line length reqruied and
% the actual length implemented
% C The Tuning Filter coefficient
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize the output %
%%%%%%%%%%%%%%%%%%%%%%%%%
output_length=length(timeL);
output=zeros(1,output_length);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convolves the input signal with the recorded response of the piano boday
% being knocked.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ir=wavread('IR.wav');
% v_new=conv(v,ir);
v_in=[v zeros(1,length(output)-length(v))];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define/Calculate some of the parameters that will be used.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The parameters of the filter are changed according to frequency to give a
% more consistent and normalized output.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if f0>3000
 gl=-0.997;
 ap_num=0;
 offtune=0.01;
elseif f0>1900
 gl=-0.997;
 ap_num=2;
 offtune=0.005;
elseif f0>1800
 gl=-0.997;
 ap_num=3;
 offtune=0.005;
elseif f0>1500
 gl=-0.995;
 ap_num=4;
 offtune=0.01;
elseif f0>980
 gl=-0.995;
 ap_num=6;
 offtune=0.02;
elseif f0>750
 gl=-0.993;
 ap_num=8;
 offtune=0.03;
elseif f0>390
 gl=-0.99;
 ap_num=12;
 offtune=0.04;
elseif f0>261.626
 gl=-0.985;
 ap_num=14;
 offtune=0.06;
elseif f0>200
 gl=-0.98;
 ap_num=16;
 offtune=0.09;
elseif f0>150
 gl=-0.975;
 ap_num=18;
 offtune=0.13;
elseif f0>120
 gl=-0.968;
 ap_num=20;
 offtune=0.18;
else
 gl=-0.96;
 ap_num=20;
 offtune=0.25;
end
al=-0.001;
ad=-0.30;
N_exact=((2*pi+ap_num*atan(((ad^2-1)*sin(2*pi*f0/Fs))/...
 (2*ad+(ad^2+1)*cos(2*pi*f0/Fs))))/(2*pi*f0/Fs));
M=floor(N_exact/2);
P=N_exact-2*M;
C=(1-P)/(1+P);
i0=round(alpha*M);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Defines the transfer function for the delays and filters used:
%
% DL1 The delay line representing the segment of the string from the
% agraffe to the point of contact with the hammer
% DL2 The delay line representing the segment of the string from the
% point of contact with the hammer to the bridge
% Hl The Loss Filter
% Hd One of the the allpass filters that make up the Dipersion Filter
% Hfd Hfd1, Hfd2 and Hfd2 are the Tuning Filters used to tune the
% fundamental frequency. The 3 filters are each used in one of the
% 3 parallelly connected digital waveguide models.
%
% H H1, H2 and H3 are the Reflections Filters for each of the 3
% digital waveguide models. They are made up of the Loss Filter,
% the Dipersion Filter and the Tuning Filter.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z=tf('z',1/Fs);
DL1=(z)^-(M-i0);
DL2=(z)^-(i0);
Hl=gl*(1+al)/(1+al*z^-1);
Hd=(ad+z^-1)/(1+ad*z^-1);
Hfd1=(C+z^-1)/(1+C*z^-1);
Hfd2=(C*(1+offtune)+z^-1)/(1+C*(1+offtune)*z^-1);
Hfd3=(C*(1-offtune)+z^-1)/(1+C*(1-offtune)*z^-1);
if C*(1+offtune)>=1 % Makes sure the coefficient of the
 Hfd2=(1+z^-1)/(1+1*z^-1); % Tuning Filter does not excede 1
end
H1=Hl*Hd^ap_num*Hfd1;
H2=Hl*Hd^ap_num*Hfd2;
H3=Hl*Hd^ap_num*Hfd3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The filters are then combined according to the digital waveguide model of
% the piano string.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DW1=DL1/(1+H1*DL1*DL1*DL2*DL2)+DL2*DL2*DL1*(-1)/(1+H1*DL1*DL1*DL2*DL2);
DW2=DL1/(1+H2*DL1*DL1*DL2*DL2)+DL2*DL2*DL1*(-1)/(1+H2*DL1*DL1*DL2*DL2);
DW3=DL1/(1+H3*DL1*DL1*DL2*DL2)+DL2*DL2*DL1*(-1)/(1+H3*DL1*DL1*DL2*DL2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The Digital Waveguide filter is then used on the input velocity.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[b a]=tfdata(DW1,'v');
output1=filter(b,a,v_in);
[b a]=tfdata(DW2,'v');
output2=filter(b,a,v_in);
[b a]=tfdata(DW3,'v');
output3=filter(b,a,v_in);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output of the three digital waveguides re summed together. The sum is
% then normalized. The final output is then played.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output=output1+output2+output3;
output=output/max(abs(output))*(1 - 1/32768);