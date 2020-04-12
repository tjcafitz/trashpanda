function lte_1_cell = de_cell(gte_1_cell)
% lte_1_cell = de_cell(gte_1_cell)
%
% DESCRIPTION:
%    This function take an input that is at least one cell "deep", and
%    returns the inner-most contents of that cell. Useful for things like
%    the regexp() call with 'tokens', which returns a multiple cell deep
%    answer.
%
% INPUTS:
%    gte_1_cell (1x1 CELL) - cell with contents of some sort
%
% OUTPUTS:
%    lte_1_cell (?x? ?) - innermost contents of the cell

%% Input Validation

assert(nargin==1, 'This function requires exactly one input.')
assert(nargout<=1, 'This function does not return more than one output.')

%%

% Initialize
lte_1_cell = gte_1_cell;

% Strip out the contents
while length(lte_1_cell)==1 && isa(lte_1_cell,'cell')
    lte_1_cell = lte_1_cell{1};
end

end