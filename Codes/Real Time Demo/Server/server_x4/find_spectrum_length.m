function length_spec = find_spectrum_length(EEG_matrix,NFFT)

% -----------
% Function to compute the length of the FFT depending on whether the data
% is having even or odd samples. 
% Input: EEG_matrix - time samples along the columns and spatial samples
%                     along rows
%        NFFT - number of desired points in the FFT 
% Ouput: length_spec - length of the spectrum 
% -----------

if mod(size(EEG_matrix,2),2)==1,
    length_spec = (NFFT+1)/2;
else
    length_spec = NFFT/2+1;
end; 

% [EOF]