function [r_p, r_a] = radii(a, e)
% [r_p, r_a] = orbit.radii(a, e)
%
% DESCRIPTION:
%    Function that calculates the radius of periapse and the radius of
%    apoapse for an orbital body.
%          r_p = a*(1-e)
%          r_a = a*(1+e)
%
% INPUTS:
%    a (1x1 NUM) - [km] semimajor axis
%    e (1x1 NUM) - [ ] eccentricity
%
% OUTPUTS:
%    r_p (1x1 NUM) - [km] radius of periapse
%    r_a (1x1 NUM) - [km] radius of apoapse
%
% REFERENCE:
%    "Orbital Mechanics for Engineering Students" 2e - Curtis

%% Input Validation

assert(nargin==2, 'This function requires exactly two inputs.')
assert(nargout<=2, 'This function does not return more than two outputs.')

assert(all(size(a)==[1,1]), 'The size of the input ''a'' must be (1x1).')
assert(all(size(e)==[1,1]), 'The size of the input ''e'' must be (1x1).')

assert(isnumeric(a), 'The input ''a'' must be numeric.')
assert(isnumeric(e), 'The input ''e'' must be numeric.')

%%

r_p = a*(1-e);
r_a = a*(1+e);

end