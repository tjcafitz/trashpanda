function [varargout] = angular_momentum(varargin)
% [h] = orbit.angular_momentum(r_p, e, mu)
% [H, h] = orbit.angular_momentum(R, V)
%
% DESCRIPTION:
%    Function that calculates the angular momentum of an elliptical orbit.
%    If eccentricity, radius of periapse, and gravitational constant are
%    provided, then only the magnitude is returned.
%    If the position and velocity vectors are provided, then the vector and
%    magnitude are both returned.
%          h = sqrt(r_p*mu*(1+e))
%        <OR>
%          H = cross(R, V)
%          h = norm(H)
%
% INPUTS (magnitude only):
%    r_p (1x1 NUM) - [km] radius of periapse
%    e (1x1 NUM) - [ ] eccentricity
%    mu (1x1 NUM) - [km^3/s^2] gravitational constant of body that object
%       is orbitting
%
% INPUTS (vector and magnitude):
%    R (1x3 NUM) - [km] position vector
%    V (1x3 NUM) - [km/s] velocity vector
%
% OUTPUTS (magnitude only):
%    h (1x1 NUM) - [km^2/s] magnitude of angular momentum
%
% OUTPUTS (vector and magnitude):
%    H (1x3 NUM) - [km^2/s] vector of angular momentum
%    h (1x1 NUM) - [km^2/s] magnitude of angular momentum
%
% REFERENCE:
%    "Orbital Mechanics for Engineering Students" 2e - Curtis

%% Input Validation

switch nargin
    case 2
        vector = true;
        assert(nargout<=2, 'This function does not return more than two outputs (given two inputs).')
    case 3
        vector = false;
        assert(nargout<=1, 'This function does not return more than one output (given three inputs).')
    otherwise
        error('This function requires either two or three inputs.')
end

if vector
    R = force.row(varargin{1});
    V = force.row(varargin{2});
else
    r_p = varargin{1};
    e = varargin{2};
    mu = varargin{3};
end

if vector
    assert(all(size(R)==[1,3]), 'The size of the input ''R'' must be (1x3).')
    assert(all(size(V)==[1,3]), 'The size of the input ''V'' must be (1x3).')
    assert(isnumeric(R), 'The input ''R'' must be numeric.')
    assert(isnumeric(V), 'The input ''V'' must be numeric.')
else
    assert(all(size(r_p)==[1,1]), 'The size of the input ''r_p'' must be (1x1).')
    assert(all(size(e)==[1,1]), 'The size of the input ''e'' must be (1x1).')
    assert(all(size(mu)==[1,1]), 'The size of the input ''mu'' must be (1x1).')
    assert(isnumeric(r_p), 'The input ''e'' must be numeric.')
    assert(isnumeric(e), 'The input ''e'' must be numeric.')
    assert(isnumeric(mu), 'The input ''mu'' must be numeric.')
end

%%

if vector
   H = cross(R, V);
   h = norm(H);
   varargout = {H, h};
   
else
   h = sqrt(r_p*mu*(1+e));
   varargout = {h};
   
end

end