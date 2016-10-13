% optimize_scones.m
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

function [ indicator, obj ] = optimize_scones( c, W, lambda )
% optimize_scones: return the indicator vector that minimizes the
% objective as well as the objective itself
%   Based on min-cut
%   c = vector of size nx1 -- not all entries have the same sign
%   W = adjacency matrix of size nxn, in sparse format
%   lambda = optimization parameter

sizew = size(W);
n = sizew(1);

%%% main graph
A = lambda * W;

%%% source and sink
cPosIndices = find(c > 0);
cNegIndices = setdiff(1:n, cPosIndices);

%if isempty(cPosIndices) || isempty(cNegIndices)
%    disp 'Warning: trivial solution ahead!'
%end

T = sparse(n, 2);
% connect positive c values to sink
T(cPosIndices, 2) = c(cPosIndices, 1);
% connect negative c values to source
T(cNegIndices, 1) = -c(cNegIndices, 1);

%%% compute solution
[tmp, indicator] = maxflow(A, T);

obj = sum(c(indicator==0, 1)) + sum(sum(A(indicator==1, indicator==0))) - sum(c);

end

