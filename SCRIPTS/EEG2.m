%% Loading Data
Sleep = load('C:\Users\miami\Desktop\Oxford\Matlab\B18 lab\DATA\B18_EEG_data\EEGSleepStateData.mat');
minutes = Sleep.EEGSleepStateData.minutes;
sleep_state = Sleep.EEGSleepStateData.sleep_state;
sleep_state_num = Sleep.EEGSleepStateData.sleep_state_num;
sleep_category = Sleep.EEGSleepStateData.sleep_category;
sleep_category_num = Sleep.EEGSleepStateData.sleep_category_num;

%% Plot hypnogram
time = 1:length(sleep_category_num);
figure
stairs(time, sleep_category_num);
ylim([0.5, 4.5])
xlabel('Time [mins]')
ylabel('Sleep State')
title('Sleep category')

%% Plot PSD
x = sleep_category_num;
x = x-mean(x);
fs = 60; %60 times per hour -- cycles per hour

window = hamming(length(x));
[pxx, f] = periodogram(x, window, [], fs);

figure
plot(f,pxx)
title('Sleep Category PSD')
xlabel('Frequency [Hz]')
ylabel('Power Spectral Density (mV^{2}Hz^{-1})')