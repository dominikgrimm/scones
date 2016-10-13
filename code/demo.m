% demo.m
% 
% Author:		Chlo?-Agathe Azencott and Dominik Gerhard Grimm
% Year:         2013
% Group:		Machine Learning and Computational Biology Group (http://webdav.tuebingen.mpg.de/u/karsten/group/)
% Institutes:	Max Planck Institute for Developmental Biology and Max Planck Institute for Intelligent Systems Germany
% 
% This file is part of SConES.
% 
% SConES is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% SConES is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with SConES.  If not, see <http://www.gnu.org/licenses/>.

function demo()

    %init
    startup();

    %set options:
    options.automatic = true;       %if true, lambda and eta are automatically determined
    options.number_parameters = 10; %number of lambda and eta values (only if automatic==true)
    options.stdout = true;          %print informations

    %set data -- for this demo simulate some random data
    fprintf('[Loading] Load simulated demo data:\n');
    
    data.X = load('data/X.csv');
    data.Y = load('data/Y.csv');
    data.W = spconvert(load('data/W.txt')); %sparse matrix format
    data.selected_PCs=2;
    %data.lambda_values = [...] %TO SET if options.automatic==false
    %data.eta_values = [...] %TO SET if options.automatic==false
    
    
    fprintf('[DONE]\n\n');
    
    fprintf('----------------------------------------------------\n');
    fprintf('Running scones for a vector of lambda and eta values\n');
    fprintf('----------------------------------------------------\n\n');

    fprintf('Press any key to continue\n');
    pause;
    
    [indicators,objectives] = scones(data,options);
    
    fprintf('[Saving]  Saving data to out\n');
    if ~exist('out/demo1')
       mkdir('out/demo1');
    end
    save('out/demo1/indicators.mat','indicators');
    save('out/demo1/objectives.mat','objectives');
    fprintf('[DONE]\n\n');
    
    fprintf('----------------------------------------------------\n');
    fprintf('Running scones with a n-fold crossvalidation\n');
    fprintf('----------------------------------------------------\n\n');

    fprintf('Press any key to continue\n');
    pause;
    
    %set options:
    options.nfold=10;
    options.seed=0;
    
    %call scones crossvalidation method
    [indicators,objectives] = scones_crossvalidation(data,options);
    
    fprintf('[Saving]  Saving data for each fold to out\n');
    if ~exist('out/demo2')
       mkdir('out/demo2');
    end
    for i=1:options.nfold
        ind = indicators{i};
        obj = objectives{i};
        save(strcat('out/demo2/fold_',strcat(num2str(i),'_indicators.mat')),'ind');
        save(strcat('out/demo2/fold_',strcat(num2str(i),'_objectives.mat')),'obj');
    end
    fprintf('[DONE]\n\n');
end

