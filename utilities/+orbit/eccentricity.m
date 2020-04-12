function [e] = eccentricity(r_p, r_a)
% [e] = orbit.eccentricity(r_p, r_a)
%
% DESCRIPTION:
%    Function that calculates the eccentricity of an elliptical orbit.
%          e = (r_a-r_p)/(r_a+r_p)
%
% INPUTS:
%    r_p (1x1 NUM) - [km] radius of periapse
%    r_a (1x1 NUM) - [km] radius of apoapse
%
% OUTPUTS:
%    e (1x1 NUM) - [ ] eccentricity
%
% REFERENCE:
%    "Orbital Mechanics for Engineering Students" 2e - Curtis

%% Input Validation

assert(nargin==2, 'This function requires exactly two inputs.')
assert(nargout<=1, 'This function does not return more than one outputs.')

assert(all(size(r_p)==[1,1]), 'The size of the input ''r_p'' must be (1x1).')
assert(all(size(r_a)==[1,1]), 'The size of the input ''r_a'' must be (1x1).')

assert(isnumeric(r_p), 'The input ''r_p'' must be numeric.')
assert(isnumeric(r_a), 'The input ''r_a'' must be numeric.')

%%

e = (r_a-r_p)/(r_a+r_p);

end