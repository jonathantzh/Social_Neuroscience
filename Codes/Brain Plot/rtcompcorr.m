function [ adj ] = rtcompcorr(eeg1,eeg2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

SR = 128;
count =1;
siz = min(length(eeg1),length(eeg2));
nchannels = size(eeg1,2);


for j = 1:nchannels
    for k = 1:nchannels
        adj(j,k,count) = max(xcorr(eeg1(1:SR,j),...
            eeg2(1:SR,k),'coeff'));
    end
end
count = count + 1;


end

