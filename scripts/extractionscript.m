clear
%load desired .mat file
load('/Users/Jon/Desktop/Social_Neuroscience/recordings/1v1physical/EEGlog-P1AH1C2M2b -20150701T143228.mat', 'recordData1')
load('/Users/Jon/Desktop/Social_Neuroscience/recordings/1v1physical/EEGlog-P1BH2C2M2b-20150701T143127.mat', 'recordData2')

fullextractedData1 = recordData1(:,4:17);
fullextractedData1(:, 2) = []; %extracting desired data channels
fullextractedData1(:, 3) = [];
fullextractedData1(:, 5) = [];
fullextractedData1(:, 5) = [];
fullextractedData1(:, 7) = [];
fullextractedData1(:, 8) = [];

fullextractedData2 = recordData2(:,4:17);
fullextractedData2(:, 2) = []; %extracting desired data channels
fullextractedData2(:, 3) = [];
fullextractedData2(:, 5) = [];
fullextractedData2(:, 5) = [];
fullextractedData2(:, 7) = [];
fullextractedData2(:, 8) = [];

%save fullextractedData as testData