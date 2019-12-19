clear all

% Configuration
firstKHarmonics = 5;
filename='Piano/51.ogg';

% Get the sample array and sampling frequency.
[audio, one_sec_index] = audioread(filename);
audio = audio(:,1); % Get data of only one tunnel

% Multiple ways to get the envelope 
[upper_envelope, lower_envelope] = envelope(audio, ceil(one_sec_index/500), 'rms');

avg_envelope = (upper_envelope - lower_envelope); % Kick out the DC component
avg_envelope = avg_envelope / max(avg_envelope); % Standarization

% Fourier Transformation
fs = 44100;
Y = fft(audio); % Y are complexes
L = length(audio);
f = fs*(0:(L/2))/L;
% P2 = abs(Y)/L;  % Modulus of complexes
% P2 = Y/L
P2 = Y(1:L/2+1);  % Phase maintainer
P1 = 2*abs(P2(1:end-1));
P1(1) = P1(1)/2;

% Find the optimal distance
[maxValue, index] = max(P1);
dist = f(ceil(index*0.9));

% Find the possible harmonics and their location
[peaks, oriLocs] = findpeaks(P1, 1:length(P1), 'MinPeakDistance', dist);
% The corresponding frequencies and phase
freqsOfPeaks = f(oriLocs);
phasesOfPeaks = angle(P2(oriLocs));

% Transpose
size_peaks = size(peaks);
if size_peaks(1) == 1
    peaks = transpose(peaks);
end
size_freqs = size(freqsOfPeaks);
if size_freqs(1) == 1
    freqsOfPeaks = transpose(freqsOfPeaks);
end
size_phase = size(phasesOfPeaks);
if size_phase(1) == 1
    phasesOfPeaks = transpose(phasesOfPeaks);
end

% Get the harmonics
peaks = peaks/maxValue;   % Standarization
toSortPeaks = horzcat(peaks, freqsOfPeaks, phasesOfPeaks);
sortedPeaks = transpose(sortrows(toSortPeaks, 1, 'descend'));
sortedL = min([length(sortedPeaks) firstKHarmonics]);
harm_coef = sortedPeaks(:, 1:sortedL);

    