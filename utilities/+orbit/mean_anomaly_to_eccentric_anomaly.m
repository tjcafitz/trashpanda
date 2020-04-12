function [E] = mean_anomaly_to_eccentric_anomaly(M, e)
% [E] = orbit.mean_anomaly_to_true_anomaly(M, e)
%
% DESCRIPTION:
%    Function that calculates the eccentric anomaly of a body in orbit,
%    given the mean anomaly and eccentricity.
%
% INPUTS:
%    M (1x1 NUM) - [deg] mean anomaly
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

assert(all(size(M)==[1,1]), 'The size of the input ''M'' must be (1x1).')
assert(all(size(e)==[1,1]), 'The size of the input ''e'' must be (1x1).')

assert(isnumeric(M), 'The input ''M'' must be numeric.')
assert(isnumeric(e), 'The input ''e'' must be numeric.')

% The mean anomaly must be a valid "un-wrapped" degree measurement
assert(M>=0, 'The input ''M'' must be greater than or equal to zero.')
assert(M<360, 'The input ''M'' must be less than 360.')

%% Corner Cases
% If the mean anomaly is exactly 0 or 180, then it is at periapse or
% apoapse, respectively. That means that the eccentric anomaly is equal to
% the mean anomaly.

if M==0 || M==180
    E = M;
    return
end

%%

% The algorithm requires the angles be in radians, so convert over
M = deg2rad(M);

%% Algorithm

% === initial guess ==
if M < pi
    E = M + e/2;
elseif M > pi
    E = M - e/2;
end

% === iterate ===
ratio = inf;
tol = 10^-8;

while abs(ratio) > tol
    f1 = E - e*sin(E) - M;
    f2 = 1 - e*cos(E);
    ratio = f1/f2;
    if abs(ratio) > tol
        E = E - ratio;
    end
end

%%

% The algorithm requires the angles be in radians, so convert over
E = rad2deg(E);

end