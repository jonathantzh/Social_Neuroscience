close all;
clear all;
clc;

fid1 = fopen('Z:\eeg_data_01.txt','rt');
thres = 0.1;

a = EmotivEEG;
a.Run;

while(1)
    z1=fscanf(fid1,'%f');
    if(length(z1)>1791)
        d1 = z1(end-1791:end);
        eeg1=reshape(d1,128,14);
    end
    
	eeg2 = a.data;
	eeg2 = eeg2(:,4:17);
    
    connectivity = compcorr(eeg1,eeg2);
	set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
    cla;
    brain_plot(connectivity(:,:),thres);
    drawnow;
end

fclose(fid1);
