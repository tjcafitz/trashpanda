function vnorm = vector_norm(vector_data, col_row)
% vnorm = vector_norm(vector_data, col_row)
%
% DESCRIPTION:
%    This function takes a two dimensional array of data, and returns a one
%    dimensional array of norms. The first input is the two dimensional
%    array, and the second input (if provided) spececifies which dimension
%    to take the norm of. If not specified, the shorted dimension is
%    'norm'ed.
%
% INPUTS:
%    vector_data (MxN DOUBLE) - two dimensional array of raw data
%    col_row (STRING) - flag to set the 'norm'ed dimension of the data to
%       either the columns (via 'col') or the rows (via 'row')
%
% OUTPUTS:
%    vnorm (Mx1 or 1xN DOUBLE) - norms of all columns or all rows of the
%       raw data, depending on the col_row flag

%% Input Validation
assert(nargin==1||nargin==2, 'This function requires exactly one or two inputs.')
assert(nargout<=1, 'This function does not return more than one output.')

assert(isnumeric(vector_data), 'The input ''vector_data'' must be numeric.')
assert(ismatrix(vector_data), 'The input ''vector_data'' must be two-dimensional.')

if nargin == 1
    [n_rows, n_cols] = size(vector_data);
    if n_cols < n_rows
        col_row = 'row';
    elseif n_cols > n_rows
        col_row = 'col';
    else
        error('The input ''col_row'' was not specified, but the ''vector_data'' is square so dimensions cannot be chosen.')
    end
end

assert(ischar(col_row), 'The input ''col_row'' must be class CHAR.')
switch lower(col_row)
    case {'col' 'column' 'c'}
        col_row = 'col';
    case {'row' 'rows' 'r'}
        col_row = 'row';
    otherwise
        error('The input ''col_row'' must be either ''col'' or ''row''.')
end

%%

[ m , n ] = size(vector_data);

switch col_row
    case 'col'
        vnorm = zeros(1, n);
        for i = 1:n
            vnorm(i) = norm(vector_data(:,i));
        end
    case 'row'
        vnorm = zeros(m, 1);
        for i = 1:m
            vnorm(i) = norm(vector_data(i,:));
        end
end

end