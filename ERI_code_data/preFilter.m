function [ Data ] = preFilter( Data,size_class1,size_class2 )
% Summary: This function works to reduce feature size before applying ERI
% algorithm because estimating pairwise accuracy of all combinations 
% for a large number of features is not practical. The method uses a
% repetitive t-test scheme as described in [1]
% 
% [1] Bari, M.G., Salekin, S. and Zhang, J.M., 2016. A Robust and Efficient 
% Feature Selection Algorithm for Microarray Data. Molecular Informatics.
% 
% Written by: Sirajul Salekin 
% Contact at:  <sirajul.salekin@utsa.edu> and <salekin_eee@yahoo.com>
% The CopyRight is reserved by the author.
% Last modification: Dec 30, 2016

    number_feature = size(Data.samples,1);
    
    if number_feature > 400  
        
        display('Too many features to calculate pairwise accuracy. Applying t-test to reduce feature size. See manuscript for details.')
    
        num = 500; geneDistribution = cell(1,num); 
        c11 = round(0.6*size_class1); c22 = round(0.6*size_class2);

        class1 = Data.samples(:,1:size_class1); 
        class2 = Data.samples(:,size_class1+1:size_class1+size_class2);

        [rank, firstCutGeneIndx ] = rankByTscore(class1, class2, 3, 1:number_feature);
        noOfReqGenes = zeros(1,num);

        parfor j = 1:num
            randomIdTraining1 = sort(randsample(size_class1, c11, 'false')); 
            randomIdTraining2 = sort(randsample(size_class2, c22, 'false')); 
            randClass1 = class1(firstCutGeneIndx,randomIdTraining1);
            randClass2 = class2(firstCutGeneIndx,randomIdTraining2);

            [rank, topRankGeneIndx ] = rankByTscore(randClass1, randClass2, 4, firstCutGeneIndx);           
            noOfReqGenes(j) = numel(topRankGeneIndx);
            geneDistribution{1,j} = topRankGeneIndx;
            geneDistribution{1,j}(1:noOfReqGenes(j),2) = 1:noOfReqGenes(j);
        end

        selGenes = cell(1);

        for k = 1:num       
            noOfTotalGenes = numel(selGenes{1})/2;
            selGenes{1}(noOfTotalGenes+1:noOfTotalGenes+noOfReqGenes(k),1:2) = geneDistribution{k}(:,1:2);
        end

        selctectedGenes = rankByFreq( selGenes, num );
        Data.selectedGenes = selctectedGenes{1}(:);
        
    else
        Data.selectedGenes = (1:number_feature)';       
    end

end

