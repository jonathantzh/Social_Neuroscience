function [amplitude_spectrum freq] = Compute_spectrum(X, Fs)

% Function to compute single side amplitude spectrum of EEG signals 
% for all the channels 
%
% Input 
%      X    - EEG signal arranged in rwo format
%      Fs   - Sampling frequency
% Output 
%      amplitude spectrum - in rows for all the channels
%      f  - corresponding frequency bins

%% Preamble 
[Num_chan Num_samples] = size(X);
NFFT = 2^nextpow2(Num_samples); % Next power of 2 from length of signal

%% Computing amplitude spectrum from FFT 

freq = Fs/2*linspace(0,1,NFFT/2);

for i=1:Num_chan,
    Y = fft(X(i,:),NFFT);
    power_spectrum = (Y.*conj(Y));
    % Eqn 7.2 in book "Signal processing for neuroscientists"
    amplitude_spectrum(i,:) = 2*sqrt(power_spectrum(1:NFFT/2))/NFFT;
end


