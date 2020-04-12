function [M] = eccentric_anomaly_to_mean_anomaly(E, e)
% [M] = orbit.eccentric_anomaly_to_mean_anomaly(E, e)
%
% DESCRIPTION:
%    Function that calculates the mean anomaly of a body in orbit, given
%    the eccentric anomaly and eccentricity.
%
% INPUTS:
%    E (1x1 NUM) - [deg] eccentric anomaly
%    e (1x1 NUM) - [ ] eccentricity
%
% OUTPUTS:
%    M (1x1 NUM) - [deg] mean anomaly
%
% REFERENCE:
%    "Orbital Mechanics for Engineering Students" 2e - Curtis

%% Input Validation

assert(nargin==2, 'This function requires exactly two inputs.')
assert(nargout<=1, 'This function does not return more than one output.')

assert(all(size(E)==[1,1]), 'The size of the input ''E'' must be (1x1).')
assert(all(size(e)==[1,1]), 'The size of the input ''e'' must be (1x1).')

assert(isnumeric(E), 'The input ''E'' must be numeric.')
assert(isnumeric(e), 'The input ''e'' must be numeric.')

%%

% Convert to radians
E = deg2rad(E);

M = E - e*sin(E);

% Convert back to degrees
M = rad2deg(M);

end