function rad = deg2rad(deg)
% rad = deg2rad(deg)
%
% DESCRIPTION:
%    This function converts an angle from degrees to radians. It can be
%    used by providing an input, or it can be used by treating the function
%    as a variable itself.
%
% INPUTS:
%    deg (1,1 DOUBLE) - angle in degrees
%
% OUTPUTS:
%    rad (1,1 DOUBLE) - angle in radians

%% Input Validation

switch nargin
    case 0
        deg = 1;
    case 1
        assert(isnumeric(deg), 'The input ''deg'' must be numeric.')
        assert(any(size(deg)==1), 'The input ''deg'' must be 1-dimensional.')
    otherwise
        error('This function accepts 0 or 1 inputs.')
end

assert(nargout<=1, 'This function returns 0 or 1 outputs.')

%%

rad = deg * pi/180;

end