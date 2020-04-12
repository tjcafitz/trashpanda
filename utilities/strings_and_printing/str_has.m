function main_str_has_sub_str = str_has(main_str, sub_str)
% main_str_has_sub_str = str_has(main_str, sub_str)
%
% DESCRIPTION:
%    This function checks to see if a certain sub-string is contained, at
%    some point, within a larger string.
%    This function searches for the EXACT sub-string you provide; if you
%    want to take advantage of the regexp characters, then do so in the
%    sub-string itself.
%
% INPUTS:
%    main_str (CHAR) - main string to seach for substring within
%    sub_str (CHAR) - sub string to seach main string for
%
% OUTPUTS:
%    main_str_has_sub_str (1xq BOOL) - whether or not the main string
%       contains the sub-string

%% Input Validation

assert(nargin==2, 'This function requires exactly 2 inputs.')
assert(nargout<=1, 'This function does not return more than one output.')

% All must be CHAR
assert(ischar(main_str), 'The input ''main_str'' must be class CHAR.')
assert(ischar(sub_str), 'The input ''sub_str'' must be class CHAR.')

%%

% Search for the sub-string
idx_of_match = regexp(main_str, sub_str, 'ONCE');

% Well.. did it have it???
main_str_has_sub_str = ~isempty(idx_of_match);

end