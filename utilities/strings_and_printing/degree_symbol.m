function ds = degree_symbol
% ds = degree_symbol
%
% DESCRIPTION:
%    This function returns the degree symbol character. The degree symbol
%    char(176).
%
% INPUTS:
%    none
%
% OUTPUTS:
%    ds (STRING) - degree symbol character, '°'
%
% EXAMPLE:
%    >> degree_symbol

%% Input Validation
assert( nargin==0, 'This function does not take any inputs.')
assert( nargout==0||nargout==1, 'This function returns either 0 or 1 outputs.' )

%%
ds = char(176) ;

end