function harmonicCell = InitializeHarmonic()
%INITIALIZEHARMONIC ͨ��������׼������Ǩ����ɫ
%   output:
%   ��׼��C1,C2,C3,C4,C5,C6,C7
%   ��Ӧ�Ļ�������ǰK��г����ϵ����������{harm_coef,avg_envelope}

% Config
fs = 44100;
firstKHarmonics = 8; %г������
harmonicCell = cell(1,7);

audioCell = cell(1,7);
[audioCell{1}, ~] = audioread('Piano/C1.mp3');
[audioCell{2}, ~] = audioread('Piano/C2.mp3');
[audioCell{3}, ~] = audioread('Piano/C3.mp3');
[audioCell{4}, ~] = audioread('Piano/C4.mp3');
[audioCell{5}, ~] = audioread('Piano/C5.mp3');
[audioCell{6}, ~] = audioread('Piano/C6.mp3');
[audioCell{7}, ~] = audioread('Piano/C7.mp3');

for cellCount=1:7
    audioCell{cellCount}=audioCell{cellCount}(:,1);
    [upper_envelope, lower_envelope] = envelope(audioCell{cellCount}, ceil(fs/500), 'rms');
    avg_envelope = (upper_envelope - lower_envelope);
    avg_envelope = avg_envelope / max(avg_envelope);
    Y = fft(audioCell{cellCount});
    L = length(audioCell{cellCount});
    f = fs*(0:round(L/2))/L; %fft����һ��Ϳ���
    P2 = Y(1:round(L/2)+1);
    P1 = 2*abs(P2(1:end-1)); %����ģ����ȥͷȥβ����0ֵ
    P1(1) = P1(1)/2;
    
    % Find the optimal distance
    [maxValue, index] = max(P1);
	dist = f(ceil(index*0.9));
    
    % Find the local maxima (possible harmonics and their location)
    % Ignoring peaks that are very close to each other
    [peaks, oriLocs] = findpeaks(P1, 1:length(P1), 'MinPeakDistance', dist);
    % The corresponding frequencies and phase
    freqsOfPeaks = f(oriLocs);
    phasesOfPeaks = angle(P2(oriLocs));
    
    % Transpose to colomn vectors
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
    peaks = peaks/maxValue;
    toSortPeaks = horzcat(peaks, freqsOfPeaks, phasesOfPeaks);
    sortedPeaks = transpose(sortrows(toSortPeaks, 1, 'descend'));
    sortedL = min([length(sortedPeaks) firstKHarmonics]);
    harm_coef = sortedPeaks(:, 1:sortedL);
    harmonicCell{cellCount}={harm_coef,avg_envelope};
end
end

