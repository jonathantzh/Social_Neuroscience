function [ adj ] = rtcompcorr(eeg1,eeg2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

SR = 128;    

%eeg1 = butter(2,0.01,'high');
%eeg2 = butter(2,0.01,'high');
%eeg1=reshape(eeg1,128,1);
%eeg2=reshape(eeg2,128,1);
%eeg1 = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',1,3,40,45,40,1,40,128); 

siz = min(length(eeg1),length(eeg2));
nchannels = size(eeg1,2);


    
for j = 1:nchannels
    for k = 1:nchannels
        %adj(j,k,count) = max(xcorr(eeg1(1:SR,j),eeg2(1:SR,k),'coeff'));
        %adj(j,k,1) = abs(corr(eeg1(1:ceil(1),j),eeg2(1:ceil(1),k))); 
        adj(j,k,1) = abs(corr(eeg1(1:ceil(SR),j),eeg2(1:ceil(SR),k)));        
    end
end

end

