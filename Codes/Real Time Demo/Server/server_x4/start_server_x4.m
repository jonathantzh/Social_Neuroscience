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
	
	z11 = Band_pass_filter(eeg1,0.5,4,128);
	z12 = Band_pass_filter(eeg1,4,8,128);
	z13 = Band_pass_filter(eeg1,8,12,128);
	z14 = Band_pass_filter(eeg1,12,30,128);
	z21 = Band_pass_filter(eeg2,0.5,4,128);
	z22 = Band_pass_filter(eeg2,4,8,128);
	z23 = Band_pass_filter(eeg2,8,12,128);
	z24 = Band_pass_filter(eeg2,12,30,128);
    
    connectivity1 = compcorr(z11,z21);
    connectivity2 = compcorr(z12,z22);
    connectivity3 = compcorr(z13,z23);
    connectivity4 = compcorr(z14,z24);

	set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
    cla;
    brain_plot_four(connectivity1(:,:),connectivity2(:,:),connectivity3(:,:),connectivity4(:,:),thres);
    drawnow;
end

fclose(fid1);
