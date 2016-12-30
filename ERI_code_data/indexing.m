function [ Data ] = indexing(Data,fold_size1,fold_size2,size_class1,size_class2)
% Summary: This function creates indexes for parsing the dataset into 
% 5-folds for cross validation scheme.
%
% Written by: Sirajul Salekin 
% Contact at:  <sirajul.salekin@utsa.edu> and <salekin_eee@yahoo.com>
% The CopyRight is reserved by the author.
% Last modification: Dec 30, 2016

    for ii = 1:5
        Data.test_indx{1,ii} = (ii-1)*fold_size1+1:ii*fold_size1; 
        Data.test_indx{2,ii} = (ii-1)*fold_size2+1:ii*fold_size2;  
        Data.train_indx{1,ii} = setdiff(1:size_class1, Data.test_indx{1,ii});  
        Data.train_indx{2,ii} = setdiff(1:size_class2, Data.test_indx{2,ii});   
    end

end

