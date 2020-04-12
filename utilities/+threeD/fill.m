function h = fill( vertices, varargin )
% h = threeD.fill( vertices, name1, value1, ... )
%
% DESCRIPTION:
%    This function plots (via MATLAB's fill) a surface created with the
%    +threeD tools. The vertices need not begin where they started; the
%    function automatically completes the shape.
%    Additional inputs are provided via name/value pairs. These pairs are
%    described in the INPUTS section below.
%
% INPUTS:
%    vertices (Nx3 DOUBLE) - the vertices of the shape to be filled in
%       three dimensional space; defined in the clockwise direction about H
%    ----------------------------------------------------------------------
%    |   NAME   |                       VALUE                             |
%    ----------------------------------------------------------------------
%    |   'ax'   | (1x1 HANDLE) - defines the axis to place the shape ; if |
%    |          | not provided, then the current axes is used (and if     |
%    |          | none exists, a new one is created)                      |
%    ----------------------------------------------------------------------
%    |   'C'    | (1x3 or 3x1 DOUBLE) - vector defining the color of the  |
%    |          | shape to be plotted                                     |
%    ----------------------------------------------------------------------
%
% OUTPUTS:
%    h (1x1 DOUBLE) - handle to the fill object that is created
%
% EXAMPLE:
%    >> h = threeD.fill( threeD.rectangle('center',[1,1,0],'a',2,'b',2,'H',[1,0,0]) )

%% Input Validation
assert( nargin>=1, 'This function requires at least one input.' )
assert( mod(nargin,2)==1, 'This function requires an odd number of inputs, with name/value pairs following the first single input.' )
assert( nargout<=1, 'This function does not return more than one output.' )

assert( isnumeric(vertices), 'The input ''vertices'' must be numeric.' )
vertices = force.column( vertices ) ;
[ m , n ] = size( vertices ) ;
assert( m>=3, 'The input ''vertices'' must contain more than 2 vertices/points.' )
assert( n==3, 'The input ''vertices'' must define all vertices/points in three dimensional coordinates.' )

% Inputs
for i = 1:2:(nargin-1)
    assert( ischar(varargin{i}), 'All ''names'' provided to this input must be class CHAR.' )
    switch lower(varargin{i})
        case 'ax'
            ax = varargin{i+1} ;
            assert( ishandle(ax), 'The input ''ax'' must be a valid handle.' )
            assert( all(size(ax)==[1,1]), 'The input ''ax'' must be size (1x1).' )
        case 'c'
            C = varargin{i+1} ;
            assert( isnumeric(C), 'The input ''C'' must be numeric.' )
            C = force.row( C ) ;
            assert( all(size(C)==[1,3]), 'The input ''C'' must be either size (1x3) or (3x1).' )
    end
end

%% Defaults

if ~exist('ax','var')
    ax = gca ; hold on
end

if ~exist('C','var')
    C = rand(1,3) ;
end

%%

X = vertices(:,1) ;
Y = vertices(:,2) ;
Z = vertices(:,3) ;

axes( ax ) ;

h = fill3( X, Y, Z, C ) ;

end