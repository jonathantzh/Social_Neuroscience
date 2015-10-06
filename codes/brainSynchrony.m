function [adj] = brainSynchrony(aEEG, bEEG)

nChan = size (aEEG,2);
adj = zeros(nChan);
aEEG = preProcess(aEEG);
bEEG = preProcess(bEEG);

%% Synchrony measure: Cross correlation
% Remove this loop. Please check if xcorr2 can be used
for i = 1: nChan
    for j = 1: nChan
         adj(i,j) = max(xcorr(aEEG(:,i)-mean(aEEG(:,i)),...
             bEEG(:,j)-mean(bEEG(:,j)),'coeff'));
    end
end
end