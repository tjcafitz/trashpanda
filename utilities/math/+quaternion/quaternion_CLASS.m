classdef quaternion
    % OBJ = quaternion( )
    % OBJ = quaternion( q )
    % OBJ = quaternion( theta, vector )
    %
    % DESCRIPTION:
    %    This class, 'quaternion', is a custom defined MATLAB class to
    %    store information about a quaternion, and to define a set of
    %    special operations specific to quaternions.
    %    The quaternion can be initialized by a class call, which provides
    %    an empty OBJECT for the user to fill in. The user can also provide
    %    either the 4 element q vector, or the angle of rotation and the
    %    axis of rotation (differentiated by supplying either one or two
    %    inputs).
    %    Whenever inputs are provided (either on initialization, or when
    %    any VALUE is updated), all VALUES of the quternion OBJECT are 
    %    updated/filled in.
    %    The first element of the quaternion.q is the scalar. All vectors
    %    are forced to be column vectors, and all angles are dealt with in
    %    radians.
    %
    % VALUES:
    %    theta (1x1 RAD) - angle (clockwise) to rotate about the vector
    %    vector (3x1 DOUBLE) - vector in 3-D space defining the axis of
    %       rotation
    %    q (4x1 DOUBLE) - quaternion vector defining a rotation by angle
    %       'theta' about axis 'vector'
    %    R (3x3 DOUBLE) - rotation matrix for rotating another vector about
    %       this quaternion
    %
    % SOURCES:
    %  - http://www.euclideanspace.com/maths/geometry/rotations/conversions/angleToQuaternion/
    
    properties
        q
        theta
        vector
        R
    end
    
    methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Definition/Initialization                                       %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function obj = quaternion( inp1, inp2 )
            switch nargin
                case 0
                    % Do no more.
                    fprintf('here\n\n\n') ;
                case 1
                    % If a single input is provided, it is the quaternion (4-element) vector
                    q = inp1 ;
                    assert( isnumeric(q), 'The input ''q'' must be numeric.'  )
                    q = force.column(q) ;
                    assert( all(size(q)==[4,1]), 'The input ''q'' must be size (4x1).' )
                    obj.q = q ;
                case 2
                    % If two inputs are provided, it is the angle and vector of rotation
                    theta = inp1 ;
                    vector = inp2 ;
                    assert( isnumeric(theta), 'The input ''theta'' must be numeric.'  )
                    assert( all(size(theta)==[1,1]), 'The input ''theta'' must be size (1x1).' )
                    assert( isnumeric(vector), 'The input ''vector'' must be numeric.'  )
                    vector = force.column(vector) ;
                    assert( all(size(vector)==[3,1]), 'The input ''vector'' must be size (sx1).' )
                otherwise
                    error( 'This function requires exactly zero, one, or two inputs.' )
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Form q from theta and vector                                    %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function q = form( theta, vector, deg_rad )
            assert( nargin==2||nargin==3, 'This function requires exactly two or three inputs.' )
            assert( nargout<=1, 'This function does not return more than one output.' )
            
            assert( isnumeric(theta), 'The input ''theta'' must be numeric.'  )
            assert( all(size(theta)==[1,1]), 'The input ''theta'' must be size (1x1).' )
            
            assert( isnumeric(vector), 'The input ''vector'' must be numeric.'  )
            [ m , n ] = size(vector) ;
            assert( m==1||n==1, 'The input ''vector'' must be one-dimensional.' )
            
        end
    end
end