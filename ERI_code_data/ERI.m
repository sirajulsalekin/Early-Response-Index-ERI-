function [ avgERIMat ] = ERI( comb_acc, ind_acc, maxFeature )
% Summary: This function calculates ERI score according to equation (1) and
% (2) of the main manuscript.
%
% Written by: Sirajul Salekin 
% Contact at:  <sirajul.salekin@utsa.edu> and <salekin_eee@yahoo.com>
% The CopyRight is reserved by the author.
% Last modification: Dec 30, 2016

    synergyMat = cell(1,1); sigFeature = zeros(maxFeature,1); eriRank = cell(1,1);
    [r c] = size(comb_acc{1});

    for i = 1:r
        comb_acc{1}(i,c+1) = ind_acc{1}(find(ind_acc{1}(:,1)==comb_acc{1}(i,1)),2); 
        comb_acc{1}(i,c+2) = ind_acc{1}(find(ind_acc{1}(:,1)==comb_acc{1}(i,2)),2); 
        comb_acc{1}(i,c+3) = comb_acc{1}(i,c)-max(comb_acc{1}(i,c+1),comb_acc{1}(i,c+2)); % ERI formula
    end
     pivotMat = [comb_acc{1}(:,1) comb_acc{1}(:,6); comb_acc{1}(:,2) comb_acc{1}(:,6)];
    [synergyMat{1}, ~, locationInd] = unique(pivotMat(:,1));
    
    for j = 1:length(synergyMat{1})
        synergyMat{1}(j,2) = sum(pivotMat(find(locationInd==j),2)); 
        synergyMat{1}(j,3) = ind_acc{1}(find(ind_acc{1}(:,1)==synergyMat{1}(j,1)),2); 
    end
    
    synergyMat{1}(:,4) = synergyMat{1}(:,2)/j; 
    eriRank{1} = flipdim(sortrows(synergyMat{1},4),1);
    sigFeature(:,1) = eriRank{1}(1:maxFeature,1);  
    avgERIPvotMat((1-1)*j+1:1*j,1:2) = eriRank{1}(:,[1 4]);

    [avgERIMat, ~, locationIndPsi] = unique(avgERIPvotMat(:,1));
    
    for k = 1:length(avgERIMat)
        avgERIMat(k,2) = sum(avgERIPvotMat(find(locationIndPsi==k),2))/sum(locationIndPsi==k); 
    end

    avgERIMat = flipdim(sortrows(avgERIMat,2),1);

end