# Early-Response-Index-ERI-

%%%%%%%% Early Response Index: A Statistic to Discover Potential Early Stage Disease Biomarkers  %%%%%%%%

This code implements the Early Response Index algorithm. The algorithm discovers potential biomarkers during early stage of disease.

To run the code, open main.m in Matlab, load your gene/protein expression dataset as F x N matrix where F and N corresponds to number of features and number of samples respectively. Assign loaded dataset to the variable named 'Data' and also provide the number of samples in each class.

EAE protein expression dataset between day 0 and 5 is provided here for test run (Data05.mat). More dataset can be downloaded following the link provided in manuscript. 

The algorithm requires Parallel Computing Toolbox to run efficiently. It takes around 20 minutes to process a data with 40 samples in 8 core computer. Users can decrease the value of 'number_iterations' and 'number_shuffle' variable in main.m to reduce running time at the expense of robustness.
 
See main manuscript for any issues or drop your questions at email provided below.

Contact: < sirajul.salekin@utsa.edu >	< salekin_eee@yahoo.com >	< michelle.zhang@utsa.edu >
