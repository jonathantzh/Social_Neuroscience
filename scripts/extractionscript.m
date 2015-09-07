clear

for k = 1:10 %need to include dirSize, run with steps to acquire xcorr 'r' for single channel i

    for i = 1:8
        
fileName1 = getFiles(2*k+1);
fileName2 = getFiles(2*k+2);

data1 = extractData(fileName1);
data2 = extractData(fileName2);

%applying band-pass filter to delta, theta, alpha, beta, gamma freq band
delta1 = Band_pass_filter(data1,1,4,128);
delta2 = Band_pass_filter(data2,1,4,128);
theta1 = Band_pass_filter(data1,4,8,128);
theta2 = Band_pass_filter(data2,4,8,128);
alpha1 = Band_pass_filter(data1,8,12,128);
alpha2 = Band_pass_filter(data2,8,12,128);
beta1 = Band_pass_filter(data1,15,30,128);
beta2 = Band_pass_filter(data2,15,30,128);
gammaU1 = Band_pass_filter(data1,30,60,128);
gammaU2 = Band_pass_filter(data2,30,60,128);
gamma1 = Notch_filter(gammaU1, 50, 128); %apply Notch filter at 50Hz due to power line noise
gamma2 = Notch_filter(gammaU2, 50, 128);

%extracting single channel data for cross-correlation
singleD1 = delta1(:,i);
singleD2 = delta2(:,i);
singleT1 = theta1(:,i);
singleT2 = theta2(:,i);
singleA1 = alpha1(:,i);
singleA2 = alpha2(:,i);
singleB1 = beta1(:,i);
singleB2 = beta2(:,i);
singleG1 = gamma1(:,i);
singleG2 = gamma2(:,i);

%compute xcorr & extract variables for plotting
[d(:,1),d(:,2)] = xcorr(singleD1-mean(singleD1), singleD2-mean(singleD2),'coeff');
[t(:,1),t(:,2)] = xcorr(singleT1-mean(singleT1), singleT2-mean(singleT2),'coeff');
[a(:,1),a(:,2)] = xcorr(singleA1-mean(singleA1), singleA2-mean(singleA2),'coeff');
[b(:,1),b(:,2)] = xcorr(singleB1-mean(singleB1), singleB2-mean(singleB2),'coeff');
[g(:,1),g(:,2)] = xcorr(singleG1-mean(singleG1), singleG2-mean(singleG2),'coeff');

    end;
end;
