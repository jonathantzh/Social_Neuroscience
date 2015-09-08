function extractedData = extractData (fileName)

load(fileName, 'recordData')
%extracting desired data channels

testData = recordData;
fullextractedData = testData(:,4:17);
fullextractedData(:, 2) = [];
fullextractedData(:, 3) = [];
fullextractedData(:, 5) = [];
fullextractedData(:, 5) = [];
fullextractedData(:, 7) = [];
fullextractedData(:, 8) = [];

meanData = mean(fullextractedData);
referencedData = bsxfun(@minus,fullextractedData,meanData);
normalisedData =  referencedData/norm(referencedData); %very small normalised values


extractedData = normalisedData;