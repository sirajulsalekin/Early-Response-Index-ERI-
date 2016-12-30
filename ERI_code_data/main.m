%% =========================================================

% This is the main code of ERI method. The code requires Parallel Computing
% Toolbox for efficient calculation.

% Written by: Sirajul Salekin.
% Contact at:  <sirajul.salekin@utsa.edu> and <salekin_eee@yahoo.com>
% The CopyRight is reserved by the author.
% Last modification: Dec 30, 2016

% =========================================================
        
%% User Input

% Load Dataset as (F x N) matrix. F and N represents number of features
% and samples respectively. Then specify number of samples in each class.
% Finally, assign the loaded matrix to the structure named 'Data'

clear all
clc

load Data05 % Load your dataset here
size_class1 = 20; size_class2 = 20;
Data = struct('samples',Data05); % change the Dataset name here

number_iterations = 10; % Number of iterations to calculate FPR. Increasing 
% this number outputs more robust cutoff threshold at the expense of more 
% time complexity. default value = 10

number_shuffle = 5; % Number of shuffles to estimate classification accuracy. 
% The shuffling is required to eliminate selection bias. default value = 5

%% ERI algorithm implementation

tic
fold_size1 = floor(size_class1/5); fold_size2 = floor(size_class2/5);
Data.testLabel = [ones(fold_size1,1); 2*ones(fold_size2,1)];
Data.trainLabel = [ones(size_class1-fold_size1,1); 2*ones(size_class2-fold_size2,1)];

% Input data indexing
Data = indexing(Data,fold_size1,fold_size2,size_class1,size_class2);

% Pre-filtering step as described in manuscript. This step is required if 
% number_of_feature >> 300.

Data = preFilter( Data,size_class1,size_class2 );

% Estimating individual accuracy
[ind_acc,trainSample,testSample] = ind_Accuracy( Data,number_shuffle,size_class1,size_class2 );

% Estimating paired accuracy
[ comb_acc,num_selFeature ] = pair_Accuracy( Data,ind_acc,trainSample,testSample,number_shuffle );

% Estimating ERI score
ERI_Score = ERI( comb_acc, ind_acc, num_selFeature );

% Estimating cutoff threshold for 0% FPR
[ cutoff_ERI, shuffle_ERI ] = cutoff_threshold(Data,size_class1,size_class2,number_shuffle, number_iterations);

toc

% display results
display_results( Data,ERI_Score,cutoff_ERI  );


