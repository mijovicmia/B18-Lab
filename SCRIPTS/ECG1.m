%% Loading Data
D = load('C:\Users\miami\Desktop\Oxford\Matlab\B18 lab\DATA\B18_ECG_data\PhysionetData.mat');

%% 1. run tabulate analysis
tab = D.RecordingInfo;
tabulate(tab{:,2});