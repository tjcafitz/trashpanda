function [R, V] = position_and_velocity(h, mu, e, theta, raan, i, arg_per)
% [R, V] = orbit.position_and_velocity(h, mu, e, theta, raan, i, arg_per)
%
% DESCRIPTION:
%    Function that calculates the position and velocity of an object in an
%    elliptical orbit, given the requisite orbital elements.
%
% INPUTS:
%    h (1x1 NUM) - [km^2/s] magnitude of angular momentum
%    mu (1x1 NUM) - [km^3/s^2] gravitational constant of body that object
%       is orbitting
%    e (1x1 NUM) - [ ] eccentricity
%    theta (1x1 NUM) - [deg] true anomaly
%    raan (1x1 NUM) - [deg] right ascension of the ascending node
%    i (1x1 NUM) - [deg] inclination
%    arg_per (1x1 NUM) - [deg] argument of perigee
%
% OUTPUTS:
%    R (1x3 NUM) - [km] position vector
%    V (1x3 NUM) - [km/s] velocity vector
%
% REFERENCE:
%    "Orbital Mechanics for Engineering Students" 2e - Curtis

%% Input Validation

assert(nargin==7, 'This function requires exactly seven inputs.')
assert(nargout<=2, 'This function does not return more than two outputs.')

assert(all(size(h)==[1,1]), 'The size of the input ''h'' must be (1x1).')
assert(all(size(mu)==[1,1]), 'The size of the input ''mu'' must be (1x1).')
assert(all(size(e)==[1,1]), 'The size of the input ''e'' must be (1x1).')
assert(all(size(theta)==[1,1]), 'The size of the input ''theta'' must be (1x1).')
assert(all(size(raan)==[1,1]), 'The size of the input ''raan'' must be (1x1).')
assert(all(size(i)==[1,1]), 'The size of the input ''i'' must be (1x1).')
assert(all(size(arg_per)==[1,1]), 'The size of the input ''arg_per'' must be (1x1).')

assert(isnumeric(h), 'The input ''h'' must be numeric.')
assert(isnumeric(mu), 'The input ''mu'' must be numeric.')
assert(isnumeric(e), 'The input ''e'' must be numeric.')
assert(isnumeric(theta), 'The input ''theta'' must be numeric.')
assert(isnumeric(raan), 'The input ''raan'' must be numeric.')
assert(isnumeric(i), 'The input ''i'' must be numeric.')
assert(isnumeric(arg_per), 'The input ''arg_per'' must be numeric.')

%%

% Calcualate the position and velocity in the perifocal frame
R_peri = (h^2/mu)/(1+e*cosd(theta)).*[cosd(theta), sind(theta), 0];
V_peri = (mu/h)*[-sind(theta), e+cosd(theta), 0];

% Calculate the transformation matrix to translate into the actual orbital
% frame
Q(1,1) = -sind(raan)*cosd(i)*sind(arg_per) + cosd(raan)*cosd(arg_per);
Q(1,2) =  cosd(raan)*cosd(i)*sind(arg_per) + sind(raan)*cosd(arg_per);
Q(1,3) =             sind(i)*sind(arg_per);
Q(2,1) = -sind(raan)*cosd(i)*cosd(arg_per) - cosd(raan)*sind(arg_per);
Q(2,2) =  cosd(raan)*cosd(i)*cosd(arg_per) - sind(raan)*sind(arg_per);
Q(2,3) =             sind(i)*cosd(arg_per);
Q(3,1) =  sind(raan)*sind(i);
Q(3,2) = -cosd(raan)*sind(i);
Q(3,3) =             cosd(i);

Q = transpose(Q);

% Apply the transformation
R = Q*R_peri';
V = Q*V_peri';

R = R';
V = V';

end