clear
%load desired .mat file
load('/Users/Jon/Desktop/Social_Neuroscience/recordings/1v1physical/EEGlog-P1AH1C2M2b -20150701T143228.mat', 'recordData')
testData1 = recordData;
load('/Users/Jon/Desktop/Social_Neuroscience/recordings/1v1physical/EEGlog-P1BH2C2M2b-20150701T143127.mat', 'recordData')
testData2 = recordData;

%extracting desired data channels
data1 = extractData('/Users/Jon/Desktop/Social_Neuroscience/recordings/1v1physical/EEGlog-P1AH1C2M2b -20150701T143228.mat');

data2 = extractData('/Users/Jon/Desktop/Social_Neuroscience/recordings/1v1physical/EEGlog-P1AH1C2M2b -20150701T143228.mat');

%applying band-pass filter to delta freq band
delta1 = Band_pass_filter(data1,1,4,128);
delta2 = Band_pass_filter(data2,1,4,128);

%extracting single channel data for cross-correlation
single1 = delta1(:,1);
single2 = delta2(:,1);

%compute xcorr
[r(:,1),r(:,2)] = xcorr(single1-mean(single1), single2-mean(single2),'coeff');
