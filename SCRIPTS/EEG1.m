%% Loading Data
Open = load('C:\Users\miami\Desktop\Oxford\Matlab\B18 lab\DATA\B18_EEG_data\EEGeyesopen.mat');
open = Open.eyesopen;
Closed = load('C:\Users\miami\Desktop\Oxford\Matlab\B18 lab\DATA\B18_EEG_data\EEGeyesclosed.mat');
closed = Closed.eyesclosed;
%% Plot samples
fs = 256; %Sampling freq (Hz)
samples = 1:512;
time = samples./fs;

figure;
plot(time, closed(samples))
xlabel('Time (s)')
ylabel('Amplitude (micro V)')
title('EEG with Eyes Closed')

figure(2);
plot(time, open(samples))
xlabel('Time (s)')
ylabel('Amplitude (micro V)')
title('EEG with Eyes Open')

%% Pre-processing
%% Detrending and normalising
open = normalize(open-mean(open));
closed = normalize(closed - mean(closed));

%% Filtering
fc = 35; % cut−off frequency (Hz)
norder = 4; %filter order
%The cut-off frequency Wn must be 0.0<Wn<1.0;
Wn = fc/fs;
%Design the filter
[B,A] = butter(norder, Wn);
%Apply the LPF
open_f = filter(B,A,open);
closed_f = filter(B,A,closed);

%% Plot
figure(3)
plot(time, closed_f(samples))
xlabel('Time (s)')
ylabel('Amplitude (micro V)')
title(['Pre-processed EEG with Eyes Closed, fc=', num2str(fc), 'Hz'])

figure(4);
plot(time, open_f(samples))
xlabel('Time (s)')
ylabel('Amplitude (micro V)')
title(['Pre-processed EEG with Eyes Open, fc=', num2str(fc), 'Hz'])

%% PSD
window = hamming(length(open_f));
[pxxO, fO] = periodogram(open_f, window, [], fs, 'psd');

window = hamming(length(closed_f));
[pxxC, fC] = periodogram(closed_f, window, [], fs, 'psd');

figure
subplot(1,2,1)
plot(fO, pxxO);
xlim([0,60]);
title('Eyes Open PSD')
xlabel('Frequency (Hz)')
ylabel('Power Spectral Density (mV^{2}Hz^{-1})')
axis square

subplot(1,2,2)
plot(fC, pxxC);
xlim([0,60]);
title('Eyes Closed PSD')
xlabel('Frequency (Hz)')
ylabel('Power Spectral Density (mV^{2}Hz^{-1})')
axis square