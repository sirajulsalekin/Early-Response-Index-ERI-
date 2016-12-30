function [ cutoff_ERI, shuffle_ERI ] = cutoff_threshold( Data, size_class1, size_class2, number_shuffle, number_iterations )
% Summary: This function calculates cutoff threshold of ERI score to ensure
% 0% False Positive Rate (FPR). The method randomly mixes all samples and
% estimates ERI score. The procedure is repeated 10 times and the  maximum 
% ERI score calculated out of 10 run is selected as ERI cutoff threshold.  
%
% Written by: Sirajul Salekin 
% Contact at:  <sirajul.salekin@utsa.edu> and <salekin_eee@yahoo.com>
% The CopyRight is reserved by the author.
% Last modification: Dec 30, 2016

    display('Estimating cutoff threshold. Sit back and relax. This will take some time depending on the number of samples.')
    display('The code will run 10 times, randomly permuting each time . . . . .')
    display('See (ERI cutoff threshold estimation based on FPR) in manuscript for detail.')

    for kk = 1:number_iterations
        display(num2str(kk),'<<<<<<<<<<<<<<<<<<<< Starting Run >>>>>>>>>>>>>>>>>>>>>>')        
         
        rng(kk*6); rand_indx = randsample(size_class1+size_class2,size_class1+size_class2);
      
        Data.samples = Data.samples(:,rand_indx);

        [ind_acc,trainSample,testSample] = ind_Accuracy( Data,number_shuffle,size_class1,size_class2 );

        [ comb_acc,num_selFeature ] = pair_Accuracy( Data,ind_acc,trainSample,testSample,number_shuffle );

        ERI_Score = ERI( comb_acc, ind_acc, num_selFeature );
        
        shuffle_ERI(kk) = max(ERI_Score(:,2)); 
    end
    cutoff_ERI = max(shuffle_ERI);
    
end

