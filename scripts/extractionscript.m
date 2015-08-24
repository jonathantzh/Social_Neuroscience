clear
%load desired .mat file
load('/Users/Jon/Desktop/Social_Neuroscience/recordings/1v1physical/EEGlog-P1AH1C2M2b -20150701T143228.mat', 'recordData')
testData1 = recordData;
load('/Users/Jon/Desktop/Social_Neuroscience/recordings/1v1physical/EEGlog-P1BH2C2M2b-20150701T143127.mat', 'recordData')
testData2 = recordData;

%extracting desired data channels
fullextractedData1 = testData1(:,4:17);
fullextractedData1(:, 2) = [];
fullextractedData1(:, 3) = [];
fullextractedData1(:, 5) = [];
fullextractedData1(:, 5) = [];
fullextractedData1(:, 7) = [];
fullextractedData1(:, 8) = [];

fullextractedData2 = testData2(:,4:17);
fullextractedData2(:, 2) = [];
fullextractedData2(:, 3) = [];
fullextractedData2(:, 5) = [];
fullextractedData2(:, 5) = [];
fullextractedData2(:, 7) = [];
fullextractedData2(:, 8) = [];

%applying band-pass filter to delta freq band
delta1 = Band_pass_filter(fullextractedData1,1,4,128);
delta2 = Band_pass_filter(fullextractedData2,1,4,128);

%extracting single channel data for cross-correlation
single1 = delta1(:,1);
single2 = delta2(:,1);

%compute xcorr
xcorrelation = xcorr(single1, single2);
