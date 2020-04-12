function [theta, E] = mean_anomaly_to_true_anomaly(M, e)
% [theta] = orbit.mean_anomaly_to_true_anomaly(M, e)
% [theta, E] = orbit.mean_anomaly_to_true_anomaly(M, e)
%
% DESCRIPTION:
%    Function that calculates the true anomaly of a body in orbit, given
%    the mean anomaly and eccentricity.
%          E = orbit.mean_anomaly_to_eccentric_anomaly(M, e)
%          theta = orbit.eccentric_anomaly_to_true_anomaly(E)
%
% INPUTS:
%    M (1x1 NUM) - [deg] mean anomaly
%    e (1x1 NUM) - [ ] eccentricity
%
% OUTPUTS:
%    theta (1x1 NUM) - [km] true anomaly
%    E (1x1 NUM) - [deg] eccentric anomaly
%
% REFERENCE:
%    "Orbital Mechanics for Engineering Students" 2e - Curtis

%% Input Validation

assert(nargin==2, 'This function requires exactly two inputs.')
assert(nargout<=2, 'This function does not return more than two outputs.')

assert(all(size(M)==[1,1]), 'The size of the input ''M'' must be (1x1).')
assert(all(size(e)==[1,1]), 'The size of the input ''e'' must be (1x1).')

assert(isnumeric(M), 'The input ''M'' must be numeric.')
assert(isnumeric(e), 'The input ''e'' must be numeric.')

%%

E = orbit.mean_anomaly_to_eccentric_anomaly(M, e);
theta = orbit.eccentric_anomaly_to_true_anomaly(E, e);

end