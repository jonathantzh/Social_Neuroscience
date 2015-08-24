a = EmotivEEG;
a.Run;
fid=fopen('eeg_data_01.txt','at');

while(1)
    data = a.data;
    data = data(:,4:17);
    
    fprintf(fid,'%.4f',data(:));
    fprintf(fid,'\n');
    pause(2);
end

fclose(fid);