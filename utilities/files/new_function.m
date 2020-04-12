function new_function(fxn_name)
% new_function(fxn_name)
%
% DESCRIPTION:
%    This function is used to initialize a new function. The benefit is
%    that the description/input/output documentation is intialized, as is
%    the section for Input Validation.
%    NOTE: For variables with specified sizes, follow the0 (MxN) format,
%    and not (M,N).
%
% INPUTS:
%    fxn_name (STRING) - character array of the name for the function to be
%       created
%
% OUTPUTS: none

%% Input Validation

assert(nargin==1, 'This function requires exactly one input.')
assert(nargout==0, 'This function does not return any outputs.')

assert(ischar(fxn_name), ...
    'The input ''fxn_name'' must be a character array.')
assert(~exist(fxn_name,'file'), ...
    'It looks like that function already exists.')
    
%% Split Up Name
% Split the input into path, name, and extension to verify each part.

[fxn_path, fxn_name, fxn_ext] = fileparts(fxn_name);

%% PATH
% Verify the function path exists. If it doesn't, then ask the user if they
% would like the directory to be created.

if ~exist(fxn_path,'dir') == 7
    fprintf('The directory you provided is: %s\n', fxn_path);
    create_it = ask_yes_or_no( ...
        'It does not exist. Would you like to create it?');
    if create_it
        mkdir_smart(fxn_path)
    else
        fprintf('OK, but that means I cannot continue.\n');
        fprintf('Quitting WITHOUT creating your new function.\n');
        return
    end
end

%% NAME
% Check with the user that the function name is correct.

fprintf('The function name you have provided is "%s".\n', fxn_name);
it_is_correct = ask_yes_or_no('Is this correct?');
if ~it_is_correct
    fprintf('OK, but that means I cannot continue.\n');
    fprintf('Quitting WITHOUT creating your new function.\n');
    return
end

%% EXTENSION
% If the .m extension is not incuded, then add it. If it is included, then
% make sure it is correct.

if isempty(fxn_ext)
    fxn_ext = '.m';
else
    assert(strcmp(fxn_ext,'.m'), ...
        'If providing a file extension, it must be ".m".')
end

%% Create

full_fxn_name = fullfile(fxn_path, [fxn_name,fxn_ext]);

fid = fopen(full_fxn_name, 'w');
fprintf(fid, 'function [] = %s()\n', fxn_name);
fprintf(fid, '%% [] = %s()\n', fxn_name);
fprintf(fid, '%%\n');
fprintf(fid, '%% DESCRIPTION:\n');
fprintf(fid, '%%    Desc here\n');
fprintf(fid, '%%\n');
fprintf(fid, '%% INPUTS:\n');
fprintf(fid, '%%    input_1 (DIM) - desc\n');
fprintf(fid, '%%\n');
fprintf(fid, '%% OUTPUTS:\n');
fprintf(fid, '%%    output_1 (DIM) - desc\n');
fprintf(fid, '\n');
fprintf(fid, '%%%% Input Validation\n');
fprintf(fid, '\n');
fprintf(fid, '%% assert(nargin==1, ''This function requires exactly one input.'')\n');
fprintf(fid, '%% assert(nargout<=1, ''This function does not return more than one output.'')\n');
fprintf(fid, '\n');
fprintf(fid, '%%%%\n');
fprintf(fid, '\n');
fprintf(fid, '\n');
fprintf(fid, 'end');
fclose(fid);

% Open the function, and enjoy!
edit(full_fxn_name);

end