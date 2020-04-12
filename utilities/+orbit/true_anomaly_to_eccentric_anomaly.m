function [E] = true_anomaly_to_eccentric_anomaly(theta, e)
% [E] = orbit.true_anomaly_to_eccentric_anomaly(theta, e)
%
% DESCRIPTION:
%    Function that calculates the eccentric anomaly of a body in orbit,
%    given the theta anomaly and eccentricity.
%
% INPUTS:
%    theta (1x1 NUM) - [km] true anomaly
%    e (1x1 NUM) - [ ] eccentricity
%
% OUTPUTS:
%    E (1x1 NUM) - [deg] eccentric anomaly
%
% REFERENCE:
%    "Orbital Mechanics for Engineering Students" 2e - Curtis

%% Input Validation

assert(nargin==2, 'This function requires exactly two inputs.')
assert(nargout<=1, 'This function does not return more than one output.')

assert(all(size(theta)==[1,1]), 'The size of the input ''theta'' must be (1x1).')
assert(all(size(e)==[1,1]), 'The size of the input ''e'' must be (1x1).')

assert(isnumeric(theta), 'The input ''theta'' must be numeric.')
assert(isnumeric(e), 'The input ''e'' must be numeric.')

%%

%sin_E = (sqrt(1-e^2)*sind(theta))/(1+e*cosd(theta));
%E = asind(sin_E);

tan_E_over_2 = sqrt((1-e)/(1+e))*tand(theta/2);
E = 2*atand(tan_E_over_2);

end