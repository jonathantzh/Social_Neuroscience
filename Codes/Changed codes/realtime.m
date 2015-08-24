a= EmotivEEG;
a.Run;
fid=fopen('EEGlog-P1AH1C5M2 -20150630T144043','at');

while(1)
    data=a.data;
    data=data(:,3:16);
    
    fprintf(fid,'%.4f',data(:));
    fprintf(fid,'\n');
    pause(2);
end

fclose(fid);

fid1=fopen('EEGlog-P1AH1C5M2 -20150630T144043','rt');
fid2=fopen('EEGlog-P1AH1C5M5 -20150630T145114','rt');
thres = 0.4;

while(1)
    
    tstart=tic;
    z1=fscanf(fid1,'%f');
    if(length(z1)>1791)
        d1=z1(end-1791:end); %14*128=1792
        eeg1=reshape(d1,128,14);
    end
    
    z2=fscanf(fid2,'%f');
    
    if(length(z2)>1791)
        d2=z2(end-1791:end);
        eeg2=reshape(d2,128,14);
    end
    
    connectivity = rtcompcorr(eeg1,eeg2);
    ibd = interbrainrl(connectivity,thres);
    cla;
    brain_plot(connectivity(:,:));
    telapsed = toc(tstart);
    k = abs(1 - telapsed);
    pause(k);
    figure3 = getframe;
    
end

fclose(fid1);
fclose(fid2);