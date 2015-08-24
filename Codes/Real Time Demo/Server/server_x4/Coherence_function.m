function average_coherence = Coherence_function(EEG_signal,T,F_min,F_max,Fs)

% Function to average magnitude coherence from the coherence function
%
% Input: 
%        EEG_signal - Referenced EEG signal  
%        T  - Time period of the EEG segments. Coherence is computed for this 
%	      segment and then averaged over a number of segments.
%        F_min - Lower bound (in Hz) in eq.(3)in guidelines
%        F_max - Upper bound (in Hz) in eq.(3)in guidelines
%        Fs    - Sampling rate 
% Output: 
%        average_coherence - Average coherence between F_min Hz to F_max Hz


%% Preamble
[Num_chan Num_samples] = size(EEG_signal);

%% Grouping signals
Num_groups = 5;
Group{1} = [1 2 4 6];      % Pre-frontal and frontal
Group{2} = [3 8 13];       % Left temporal
Group{3} = [5 9 10 11 15]; % Central
Group{4} = [7 12 17];      % Right temporal
Group{5} = [14 16 18 19];  % Occipital 

%% Computation of average signal for each group and its FFT
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

%% Computation of the average coherence in each epoch
k=1;
for i=1:epoch,
    average_coherence(i) = Coherence_function_epoch(EEG_group(:,k:k+Num_samples_epoch-1),Num_groups,T,F_min,F_max,Fs);
    k=k+Num_samples_epoch;
end
average_coherence = mean(average_coherence); % Averaging over T (epochs)
end

%% Child function to compute average coherence - eq.(3) in guideline
function average_coherence_epoch = Coherence_function_epoch(EEG_group,Num_groups,T,F_min,F_max,Fs)

%% Computation of FFT for group signals
NFFT = 2^nextpow2(T*Fs);
for i=1:Num_groups,
   EEG_group_fft(i,:) = fft(EEG_group(i,:),NFFT);
end

%% Computation of magnitude coherence function - eq 2 in Guideline 
N=1;
for i=1:Num_groups,
    for j=1:Num_groups,
        if i<j            
            for k=1:NFFT; 
                Magnitude_coherence_function(N,k) = abs(EEG_group_fft(i,k)*conj(EEG_group_fft(j,k)))^2/(abs(EEG_group_fft(i,k))*abs(EEG_group_fft(j,k)));                
            end
            N=N+1;
        end        
    end
end

%% Calculation of average coherence
Resolution = Fs/NFFT;
% Generating indices for the frequencies F_min and F_max
Index_min = floor(F_min/Resolution);
Index_max = floor(F_max/Resolution);

% Selecting the coherence function from Index_min to Index_max
coherence_selective = Magnitude_coherence_function(:,Index_min:Index_max);

average_coherence = mean(coherence_selective); % averaging over the combination
average_coherence_epoch = mean(average_coherence); % Averaging over the frequencies
end
