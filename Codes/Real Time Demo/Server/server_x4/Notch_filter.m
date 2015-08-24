function EEG_signal_filt = Notch_filter(EEG_signal,Cut_off_freq,Fs)

% Function to implement notch filter using IIR filter. 
%
% Usage: EEG_signal_filt = Notch_filter(EEG_signal,Cut_off_freq,Fs)
% Input: 
%      EEG_signal - Referenced EEG signal 
%      Cut_off_freq - cut-off frequencies in linear scale (in hertz) 
%      Fs  - sampling frequency
% Output:
%      EEG_signal_filt - filtered EEG signal 

%% Preamble 
Nyquist_freq = Fs/2;
[Num_chan temp] = size(EEG_signal);


%% IIR notch filter of Order-2 
% Normalized frequencies 

Wo =  Cut_off_freq/Nyquist_freq; BW = Wo/35;
[Filter_coeffs_num Filter_coeffs_den] = iirnotch(Wo,BW);

for i=1:Num_chan,
   EEG_signal_filt(i,:) = filter(Filter_coeffs_num,Filter_coeffs_den,EEG_signal(i,:));    
end

