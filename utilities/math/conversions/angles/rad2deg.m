function deg = rad2deg(rad)
% deg = rad2deg(rad)
%
% DESCRIPTION:
%    This function converts an angle from radians to degrees. It can be
%    used by providing an input, or it can be used by treating the function
%    as a variable itself.
%
% INPUTS:
%    rad (1,1 DOUBLE) - angle in radians
%
% OUTPUTS:
%    deg (1,1 DOUBLE) - angle in degrees

%% Input Validation

switch nargin
    case 0
        rad = 1;
    case 1
        assert(isnumeric(rad), 'The input ''rad'' must be numeric.')
        assert(any(size(rad)==1), 'The input ''rad'' must be 1-dimensional.')
    otherwise
        error('This function accepts 0 or 1 inputs.')
end

assert(nargout<=1, 'This function returns 0 or 1 outputs.')

%%

deg = rad * 180/pi;

end
