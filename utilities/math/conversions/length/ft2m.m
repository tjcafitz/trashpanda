function m = ft2m(ft)
% m = ft2in(ft)
%
% DESCRIPTION:
%    This function converts a length from feet to meters.
%    It can be used by providing an input, or it can be used by treating
%    the function as a variable itself.
%
% INPUTS:
%    ft (1,1 DOUBLE) - length in feet
%
% OUTPUTS:
%    m (1,1 DOUBLE) - length in meters

%% Input Validation
switch nargin
    case 0
        ft = 1;
    case 1
        assert(isnumeric(ft), 'The input ''ft'' must be numeric.')
        assert(all(size(ft)==[1,1]), 'The input ''ft'' must be size 1x1.')
    otherwise
        error('This function accepts 0 or 1 inputs.')
end

assert(nargout==0||nargout==1, 'This function returns 0 or 1 outputs.')

%%
m = ft / 3.28;

end