function  average_spatial_correlation = Correlation_spatial(EEG_signal,T,Fs)

% Function to compute the average time domain correlation measure r
% 
% Input: 
%         EEG_signal - Referenced EEG signal
%         T  - Time period of the EEG segments. Correlation is computed for this 
%	      segment and then averaged over a number of segments.
%         Fs - Sampling rate
% Output: 
%       average_spatial_correlation         

%% Grouping signals
Num_groups = 5;
Group{1} = [1 2 4 6];      % Pre-frontal and frontal
Group{2} = [3 8 13];       % Left temporal
Group{3} = [5 9 10 11 15]; % Central
Group{4} = [7 12 17];      % Right temporal
Group{5} = [14 16 18 19];  % Occipital 

%% Computation of average signal for each group and its FFT
[Num_chan Num_samples] = size(EEG_signal);
EEG_group = zeros(Num_groups,Num_samples);

for i=1:Num_groups 
    for j=1:length(Group{i})
        EEG_group(i,:)=EEG_group(i,:)+EEG_signal(Group{i}(j),:);
    end
    EEG_group(i,:) = EEG_group(i,:)./length(Group{i});   
end
%% Determining the number of epochs
Num_samples_epoch = T*Fs;
epoch = floor(Num_samples/Num_samples_epoch);
if epoch<1
    error('The value of T exceeds the available data. Please enter value less than 20.');    
end

%% Computation of correlation in each epoch
k=1;
for i=1:epoch,  
    Correlation_epoch(i) = Compute_correlation_epoch(EEG_group(:,k:k+Num_samples_epoch-1),Num_groups);
    k= k+Num_samples_epoch;
end
    average_spatial_correlation = mean(Correlation_epoch);
end

%% Child function for computing Correlation in an epoch
function average_spatial_correlation_epoch = Compute_correlation_epoch(EEG_group,Num_groups)
% Function to compute the average spatial correlation of an epoch of EEG 
% of the whole data
%% computing correlation among the EEG groups
k=1;
for i=1:Num_groups,
    for j=1:Num_groups,
        if i<j
            temp_corr = corrcoef(EEG_group(i,:),EEG_group(j,:));
            corr_matrix(k) = temp_corr(1,2);             
            k=k+1;
        end        
    end
end;
average_spatial_correlation_epoch = mean(corr_matrix);
end
