clear all

%% retrieve files from directory
file1 = getFiles(3);
file2 = getFiles(4);

%% extracted desired channels
data1 = extractData(file1);
data2 = extractData(file2);

%% normalisation, referencing & band-pass filtering

preprocessedData1 = preProcess(data1);
preprocessedData2 = preProcess(data2);

%% plotting

%ploteeg(data1);
%ploteeg(data2);

%% calculating inter-brain synchrony & inter-brain density

synchrony = brainSynchrony(data1, data2);
ibd = brainDensity(synchrony, 0.1); %what is a suitable threshold?

%% test for guassianity


%% computing & plotting p-value


