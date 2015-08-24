function [DTF dDTF ffDTF] = Compute_Granger_Measures(EEG_signal,T,F_min,F_max,Fs)

% Function to compute granger causality measures-DTF, dDTF, ffDTF.
%
% Input: 
%        EEG_Signal - Referenced EEG signal
%        T  - Time period of the EEG segments. Granger measure is computed for this 
%	      segment and then averaged over a number of segments.
%        F_min - Lower bound (in Hz) in eq.(3)in guidelines
%        F_max - Upper bound (in Hz) in eq.(3)in guidelines
%        Fs    - Sampling rate 
% Output: 
%         DTF   - Averaged DTF
%         dDTF  - Averaged dDTF 
%         ffDTF - Averaged ffDTF

%% Grouping signals
Num_groups = 5;
Group{1} = [1 2 4 6];      % Pre-frontal and frontal
Group{2} = [3 8 13];       % Left temporal
Group{3} = [5 9 10 11 15]; % Central
Group{4} = [7 12 17];      % Right temporal
Group{5} = [14 16 18 19];  % Occipital 

%% Computation of average signal for each group
[Num_chan Num_samples] = size(EEG_signal);
EEG_group = zeros(Num_groups,Num_samples);

for i=1:Num_groups 
    for j=1:length(Group{i})
        EEG_group(i,:)=EEG_group(i,:)+EEG_signal(Group{i}(j),:);
    end
    EEG_group(i,:) = EEG_group(i,:)./length(Group{i});   
end

%% Computing DTF, dDTF and ffDTF for a time window T seconds 
k=1;
Num_samples_epoch = (Fs*T);
Num_epochs = floor(Num_samples/Num_samples_epoch);

if Num_epochs<1
    error('The value of T exceeds the available data. Please enter value less than 20.');    
end

for i=1:Num_epochs,
    DTF(i) = Calculate_DTF(EEG_group(:,k:k+Num_samples_epoch-1),F_min,F_max,Fs);
    dDTF(i) = Calculate_dDTF(EEG_group(:,k:k+Num_samples_epoch-1),F_min,F_max,Fs);
    ffDTF(i) = Calculate_ffDTF(EEG_group(:,k:k+Num_samples_epoch-1),F_min,F_max,Fs);
    k=k+Num_samples_epoch;
end
DTF   = mean(DTF);
dDTF  = mean(dDTF);
ffDTF = mean(ffDTF);
