function varargout = which_char( character )
% idx = which_char( character )
%
% DESCRIPTION:
%    This function takes a character (or a character array) and returns the
%    index of which MATLAB character it is. For example, which_char('t')
%    returns a value of 116. The command 'char(116) returns a value of 't'.
%    If no output is requested, then the result is printed to the Command
%    Window. If an output is requested, then no output is printed, and the
%    result is returned in the requested output.
%
% INPUTS:
%    character (STRING) - either a single character, or a character array,
%       to determine the MATLAB character index of
%
% OUTPUTS:
%    idx (1xN DOUBLE) - the MATLAB character index (or indices), where N is
%       the length of the input 'character'
%
% EXAMPLE:
%    >> which_char('t')

%% Input Validation
assert( nargin==1, 'This function requires exactly one input.' )
assert( nargout==0||nargout==1, 'This function either returns 0 or 1 outputs.' )

assert( ischar(character), 'The input ''character'' must be a character array.' )

%% Find the Indices

% Pre-Allocate
N = length(character) ;
idx = zeros( 1, N ) ;

% Loop
for i = 1:N
    found_a_match = false ;
    ii = 0 ;
    while ~found_a_match
        ii = ii + 1 ;
        if strcmp( character(i), char(ii) )
            found_a_match = true ;
            idx(i) = ii ;
        end
    end
end

%% Print to Command Window
if nargout == 0
    fprintf( '::: CHARACTER MATCHING :::\n' ) ;
    fprintf( '\n' ) ;
    for i = 1:N
        fprintf( 'character(%i), or ''%s'', is MATLAB char(%i)\n', i, character(i), idx(i) ) ;
    end
end

%% Return as Output
if nargout == 1
    varargout{1} = idx ;
end

end