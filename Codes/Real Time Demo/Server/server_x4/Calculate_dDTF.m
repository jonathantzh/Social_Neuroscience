function dDTF = Calculate_dDTF(EEG_group,F_min,F_max,Fs)

% Function to calculate direct Directed Transfer function 
% Input: EEG_signal - Referenced EEG signal
%        F_min - Lower bound (in Hz) in eq.(3)in guidelines
%        F_max - Upper bound (in Hz) in eq.(3)in guidelines
%        Fs    - Sampling rate 
% Output: dDTF - average ddTF value over the frequency range 4-30Hz

%% Preamble 
% Parameters are taken here based on Neuroimage paper

[Num_chan Num_samples] = size(EEG_group);

Model_order = 6; 
[AR,RC,PE] = mvar(EEG_group',Model_order);

M = size(AR,1); % number of channels       
A = [eye(M),-AR];
B = eye(M); 
C = PE(:,M*Model_order+1:M*(Model_order+1)); 

%% Computation of the dDTF
N = 2^nextpow2(Num_samples); % number of frequency samples

[S,h,PDC,COH,DTF,DC, pCOH,dDTF,ffDTF, pCOH2, PDCF, coh,GGC,Af,GPDC,GGC2] = mvfreqz(B,A,C,N,Fs); 

%% Averaging dDTF
Resolution = Fs/N;

% Averaging dDTF from F_min Hz to F_max Hz
ref1=ceil(F_min/Resolution);
ref2=ceil(F_max/Resolution);

dDTF = dDTF(:,:,ref1:ref2);
dDTF= abs(mean(dDTF(:)));

