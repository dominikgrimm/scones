% gridsearch.m
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

function [indicators,objectives] = gridsearch(c,W,lambda_values,eta_values,stdout)
%%%
%gridsearch: compute indicator vector and objective value for each 
%            lambda and eta value
%INPUT: c = vector of size n x 1 -- not all entries have the same sign
%       W = adjacency matrix of size n x n, in sparse format
%       lambda_values = vector of size 1 x k, with k lambda values
%       eta_values = vector of size 1 x h, with h eta values
%       
%OUTPUT: indicators = indicator matrix of size n x k x h, where n is the
%                     length of vector c, k the length of vector
%                     lambda_values and h the length of vector eta_values
%        objectives = matrix with all objective values with size k x h for
%                     the grid of lambda x eta values
%%%
    indicators = zeros(size(c,1),size(lambda_values,1),size(eta_values,1));
    objectives = zeros(size(lambda_values,1),size(eta_values,1));
    
    %gridsearch over lambda and eta_values
    for i=1:size(lambda_values,2)
        for j=1:size(eta_values,2)
            if stdout
                fprintf('.')
            end
            %optimize objective
            c_transformed = c-eta_values(j);
            [f_tr, obj] = optimize_scones(c_transformed,W,lambda_values(i)); 
            %store indicator vector and objective value
            indicators(:,i,j) = f_tr;
            objectives(i,j) = obj;    
        end
    end
    if stdout
        fprintf('\n')
    end
end
