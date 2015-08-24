fid1=fopen('text1.txt','rt');
fid2=fopen('text2.txt','rt');

while(1)
    

	z1=fscanf(fid1,'%f');
	if(length(z1)>1791)      %checking if there is enough data saved in file
    	d1=z1(end-1791:end); %14*128=1792
        eeg1=reshape(d1,128,14);   
    end
 	z2=fscanf(fid2,'%f');
	
	%the same for 2nd file but you can just use data directly from matlab (on computer where is shared folder and where you will be plotting figures)
	
    if(length(z2)>1791)
		d2=z2(end-1791:end); %14*128=1792
		eeg2=reshape(d2,128,14);
    end
        
	connectivity = compcorr(eeg1,eeg2);

	bla bla bla, etc etc
		
     
end

fclose(fid1);
fclose(fid2);
