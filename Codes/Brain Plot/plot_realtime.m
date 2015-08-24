fid1 = fopen('text1.txt','rt');
fid2 = fopen('text2.txt','rt');
thres = 0.4;

while(1)
    tstart = tic;
    z1=fscanf(fid1,'%f');
    if(length(z1)>1791)
        d1 = z1(end-1791:end);
        eeg1=reshape(d1,128,14);
    end
    
    z2=fscanf(fid2,'%f');
    if(length(z2)>1791)
        d2 = z2(end-1791:end);
        eeg2=reshape(d2,128,14);
    end
    
    connectivity = rtcompcorr(eeg1,eeg2);
    %ibd = interbrainr1(connectivity, thres);
    cla;
    brain_plot(connectivity(:,:),thres);
    telapsed = toc(tstart);
    k= abs(1-telapsed);
    pause(k)
    
end

fclose(fid1);
fclose(fid2);

    