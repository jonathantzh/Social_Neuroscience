a = EmotivEEG;
a.Run;
fid=fopen('text2.txt','at');

while(1)
    data = a.data;
    data = data(:,4:17);
    
    fprintf(fid,'%.4f',data(:));
    fprintf(fid,'\n');
    pause(5);
end

fclose(fid);