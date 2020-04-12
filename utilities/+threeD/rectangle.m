function vertices = rectangle(varargin)
% threeD.rectangle(name1, value1, name2, value2, ...)
%
% DESCRIPTION:
%    This function provides the four vertices of a rectangle, in three
%    dimensional space. The four vertices are provided clockwise about the
%    normal vector to the face of the rectangle. 'a' is the top/bottom of
%    the rectangle, and 'b' is the left/right of the rectangle.
%    Characteristics of the rectangle are provided via name/value pairs.
%    These pairs are described in the INPUTS section below.
%
%                 a
%           1 --------- 2
%            |    ^    |
%            |    .  > |   b   where H comes out of the screen
%            |         |
%           4 --------- 3
%
% INPUTS (names):
%    'center' (1x3 or 3x1 DOUBLE) - origin of the rectangle in three
%       dimensional space; default is [0,0,0]
%    'a' (1x1 DOUBLE) - length of the top and bottom sides of the
%       rectangle; default is 1
%    'b' (1x1 DOUBLE) length of the left and right sides of the rectangle;
%       default is 1
%    'H' (1x3 or 3x1 DOUBLE) - vector defining the desired normal of the
%       rotated, final shape; default is [0,0,1]
%
% OUTPUTS:
%    vertices (4x3 DOUBLE) - the four vertices of the shape in three
%       dimensional space; defined in the clockwise direction about H

%% Input Validation

assert(mod(nargin,2)==0, 'This function requires an even number of inputs, in name/value pairs.')
assert(nargout<=1, 'This function does not return more than 1 output.')

% Inputs
for i = 1:2:nargin
    assert(ischar(varargin{i}), 'All ''names'' provided to this input must be class CHAR.')
    switch lower(varargin{i})
        case 'center'
            center = varargin{i+1};
            assert(isnumeric(center), 'The input ''center'' must be numeric.')
            center = force.row(center);
            assert(all(size(center)==[1,3]), 'The input ''center'' must be either size (1x3) or (3x1).')
        case 'a'
            a = varargin{i+1};
            assert(isnumeric(a), 'The input ''a'' must be numeric.')
            assert(all(size(a)==[1,1]), 'The input ''a'' must be size (1x1).')
        case 'b'
            b = varargin{i+1};
            assert(isnumeric(b), 'The input ''b'' must be numeric.')
            assert(all(size(b)==[1,1]), 'The input ''b'' must be size (1x1).')
        case 'h'
            H = varargin{i+1};
            assert(isnumeric(H), 'The input ''H'' must be numeric.')
            H = force.row(H);
            assert(all(size(H)==[1,3]), 'The input ''H'' must be either size (1x3) or (3x1).')
        otherwise
            error('You have provided an unrecognized input: %s', varargin{i})
    end
end

%% Defaults

% If the center has not been provided, then center the rectangle at the
% origin
if ~exist('center','var')
    center = [0 , 0 , 0];
end

% If either of the two dimensions have not been provided, then use unity
if ~exist('a','var')
    a = 1;
end
if ~exist('b','var')
    b = 1;
end

% If the orientation of the rectangle has not been provided, then assume it
% will lie in the xy plane
if ~exist('H','var')
    H = [0 , 0 , 1];
end

%%

% Start by making a rectangle (size a by b) at the origin in the xy plane.
vertices = [ ...
    -a/2 ,  b/2 , 0;
     a/2 ,  b/2 , 0;
     a/2 , -b/2 , 0;
    -a/2 , -b/2 , 0 ...
    ];

% Rotate the rectangle so that H is oriented as requested.
H0 = [0 , 0 , 1]; % normal of original shape
q_ang = 0; % angle between original normal and desired normal, to rotate shape by
q_vec = cross(H, H0); % vector normal to both normals, to rotate shape about

% Move the rotated rectangle to the desired location.
for i = 1:4
    vertices(i,:) = vertices(i,:) + center;

end