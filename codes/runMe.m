clc
clear
close all
%% Load EEG signals here
nTrial = 12;
exp = '1vs1Physical';
IBD = nan(nTrial,1);
for i = 1:nTrial
load(['experimentData/' exp filesep 'Player1'...
    filesep 'trial' num2str(i) '.mat']);
aEEG = recordData(:,4:17);

load(['experimentData' filesep exp filesep 'Player2'...
    filesep 'trial' num2str(i) '.mat']);

bEEG = recordData(:,4:17);
%% Data analysis
[adj] = brainSynchrony(aEEG, bEEG);
threshold = 0.1;
IBD(i,1) = brainDensity(adj, threshold);
end
save(['Results' filesep exp '.mat'], 'IBD');