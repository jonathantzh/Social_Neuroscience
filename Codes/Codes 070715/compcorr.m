function [adj] = compcorr(eeg1,eeg2)
SR = 128;
count = 1;
siz = min(length(eeg1),length(eeg2));
nchannels = size(eeg1,2);

for i = 1: 0.5 :(siz/SR-2)
    for j = 1:nchannels
        for k = 1:nchannels
            %adj(j,k,count) = max(xcorr(eeg1(i*ceil(SR):(i+1)*ceil(SR),j),eeg2(i*ceil(SR):(i+1)*ceil(SR),k),'coeff'));
            adj(j,k,count) = abs(corr(eeg1(i*ceil(SR):(i+1)*ceil(SR),j),eeg2(i*ceil(SR):(i+1)*ceil(SR),k)));
        end
    end
    count = count + 1;
end
end