function fileName = getFiles(k)

d=dir('/Users/Jon/Desktop/Social_Neuroscience/recordings/1v1physical');

fileName = d(k).name;
