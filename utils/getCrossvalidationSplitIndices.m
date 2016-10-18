% getCrossvalidationSplitIndices.m
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

function [ training_indices, test_indices] = getCrossvalidationSplitIndices(number_samples,folds,seed)
%GETSPLITINDICES 
    rand('seed',seed);
    split_indices = randperm(number_samples)';
   
    number_samples = floor(size(split_indices,1)/folds);
    
    
    training_indices = {};
    test_indices = {};
   
    for i=1:folds
        if i~=folds
            te_indices = split_indices((i-1)*number_samples+1:(i-1)*number_samples+number_samples);
            ta_indices = setdiff(split_indices, te_indices);
        else
            te_indices = split_indices((i-1)*number_samples+1:end);
            ta_indices = setdiff(split_indices, te_indices);
        end
        training_indices{i} = ta_indices;
        test_indices{i} = te_indices;
        %te_indices = split_indices(floor(size(split_indices,1)*split_probability)+1:end);
    end
    
end
