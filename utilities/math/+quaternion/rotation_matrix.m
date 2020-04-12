function R = rotation_matrix( q )
% R = quaternion.rotation_matrix( q )
%
% DESCRIPTION:
%    This function takes a quaternion, and returns the associated rotation
%    matrix. The quaternion must be of the form [ a + bi + cj + dk ], where
%    'a' is the scalar.
%
% INPUTS:
%    q (1x4 or 4x1 DOUBLE) - quaternion vector
%
% OUTPUTS:
%    R (3x3 DOUBLE) - rotation matrix
%
% EXAMPLE:
%    >> R = quaternion.rotation_matrix( quaternion.form(90,[1,0,0],'deg') )

%% Input Validation
assert( nargin==1, 'This function requires exactly one input.' )
assert( nargout<=1, 'This function does not return more than one output.' )

assert( isrow(q)||iscolumn(q), 'The input ''q'' must be either a row or column wector.' )
assert( all(size(force.row(q))==[1,4]), 'The input ''q'' must be either size (1x4) or (4x1).' )

%%

q = unit( q ) ;

q0 = q(1) ;
q1 = q(2) ;
q2 = q(3) ;
q3 = q(4) ;

R = [  1-2*q2^2-2*q3^2 , 2*(q1*q2+q0*q3) , 2*(q1*q3-q0*q2)   ;
       2*(q1*q2-q0*q3) , 1-2*q1^2-2*q3^2 , 2*(q2*q3+q0*q1)   ;
       2*(q1*q3+q0*q2) , 2*(q2*q3-q0*q1) , 1-2*q1^2-2*q2^2 ] ;
     
end