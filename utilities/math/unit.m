function v_hat = unit( v )
% v_hat = unit( v )
%
% DESCRIPTION:
%    This function returns the unit vector for a given non-unit vector. If
%    the vector provided is already a unit vector, then that same vector is
%    returned.
%
% INPUTS:
%    v (1xN or Nx1 DOUBLE) - one dimensional vector
%
% OUTPUTS:
%    v_hat (1xN or Nx1 DOUBLE) - one dimensional unit vector
%
% EXAMPLE:
%    >> unit( [1,2,3] )

%% Input Validation
assert( nargin==1, 'This function requires exactly one input.' )
assert( nargout<=1, 'This function does not return more than one output.' )

assert( isnumeric(v), 'The input ''v'' must be numeric.' )
assert( isrow(v)||iscolumn(v), 'The input ''v'' must be a one-dimensional vector.' ) ;

%%

v_norm = norm( v ) ;

v_hat = v./v_norm ;

end