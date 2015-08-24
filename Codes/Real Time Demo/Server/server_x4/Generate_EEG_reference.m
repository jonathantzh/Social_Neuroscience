function EEG_signal = Generate_EEG_reference(X)

% Function to reference the given EEG signal 
%
% Input:
%       X - Raw EEG signal
% Output: 
%       EEG_singal - EEG signal after referencing


%% Generate reference signal 
[Num_chan temp] = size(X);
Num_chan=Num_chan-2;
% Generating refernce by averaging the reference channels
Reference = (X(8,:)+X(14,:))/2;


%% Generating EEG signal after referencing
EEG_signal = [X(1:7,:); X(9:13,:); X(15:end,:)];
for i=1:Num_chan,
    EEG_signal(i,:) = EEG_signal(i,:)-Reference;
end
