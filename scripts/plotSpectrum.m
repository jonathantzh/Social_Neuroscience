function plotSpectrum(EEG, Fs)
    
NFFT        = 2.^nextpow2(EEG);    
EEG_FFT    = (1./sqrt(NFFT)) * fft(EEG, NFFT)';


% plotting
freq_scale = linspace(0,Fs/2,NFFT/2+1);
figure; 
plot(freq_scale, abs(EEG_FFT(0:NFFT/2+1)));
xlabel('Frequency (Hz)');
ylabel('Amplitude (|f|)');
title('Single Sided Spectrum');

end