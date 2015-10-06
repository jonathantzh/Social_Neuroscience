%% Filtering Function
function[output]=compFilterbf(EEG, cutoff, sample_rate, high_or_low, order)

    ny=sample_rate/2;
    cutoff=cutoff/ny;
    [b,a] = butter(order, cutoff, high_or_low);
    EEG_f = filter(b,a,EEG);
    EEG_f_reverse = EEG_f(end:-1:1, :);
    EEG_f_reverse_f = filter(b,a,EEG_f_reverse);
    output = EEG_f_reverse_f(end:-1:1, :);
    
end