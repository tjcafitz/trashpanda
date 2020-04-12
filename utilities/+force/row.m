function is_a_row = row(maybe_a_row)
% is_a_row = force.row(maybe_a_row)
%
% DESCRIPTION:
%    This function takes an input of some dimension, and ensures that the
%    output's dimension is a "row". That is to say, in:
%       [m, n] = size(is_a_row)
%    'm' will be less than 'n', regardless of whether or not that is true
%    for the input. There will be more columns than rows, so that the
%    overall shape of the array is a row. A square array will be returned
%    unaltered.
%    The input must be only two dimensional.
%
% INPUTS:
%    maybe_a_row (???) - variable of any two dimensional size
%
% OUTPUTS:
%    is_a_row (MxN ???) - the same data from the input, but in a row
%       dimension

%% Input Validation

assert(nargin==1, 'This function requires exactly one input.')
assert(nargout<=1, 'This function does not return more than one output.')

% Check size
check = size(maybe_a_row);
assert(length(check)==2, 'The input ''maybe_a_row'' must only be 2D.')

%%

% Pull the original size
[m, n] = size(maybe_a_row);

if m <= n
    % If there are more columns than rows, or it's a square, then just pass
    % it through
    is_a_row = maybe_a_row;
else
    % If there are more columns than rows, then rotate it
    is_a_row = maybe_a_row';
end

end