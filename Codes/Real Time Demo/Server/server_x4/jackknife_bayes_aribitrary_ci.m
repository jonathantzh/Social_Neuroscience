function [Classification_acc,Classification_accuracy_wihtinclass] = jackknife_bayes_aribitrary_ci(Feature_class1,Feature_class2) 

% Function to perform jackknife testing on the input features using Baye's classifier 
% built on arbitrary covariance matrix
%
% Input: 
%       Feature_class1 - Single feature or feature vector of class1     
%       Feature_class2 - Single feature or feature vector of class1
%                        
% Output: 
%       Classification_acc - Classification accuracy in percentage
%       Classification_accuracy_withinclass - Classification accuracy
%                                             within each class
%      

Num_features_class1 = length(Feature_class1);
Num_features_class2 = length(Feature_class2);

Classification_result = zeros([1 Num_features_class1+Num_features_class2]);

n=1;
for j=1:Num_features_class1, 
    test = Feature_class1(j,:); test_class =1; 
    Class_data(2).train = Feature_class2;
    Class_data(1).train = [Feature_class1(1:j-1,:) ; Feature_class1(j+1:end,:)];
    Classification_result(n) = Arbitrarycovariancematrix(Class_data,test,test_class);
    n=n+1;
end

for j=1:Num_features_class2,
    test = Feature_class2(j,:); test_class =2;
    Class_data(1).train = Feature_class1;
    Class_data(2).train = [Feature_class2(1:j-1,:) ; Feature_class2(j+1:end,:)];
    Classification_result(n) = Arbitrarycovariancematrix(Class_data,test,test_class); 
    n=n+1;
end

Classification_acc = mean(Classification_result);
Classification_accuracy_wihtinclass(1) = sum(Classification_result(1:Num_features_class1))/Num_features_class1;
Classification_accuracy_wihtinclass(2) = sum(Classification_result(Num_features_class1+1:end))/Num_features_class2;
