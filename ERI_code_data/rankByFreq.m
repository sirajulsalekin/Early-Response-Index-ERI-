function [ preFilter ] = rankByFreq( selGenes, num )
% Summary: This function is part of repetitive t-test scheme as mentioned
% in preFilter.m
%
% Written by: Sirajul Salekin 
% Contact at:  <sirajul.salekin@utsa.edu> and <salekin_eee@yahoo.com>
% The CopyRight is reserved by the author.
% Last modification: Dec 30, 2016

    preFilter = cell(1);
    [b, ~, locationInd] = unique(selGenes{1}(:,1));
    for j = 1:length(b)
        b(j,2) = sum(selGenes{1}(find(selGenes{1}(:,1)==b(j)),2)); 
        b(j,3) = sum(selGenes{1}(:,1)==b(j));
        b(j,4) = ((num-b(j,3))*length(b)+b(j,2))/500;
    end
    sort_b = sortrows(b,4); 
    preFilter{1} = sort_b(:,1);

end