a= EmotivEEG;
a.Run;
fid=fopen('text1.txt','at');

while(1)
data=a.data;
data=data(:,3:16);

fprintf(fid,'%.4f ',data(:));
fprintf(fid,'\n');
pause(2);

end

delete(fid);  