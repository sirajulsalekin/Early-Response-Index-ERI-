function [ ind_acc,trainSample,testSample  ] = ind_Accuracy( Data,number_shuffle,size_class1,size_class2 )
% Summary: This function calculates classification accuracy of each feature
% selected after pre-filtering step. The function uses 5-fold cross
% validation scheme to remove overfitting problem. This function runs
% 5 times each time shuffling samples within the class to remove selection
% bias.
% 
% Written by: Sirajul Salekin 
% Contact at:  <sirajul.salekin@utsa.edu> and <salekin_eee@yahoo.com>
% The CopyRight is reserved by the author.
% Last modification: Dec 30, 2016

    display('Estimating individual accuracy. . . . .')
    
    if length(Data.selectedGenes) > 350
        number_feature = 300;
    else
        number_feature = length(Data.selectedGenes);
    end      
    
    number_sample = size_class1 + size_class2;
    ind_CV_acc = zeros(number_feature,5);
    trainSample = cell(number_shuffle,5); testSample = cell(number_shuffle,5);
    ind_shuffle_acc = zeros(number_feature,number_shuffle);

    for shuffle = 1:number_shuffle
        shuffle_indx1 = randsample(size_class1,size_class1);
        shuffle_indx2 = randsample(size_class1+1:number_sample,size_class2);
        Data.class1{shuffle} = Data.samples(Data.selectedGenes(1:number_feature), shuffle_indx1); %Data.samples(:, shuffle_indx1);
        Data.class2{shuffle} = Data.samples(Data.selectedGenes(1:number_feature), shuffle_indx2); %Data.samples(:, shuffle_indx2);

        for crossValid = 1:5
            train_Sample1 = Data.class1{shuffle}(:,Data.train_indx{1,crossValid});
            train_Sample2 = Data.class2{shuffle}(:,Data.train_indx{2,crossValid});
            test_Sample1 = Data.class1{shuffle}(:,Data.test_indx{1,crossValid});
            test_Sample2 = Data.class2{shuffle}(:,Data.test_indx{2,crossValid});

            trainSample{shuffle,crossValid} = [train_Sample1 train_Sample2]';
            testSample{shuffle,crossValid} = [test_Sample1 test_Sample2]';
            number_testSamp = size(testSample{shuffle,crossValid},1);

            parfor jj = 1:number_feature
                 SVMStruct = svmtrain(trainSample{shuffle,crossValid}(:,jj),Data.trainLabel);
                 class_est1 = svmclassify(SVMStruct,testSample{shuffle,crossValid}(:,jj));
                 ind_CV_acc(jj,crossValid) = sum(class_est1 == Data.testLabel)/number_testSamp;
            end
            
        end
        ind_shuffle_acc(:,shuffle) = mean(ind_CV_acc,2);
    end

    ind_acc{1}(:,1) = 1:number_feature;
    ind_acc{1}(:,2) = mean(ind_shuffle_acc,2); 
    display('Estimation of individual accuracy is finished !')

end

