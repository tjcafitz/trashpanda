function text = read_text(text_file)
% text = read_text(text_file)
%
% DESCRIPTION:
%    This function reads a text file and returns a cell array of the file's
%    contents. Each cell is one line from the file.
%
% INPUTS:
%    text_file (STRING) - full or relative path to the text file to be
%       analyzed
%
% OUTPUTS:
%    text (Nx1 CELL) - column cell array of the file's contents

%% Input Validation

assert(nargin==1, 'This function requires exactly one input.')
assert(nargout<=1, 'This function does not return more than 1 output.')

assert(ischar(text_file), 'The input ''text_file'' must be class ''char''.')
assert(exist(text_file,'file')==2, 'The ''text_file'' path you provided does not point to a valid, existing file.')

%%

fid = fopen(text_file);

a = fgetl(fid);
ii = 0;
while ischar(a)
    ii = ii + 1;
    text{ii,1} = a; %#ok<AGROW>
    a = fgetl(fid);
end

fclose(fid);

end