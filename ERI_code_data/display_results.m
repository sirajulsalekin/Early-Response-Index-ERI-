function [ number_sigFeatures ] = display_results( Data,ERI_Score,cutoff_ERI  )
% Summary: This function finds significant features based on the estimated 
% cutoff threshold and simply displays the results of ERI algorithm.
%
% Written by: Sirajul Salekin 
% Contact at:  <sirajul.salekin@utsa.edu> and <salekin_eee@yahoo.com>
% The CopyRight is reserved by the author.
% Last modification: Dec 30, 2016


    number_sigFeatures = sum((ERI_Score(:,2)>cutoff_ERI));
    sigFeatures = [Data.selectedGenes(ERI_Score(1:number_sigFeatures,1)) ERI_Score(1:number_sigFeatures,2)];

    display('<<<<< Significant features detection by ERI method >>>>>')
    display('* ERI cutoff threshold estimated to be::')
    display(num2str(cutoff_ERI))

    if number_sigFeatures > 0
        display('* Total number of significant features::')
        display(num2str(number_sigFeatures))
        display('* List of significant features::')
        display('Features   ERI Score')
        display(num2str(sigFeatures))
        display('* * * Note: Feature numbers correspond to row number in input dataset * * *')
    else
        display('* * * No significant feature is detected in this datatset * * *')
    end


end

