% pca.m
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

function [PC,V] = pca(kernel)
    %PCA: compute principle components and eigenvalues for a kernel
    [PC,V] = eig(kernel);
    %sort eigenvalues (descending)
    [V, VIndex] = sort(diag(V),'descend');
    %sort principle components according to the highest eigenvalues
    PC = PC(:,VIndex);
end

