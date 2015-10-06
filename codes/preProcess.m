function EEG = preProcess(signal)

signal(any(isnan(signal),2),:) = [];

% Normalization
signal = signal/max(max(abs(signal)));

% Referencing
ref = mean(signal,2);
signal = bsxfun(@minus, signal, ref);

% Filtering
EEGf = compFilterbf(signal, 50, 128, 'low', 3);
EEG = compFilterbf(EEGf, 1, 128, 'high', 3);

% Please plot the spectrum of filtered (EEG) and un-filtered signal (EEGf) 
% Refer this https://www.youtube.com/watch?v=dwzQnbeKnQg

end