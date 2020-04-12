function q = form( theta, vector, deg_rad )
% q = quaternion.form( theta, vector, deg_rad OPTIONAL )
%
% DESCRIPTION:
%    This function takes a vector, and an angle about that vector, and
%    returns the associated quaternion. The vector need not be a unit
%    vector. When a column vector is provided, a column quaterion is
%    returned. Similarly, a row vector will result in a row quaternion.
%    The first element of the quaternion is the scalar.
%    The third input to the function is optional. If provided, it is a flag
%    to tell whether the incoming angle is in radians or degrees. If not
%    provided, then it is assumed the angle is given in radians.
%
% INPUTS:
%    theta (1x1 RAD) - angle (clockwise) to rotate about the vector 
%    vector (3x1 or 1x3 DOUBLE) - vector in 3-D space defining the axis of
%       rotation
%    deg_rad (STRING) - flag to tell if the angle 'theta' is given in
%       radians (via 'rad') or degrees (via 'deg')
%
% OUTPUTS:
%    q (4x1 or 1x4 DOUBLE) - quaternion vector defining a rotation by angle
%       'theta' about axis 'vector'
%
% EXAMPLE:
%    >> q = quaternion.form( 90, [1,0,0], 'deg' )
%
% SOURCES:
%  - http://www.euclideanspace.com/maths/geometry/rotations/conversions/angleToQuaternion/

%% Input Validation
assert( nargin==2||nargin==3, 'This function requires exactly two or three inputs.' )
assert( nargout<=1, 'This function does not return more than one output.' )

assert( isnumeric(theta), 'The input ''theta'' must be numeric.'  )
assert( all(size(theta)==[1,1]), 'The input ''theta'' must be size (1x1).' )

assert( isnumeric(vector), 'The input ''vector'' must be numeric.'  )
[ m , n ] = size(vector) ;
assert( m==1||n==1, 'The input ''vector'' must be one-dimensional.' )

if ~exist('deg_rad','var')
    deg_rad = 'rad' ;
end
assert( ischar(deg_rad), 'The input ''deg_rad'' must be class CHAR.' )
switch deg_rad
    case 'rad'
        % Good
    case 'deg'
        theta = deg2rad(theta) ;
end

%%

a = unit( vector ) ;

ax = a(1) ;
ay = a(2) ;
az = a(3) ;

qx = ax*sin(theta/2) ;
qy = ay*sin(theta/2) ;
qz = az*sin(theta/2) ;
qw = cos(theta/2) ;

q = [ qw , qx , qy , qz ] ;

if iscolumn(vector)
    q = q' ;
end

end