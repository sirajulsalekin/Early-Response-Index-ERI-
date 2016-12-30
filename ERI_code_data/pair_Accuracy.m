function [ comb_acc,num_selFeature ] = pair_Accuracy( Data,ind_acc,trainSample,testSample,number_shuffle )
% Summary: This function works similarly to ind_Accuracy.m with the only
% difference that it calculates paired accuracy (2 features at a time)
% instead of individual accuracy of each feature.
%
% Written by: Sirajul Salekin 
% Contact at:  <sirajul.salekin@utsa.edu> and <salekin_eee@yahoo.com>
% The CopyRight is reserved by the author.
% Last modification: Dec 30, 2016

    display('Estimating paired accuracy. . . . .')
    display('See (Estimate classification accuracy of all pairs of features) in manuscript for detail.')
    
    selFeature = find(ind_acc{1,1}(:,2)>=0.55);
    num_selFeature = length(selFeature);
    pair_indx = nchoosek(1:length(selFeature),2);
    number_comb = length(pair_indx);
    comb_CV_acc = zeros(number_comb,5);
    comb_shuffle_acc = zeros(number_comb,number_shuffle);
    number_testSamp = size(testSample{1,1},1);

    for shuffle = 1:number_shuffle
        display(num2str(shuffle),'Starting shuffle number (Total: 5)')

        for crossValid = 1:5

            parfor jj = 1:number_comb
                 SVMStruct = svmtrain(trainSample{shuffle,crossValid}(:,selFeature(pair_indx(jj,:))),Data.trainLabel);
                 class_est1 = svmclassify(SVMStruct,testSample{shuffle,crossValid}(:,selFeature(pair_indx(jj,:))));
                 comb_CV_acc(jj,crossValid) = sum(class_est1 == Data.testLabel)/number_testSamp;
            end
            
        end
        comb_shuffle_acc(:,shuffle) = mean(comb_CV_acc,2);
        
    end

    comb_acc{1}(:,1:2) = selFeature(pair_indx);
    comb_acc{1}(:,3) = mean(comb_shuffle_acc,2);
    display('Estimation of paired accuracy is finished !')
end

