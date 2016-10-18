% scones_crossvalidation.m
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

function [indicators,objectives] = scones_crossvalidation(data,options)

    switch nargin
        case 0
            error('No data provided. Please specify data');
        case 1
            %check data
            data = check_data(data);
            %init default options
            options = set_default_options();
        case 2
            %check data and options
            data = check_data(data);
    end

    %set timer
    time = cputime;
    
    if data.selected_PCs~=0
        if options.stdout
            fprintf('[Running] Performing principle component analysis:\n');
            fprintf('          -> Computing kinship matrix\n');
        end
        kernel = linearKernel(data.X);
        if options.stdout
            fprintf('          -> Computing principle components\n');
        end
        [PCs,V] = pca(kernel);
        P = PCs(:,1:data.selected_PCs);
        if options.stdout
            fprintf('[DONE]\n\n');
            fprintf('[Running] Computing residuals\n');
        end
        r = residual(data.Y,P);
        if options.stdout
            fprintf('[DONE]\n\n')
        end
    else
        if options.stdout
            fprintf('[INFO]    No principle components selected!\n\n');
            fprintf('[Running] Computing residuals\n');
        end
        P = zeros(size(data.X,1),1);
        r = data.Y - mean(data.Y);
        if options.stdout
            fprintf('[DONE]\n\n');
        end
    end
    
    if options.automatic==true
        if options.stdout
            fprintf('[Running] Computing c\n');
        end
        c = compute_c(data.X,r);
        if options.stdout
            fprintf('[DONE]\n\n');
        end
        if options.stdout
            fprintf('[Running] Determining range of lambda and eta values\n');
        end
        min_c = min(c(c~=0));
        max_c = max(c);
        min_cl = log10(min_c);
        max_cl = log10(max_c);

        max_cl = ceil(max_cl);
        min_cl = floor(min_cl);

        steps_c = abs(min_cl-max_cl)/options.number_parameters;

        eta_values = min_cl:steps_c:max_cl;
        eta_values = 10.^eta_values;
        eta_values = eta_values(2:end);
        %set values
        data.eta_values = eta_values;
        data.lambda_values = eta_values;
        if options.stdout
            fprintf('[DONE]\n\n');
        end
    end
    
    if options.stdout
        fprintf('[Running] Computing crossvalidation split indices');
    end
        [tr_sets,te_sets] = getCrossvalidationSplitIndices(size(data.X,1),options.nfold,options.seed);
    if options.stdout
        fprintf('[DONE]\n\n');
    end
    
    %Run scones
    if options.stdout
        fprintf('[Running] Running SConES ');
    end
    
    
    indicators = cell(options.nfold,1);
    objectives = cell(options.nfold,1);
    for i=1:options.nfold
        %get split indices
        tr = tr_sets{i};
        %Split data sets
        X_tr = data.X(tr,:);
        Y_tr = data.Y(tr,:);
        P_tr = P(tr,:);
       
        if data.selected_PCs~=0
            if options.stdout
                fprintf('[Running] Computing residuals for fold %d\n',i);
            end
            %compute residuals
            r = residual(Y_tr,P_tr);
            if options.stdout
                fprintf('[DONE]\n\n');
            end
        else
            if options.stdout
                fprintf('[INFO]    No principle components selected!\n\n');
                fprintf('[Running] Computing residuals for fold %d\n',i);
            end
            r = Y_tr - mean(Y_tr);
            if options.stdout
                fprintf('[DONE]\n\n');
            end
        end 
        
        if options.stdout
            fprintf('[Running] Computing c for fold %d\n',i);
        end
        %compute c on the whole set
        c = compute_c(X_tr,r);
        if options.stdout
            fprintf('[DONE]\n\n');
        end
    
        [ind,obj] = gridsearch(c,data.W,data.lambda_values,data.eta_values,options.stdout);
        indicators{i} = ind;
        objectives{i} = obj;
    end
     
    runtime = cputime-time;
    if options.stdout
        fprintf('[DONE: CPU-TIME: %f]\n\n',runtime);
    end

end


