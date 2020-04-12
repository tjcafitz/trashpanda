function km = m2km(m)
% km = m2km(m)
%
% DESCRIPTION:
%    This function converts a length from meters to kilometers.
%    It can be used by providing an input, or it can be used by treating
%    the function as a variable itself.
%
% INPUTS:
%    m (1,1 DOUBLE) - length in meters
%
% OUTPUTS:
%    km (1,1 DOUBLE) - length in kilometers

%% Input Validation

switch nargin
    case 0
        m = 1;
    case 1
        assert(isnumeric(m), 'The input ''m'' must be numeric.')
        assert(all(size(m)==[1,1]), 'The input ''m'' must be size 1x1.')
    otherwise
        error('This function accepts 0 or 1 inputs.')
end

assert(nargout==0||nargout==1, 'This function returns 0 or 1 outputs.')

%%
km = m / 1000;

end