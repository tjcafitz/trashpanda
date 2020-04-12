function v2 = rotate( v1, q_vec, theta, deg_rad )
% v2 = quaternion.rotate( v1, q )
% v2 = quaternion.rotate( v1, vector, theta, deg_rad OPTIONAL )
%
% DESCRIPTION:
%    This function takes a vector and returns the vector rotated about a
%    quaternion. That quaternion can be provided directly to this function,
%    or an angle/vector pair can be provided.
%
% INPUTS:
%    v1 (1x3 or 3x1 DOUBLE) - original, unrotated vector in
%       three-dimensional space
%    q (4x1 or 1x4 DOUBLE) - quaternion vector defining a rotation by angle
%       'theta' about axis 'vector'
%    vector (3x1 or 1x3 DOUBLE) - vector in 3-D space defining the axis of
%       rotation
%    theta (1x1 RAD) - angle (clockwise) to rotate about the vector 
%    deg_rad (STRING) - flag to tell if the angle 'theta' is given in
%       radians (via 'rad') or degrees (via 'deg')
%
% OUTPUTS:
%    v2 (1x3 or 3x1 DOUBLE) - final, rotated vector in three-dimensional
%       space
%
% EXAMPLE:
%    >> v2 = quaternion.rotate( [1,0,0], [0,0,1], 90, 'deg' )

%% Input Validation
assert( nargin==2||nargin==4||nargin==5, 'This function requires exactly two, four, or five inputs.' )
assert( nargout<=1, 'This function does not return more than one output.' )

assert( isrow(v1)||iscolumn(v1), 'The input ''v1'' must be either a row or column wector.' )

switch nargin
    case 2
        q = q_vec ;
        assert( isnumeric(q), 'The input ''q'' must be numeric.'  )
        assert( isrow(q)||iscolumn(q), 'The input ''q'' must be either a row or column wector.' )
    case {4,5}
        vector = q_vec ;
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
        q = quaternion.form( theta, vector, deg_rad ) ;
end

%%

R = quaternion.rotation_matrix( q ) ;

v2 = R*force.column(v1) ;

if isrow(v1)
    v2 = v2' ;
end

end