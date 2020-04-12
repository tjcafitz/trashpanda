function idx = cell_has_str(cell, str)
% idx = cell_has_str(cell, str)
%
% DESCRIPTION:
%    This function walks through a cell matrix, and checks to see if any of
%    the cells contain the string provided. The returned vector is a series
%    of booleans for whether or not each cell has that string.
%
% INPUTS:
%    cell (MxN CELL) - cell array of strings to be searched
%    str (CHAR) - specific, literal string pattern to search for
%
% OUTPUTS:
%    idx (MxN BOOL) - matrix of booleans, same size as the CELL input,
%       corresponding to whether or not each cell contains the desired
%       string

%% Input Validation

assert(nargin==2, 'This function requires exactly 2 inputs.')
assert(nargout<=1, 'This function does not return more than one output.')

% 'char'
assert(iscell(cell), 'The input ''cell'' must be a CELL.')
[m, n] = size(cell);
for i = 1:m
    for j = 1:n
        assert(ischar(cell{m,n}), 'All cells of input ''cell'' must be class CHAR.')
    end
end

% 'str'
assert(ischar(str), 'The input ''str'' must be class CHAR.')

%%

% Initialize outut
idx = false(m,n);

% March through all CELLs and see if they contain the STRING
for i = 1:m
    for j = 1:n
        idx(i,j) = str_has(cell{i,j}, str);
    end
end

end