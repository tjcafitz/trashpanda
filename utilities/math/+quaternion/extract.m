function [ vector, theta ] = extract( q, deg_rad )
% [ vector, theta ] = quaternion.extract( q, deg_rad OPTIONAL )
%
% DESCRIPTION:
%    This function takes quaternion and returns the associated vector and
%    an angle about that vector. The quaternion need not be a unit
%    quaternion. When a column quaternion is provided, a column vector is
%    returned. Similarly, a row quaternion will result in a row vector.
%    The first element of the quaternion is the scalar.
%    The second input to the function is optional. If provided, it is a 
%    flag to tell whether the returned angle should be in radians or 
%    degrees. If not provided, then it is assumed the angle is given in
%    radians.
%
% INPUTS:
%    q (4x1 or 1x4 DOUBLE) - quaternion vector defining a rotation by angle
%       'theta' about axis 'vector'
%    deg_rad (STRING) - flag to tell if the angle 'theta' is given in
%       radians (via 'rad') or degrees (via 'deg')
%
% OUTPUTS:
%    theta (1x1 RAD) - angle (clockwise) to rotate about the vector 
%    vector (3x1 or 1x3 DOUBLE) - vector in 3-D space defining the axis of
%       rotation
%
% EXAMPLE:
%    >> [ vector, theta ] = quaternion.extract( quaternion.form(90,[1,0,0],'deg'), 'deg' )

%% Input Validation
assert( nargin==1||nargin==2, 'This function requires exactly one or two inputs.' )
assert( nargout<=2, 'This function does not return more than two outputs.' )

assert( isnumeric(q), 'The input ''q'' must be numeric.'  )
[ m , n ] = size(q) ;
assert( m==1||n==1, 'The input ''q'' must be one-dimensional.' )

if ~exist('deg_rad','var')
    deg_rad = 'rad' ;
end
assert( ischar(deg_rad), 'The input ''deg_rad'' must be class CHAR.' )
switch deg_rad
    case {'rad','deg'}
    otherwise
        error( 'The input ''deg_rad'' must be either ''deg'' or ''rad''.' )
end

%%

theta = acos(q(1))*2 ;

vector = q(2:4)./sin(theta/2) ;

if strcmp(deg_rad,'deg')
    theta = rad2deg(theta) ;
end

end