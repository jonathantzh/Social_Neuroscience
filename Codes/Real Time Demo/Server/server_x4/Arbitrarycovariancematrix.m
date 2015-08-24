function Classification_result = Arbitrarycovariancematrix(Class,test,test_class); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Design of Baye's classifier  for the case of
% 1. Separate Mean
% 2. Arbitrary covaraince matrix
%    (i.e., Covariance matrix = Ci(Arbitrary covariance matrix))
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

C=2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculation of Prior probabilities
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tottraindata = sum(length(Class(1).train)+length(Class(2).train));
for i=1:C,
    prior(i) = length(Class(i).train)/tottraindata;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obtaining ML Estimate of mean and Co-Variance 
% The Covaraince Matrix is calculated considering the data of individual 
% classes
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Mean
for i=1:C,
    meanML(i).train=(mean(Class(i).train))';
end;

%Covariance matrices and inverses
for i=1:C,
    variance(i).train = cov(Class(i).train);
    variancei(i).train = inv(variance(i).train);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Training: Plotting of the decision region for the classes by samping the grid 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Finding the weight matrix for each class
for i=1:C,
    W1(i).val = -0.5*variancei(i).train;
    W2(i).val =  variancei(i).train*meanML(i).train;
    bias(i).val = -0.5*meanML(i).train'*variancei(i).train*meanML(i).train ...
                  -0.5*log(det(variance(i).train))+log(prior(i));
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Testing the classifier using discriminant function
%                                                     
% gi(x) = W1'*x*W1+W2*x+bias; where W1=-0.5*inv(Ci); W2=inv(Ci)*mean(i)
%         bias = -0.5*mean(i)'*inv(Ci)*mean(i)-0.5*log(det(Ci))+prior                                
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xinp = test';
for i=1:2
    decisionvalue(i)=xinp'*W1(i).val*xinp+W2(i).val'*xinp+bias(i).val;
end;

% Obataining the true class and the class determined by the
% classifier
[val res]=max(decisionvalue);

%%% Checking the validitiy of the result
if res == test_class
    Classification_result =1;
else
    Classification_result=0;
end;