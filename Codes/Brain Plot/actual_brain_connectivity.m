close all
clear all
clc

newData1 = load('EEGlog-P1AH1C5M2 -20150630T144043.mat');

tempdata1 = fieldnames(newData1);
for i = 1:length(tempdata1)
    assignin('base', tempdata1{i}, newData1.(tempdata1{i}));
end

reference1 = mean(tempdata1,2);
data1 = bsxfun(@minus,tempdata1,reference1);

newData2 = load('EEGlog-P1AH1C5M5 -20150630T145114');

tempdata2 = fieldnames(newData2);
for i = 1:length(tempdata2)
    assignin('base', tempdata2{i}, newData2.(tempdata2{i}));
end

reference2 = mean(tempdata2,2);
data2 = bsxfun(@minus,tempdata2,reference2);

connectivity=compcorr(data1,data2);

set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
for x = 1:size(connectivity,3)
    cla;
    brain_plot(connectivity(:,:,x),0.5);
    pause(0.5);
    figure_1(x) = getframe;
end
% Uncomment this to save the movie as avi
% movie2avi(figure_1,'figure_1.avi','quality',100,'fps',5);