function EEG_signal_filt = Band_pass_filter(EEG_signal,Cut_off_freq_1,Cut_off_freq_2,Fs)

% Function to implement band-pass filtering using FIR filter.
%
% Usage: EEG_signal_filt = Band_pass_filter(EEG_signal,Cut_off_freq_1,Cut_off_freq_2,Fs)
% Input: 
%      EEG_signal - Referenced EEG signal 
%      Cut_off_freq_1 &  Cut_off_freq_2 - cut-off frequencies in linear 
%                                         scale (in hertz) 
%      Fs  - sampling frequency in Hertz
% Output:
%      EEG_signal_filt - Band-pass filtered EEG signal 

%% Preamble 
Nyquist_freq = Fs/2;
[Num_chan temp] = size(EEG_signal);

%% FIR filter of order 100
% Normalized frequencies 
W =  [Cut_off_freq_1 Cut_off_freq_2]./Nyquist_freq; 
Filter_coeffs = fir1(100,W);

for i=1:Num_chan,
   EEG_signal_filt(i,:) = filter(Filter_coeffs,1,EEG_signal(i,:));    
end

