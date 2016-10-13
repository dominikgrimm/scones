% check_data.m
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

function data = check_data(data)
    try
        data.X;
    catch execption
        error('Data does not contain X');
    end
    try
        data.Y;
    catch execption
        error('Data does not contain Y');
    end
    try
        data.W;
    catch execption
        error('Data does not contain W');
    end
    try
        data.selected_PCs;
    catch %set default value
        data.selected_PCs=0;
    end
    try
        data.lambda_values;
    catch %set default values
        data.lambda_values = [1e-5,1e-4,1e-3,1e-2,1e-1,1,1e1,1e2,1e3,1e4];
    end
    try
        data.eta_values;
    catch %set default values
        data.eta_values = [1e-5,1e-4,1e-3,1e-2,1e-1,1,1e1,1e2,1e3,1e4];
    end
    %check data format
    if size(size(data.X),2)~=2
        error('X has the wrong format (samples x features/SNPs matrix -- s x n)');
    end
    if size(data.Y,2)~=1;
        error('Y has the wrong format (samples x 1 -- s x 1)');
    end
    if size(data.Y,1)~=size(data.X,1)
        error('X and Y have different number of samples');
    end
    if size(data.W,1)~=size(data.X,2) && size(data.W,2)~=size(data.X,2)
        error('Unequal number of features/SNPs in W and X');
    end
end

