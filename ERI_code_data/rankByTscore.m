function [ rank, topRankGeneIndx ] = rankByTscore( randClass1, randClass2, Pthr, firstCutGeneIndx)
% Summary: This function is part of repetitive t-test scheme as mentioned
% in preFilter.m
%
% Written by: Sirajul Salekin 
% Contact at:  <sirajul.salekin@utsa.edu> and <salekin_eee@yahoo.com>
% The CopyRight is reserved by the author.
% Last modification: Dec 30, 2016
 
[r,c1] = size(randClass1);  
[~,c2] = size(randClass2);  
totalTscore = zeros(r,1);

for i = 1:r
    [~ , pValue] = ttest2(randClass1(i,:),randClass2(i,:));
    totalTscore(i,2) = abs(-log(pValue));
    totalTscore(i,1) = firstCutGeneIndx(i);      
end

rank = flipdim(sortrows(totalTscore,2),1);
topRankGeneIndx = rank(find(rank(:,2)>Pthr),1);
end