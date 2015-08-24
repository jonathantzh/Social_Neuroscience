function LZ_complexity_avg = Compute_LZ_complexity(EEG_signal)

% Function to compute the average LZ complexity
% 
% Input: 
%       EEG_signal - Referenced EEG signal 
% Output: 
%       LZ_complexity_avg - Average LZ complexity 

%% Preamble
[Num_chan temp] = size(EEG_signal);

%% Converting the signal to binary 
for i=1:Num_chan,
   median_EEG = median(EEG_signal(i,:));
   binary_EEG = double((EEG_signal(i,:)> median_EEG));
   %% complexity computation
   LZ_complexity(i) = kolmogorov(binary_EEG);
end
LZ_complexity_avg = mean(LZ_complexity);
