function is_a_cell = cell(maybe_a_cell)
% is_a_cell = force.cell(maybe_a_cell)
%
% DESCRIPTION:
%    This function takes an input of some class, and ensures that the
%    output is class CELL. So, if a cell is sent in, then the output will
%    match the input exactly. But, for example, if a string is sent in,
%    then the output is a single cell, whose contents are that string.
%
% INPUTS:
%    maybe_a_cell (???) - variable of any class
%
% OUTPUTS:
%    is_a_cell (1x1 CELL) - a cell array whose contents are the input
%       'maybe_a_cell', but of class cell

%% Input Validation

assert(nargin==1, 'This function requires exactly one input.')
assert(nargout<=1, 'This function does not return more than one output.')

%%

if iscell(maybe_a_cell)
    % If it's already a cell, then just pass it right through
    is_a_cell = maybe_a_cell;
else
    % If it's not a cell yet, then make it one
    is_a_cell = {maybe_a_cell};
end

end