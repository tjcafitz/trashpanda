function [T] = period(mu, a)
% [T] = orbit.period(mu, a)
%
% DESCRIPTION:
%    Function that calculates the period of an elliptical orbit.
%          T = 2*pi/sqrt(mu)*a^(3/2)
%
% INPUTS:
%    mu (1x1 NUM) - [km^3/s^2] gravitational constant of body that object
%       is orbitting
%    a (1x1 NUM) - [km] semimajor axis
%
% OUTPUTS:
%    T (1x1 NUM) - [s] period of orbit
%
% REFERENCE:
%    "Orbital Mechanics for Engineering Students" 2e - Curtis

%% Input Validation

assert(nargin==2, 'This function requires exactly two inputs.')
assert(nargout<=1, 'This function does not return more than one output.')

assert(all(size(mu)==[1,1]), 'The size of the input ''mu'' must be (1x1).')
assert(all(size(a)==[1,1]), 'The size of the input ''a'' must be (1x1).')

assert(isnumeric(mu), 'The input ''mu'' must be numeric.')
assert(isnumeric(a), 'The input ''a'' must be numeric.')

%%

T = 2*pi/sqrt(mu)*a^(3/2);

end