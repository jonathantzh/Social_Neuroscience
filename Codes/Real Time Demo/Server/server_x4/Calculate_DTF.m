function DTF = Calculate_DTF(EEG_group,F_min,F_max,Fs)

% Function to calculate Directed Transfer function 
% Input: EEG_signal - Referenced EEG signal
%        F_min - Lower bound (in Hz) in eq.(3)in guidelines
%        F_max - Upper bound (in Hz) in eq.(3)in guidelines
%        Fs    - Sampling rate 
% Output: DTF = average 

%% Preamble 
% Parameters are taken here based on Neuroimage paper

[Num_chan Num_samples] = size(EEG_group);

Model_order = 9; 
[AR,RC,PE] = mvar(EEG_group',Model_order);

M = size(AR,1); % number of channels       
A = [eye(M),-AR];
B = eye(M); 
C = PE(:,M*Model_order+1:M*(Model_order+1)); 

%% Computation of the DTF
N = 2^nextpow2(Num_samples); % number of frequency samples

[S,h,PDC,COH,DTF,DC, pCOH,dDTF,ffDTF, pCOH2, PDCF, coh,GGC,Af,GPDC,GGC2] = mvfreqz(B,A,C,N,Fs); 

%% Averaging DTF
Resolution = Fs/N;

% Averaging DTF from F_min Hz to F_max Hz
ref1=ceil(F_min/Resolution);
ref2=ceil(F_max/Resolution);

DTF = DTF(:,:,ref1:ref2);
DTF= mean(DTF(:));

