function km = mi2km(mi)
% km = mi2km(mi)
%
% DESCRIPTION:
%    This function converts a length from miles to kilometers.
%    It can be used by providing an input, or it can be used by treating
%    the function as a variable itself.
%
% INPUTS:
%    mi (1,1 DOUBLE) - length in miles
%
% OUTPUTS:
%    km (1,1 DOUBLE) - length in kilometers

%% Input Validation
switch nargin
    case 0
        mi = 1;
    case 1
        assert(isnumeric(mi), 'The input ''mi'' must be numeric.')
        assert(all(size(mi)==[1,1]), 'The input ''mi'' must be size 1x1.')
    otherwise
        error('This function accepts 0 or 1 inputs.')
end

assert(nargout==0||nargout==1, 'This function returns 0 or 1 outputs.')

%%
km = mi * 1.60934;

end