

% name of all available result files
availfilenamelist = ... 
{   'original/specimen_11.csv',  %1
    'original/specimen_12.csv',  %2
    'original/specimen_21.csv',
    'original/specimen_22.csv',
    'original/specimen_23.csv',  %5
    'original/specimen_31.csv',
    'original/specimen_32.csv',
    'original/specimen_33.csv',
    'original/specimen_34.csv',
    'original/specimen_41.csv',  %10
    'original/specimen_51.csv',
    'original/specimen_52.csv',
    'original/specimen_53.csv',
    'original/specimen_54.csv'};  %14


% load percentage included in the fitting
start_perc = 0.9;
end_perc = 0.99;

% geometry for all specimen:
L_spe = [7,7,9,9,9,7,7,7,7,7,7,7,7,7];
ds_spe = [0.375,0.375,0.375,0.375,0.375,0.375,0.375,0.375,0.375,0.375,0.5,0.5,0.5,0.5];

% fitting function
funhandle = @modelfun_derived;
%funhandle = @modelfun_infinite;
%funhandle = @modelfun_theory;

% set fit specimens
resfilenamelist = [1:14];%[14];

% initial results
res = zeros(4,length(resfilenamelist));

global L ds;


for i=1:length(resfilenamelist)
    close all;
    ind = resfilenamelist(i);
    disp(strcat('fitting file name:',availfilenamelist{ind}));
    % find settings for individual specimen
    L = L_spe(ind);
    ds = ds_spe(ind);
    
    % do curve fitting
    [beta1,beta2,beta3,beta_total] = batch_solve_function(availfilenamelist{ind},funhandle,start_perc,end_perc);    
    res(:,i) = [beta1,beta2,beta3,beta_total];
    
end



