function is_a_column = column(maybe_a_column)
% is_a_column = force.column(maybe_a_column)
%
% DESCRIPTION:
%    This function takes an input of some dimension, and ensures that the
%    output's dimension is a "column". That is to say, in:
%       [m, n] = size(is_a_column)
%    'n' will be less than 'm', regardless of whether or not that is true
%    for the input. There will be more rows than columns, so that the
%    overall shape of the array is a column. A square array will be 
%    returned unaltered.
%    The input must be only two dimensional.
%
% INPUTS:
%    maybe_a_column (???) - variable of any two dimensional size
%
% OUTPUTS:
%    is_a_column (MxN ???) - the same data from the input, but in a column
%       dimension

%% Input Validation

assert(nargin==1, 'This function requires exactly one input.')
assert(nargout<=1, 'This function does not return more than one output.')

% Check size
check = size(maybe_a_column);
assert(length(check)==2, 'The input ''maybe_a_column'' must only be 2D.')

%%

% Pull the original size
[m, n] = size(maybe_a_column);

if n <= m
    % If there are more rows than columns, or it's a square, then just pass
    % it through
    is_a_column = maybe_a_column;
else
    % If there are more columns than rows, then rotate it
    is_a_column = maybe_a_column';
end

end