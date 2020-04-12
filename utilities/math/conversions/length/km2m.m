function m = km2m(km)
% m = km2m(km)
%
% DESCRIPTION:
%    This function converts a length from kilometers to meters.
%    It can be used by providing an input, or it can be used by treating
%    the function as a variable itself.
%
% INPUTS:
%    km (1,1 DOUBLE) - length in kilometers
%
% OUTPUTS:
%    m (1,1 DOUBLE) - length in meters

%% Input Validation
switch nargin
    case 0
        km = 1;
    case 1
        assert(isnumeric(km), 'The input ''km'' must be numeric.')
        assert(all(size(km)==[1,1]), 'The input ''km'' must be size 1x1.')
    otherwise
        error('This function accepts 0 or 1 inputs.')
end

assert(nargout==0||nargout==1, 'This function returns 0 or 1 outputs.')

%%
m = km * 1000;

end