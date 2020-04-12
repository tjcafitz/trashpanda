function ft = in2ft(in)
% ft = in2ft(in)
%
% DESCRIPTION:
%    This function converts a length from inches to feet.
%    It can be used by providing an input, or it can be used by treating
%    the function as a variable itself.
%
% INPUTS:
%    in (1,1 DOUBLE) - length in inches
%
% OUTPUTS:
%    ft (1,1 DOUBLE) - length in feet

%% Input Validation
switch nargin
    case 0
        in = 1;
    case 1
        assert(isnumeric(in), 'The input ''in'' must be numeric.')
        assert(all(size(in)==[1,1]), 'The input ''in'' must be size 1x1.')
    otherwise
        error('This function accepts 0 or 1 inputs.')
end

assert(nargout==0||nargout==1, 'This function returns 0 or 1 outputs.')

%%
ft = in / 12;

end