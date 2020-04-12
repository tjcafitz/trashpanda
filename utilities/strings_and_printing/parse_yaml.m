function yaml_struct = parse_yaml(yaml_file)
% yaml_struct = parse_yaml(yaml_file)
%
% DESCRIPTION:
%    This function parses a YAML file, and returns a struct with the YAML's
%    contents.
%
% INPUTS:
%    yaml_file (CHAR) - full or relative path to YAML file (must include
%       the '.yaml' extension')
%
% OUTPUTS:
%    yaml_struct - (1x1 STRUCT) struct with field corresponding to the
%       fields in the YAML file

%% Input Validation

assert(nargin==1, 'This function requires exactly 1 input.')
assert(nargout<=1, 'This function does not return more than one output.')

% yaml_file
assert(ischar(yaml_file), 'The input ''yaml_file'' must be class CHAR.')
[~, ~, ext] = fileparts(yaml_file);
assert(strcmp(ext,'.yaml'), 'The input ''yaml_file'' must include the extension ''.yaml''.')
clear ext
assert(exist(yaml_file,'file')==2, 'The input ''yaml_file'' must point to a valid, existing file.')

%% Pull Raw Text

yaml_text = read_text(yaml_file);

% remove commented lines
commented_lines = cellfun( ...
    @(x) ~isempty(regexp(x, '^[ ]*#', 'once')), ...
    yaml_text ...
    );
yaml_text(commented_lines) = [];
clear commented_lines

% remove empty lines
empty_lines = cellfun( ...
    @(x) isempty(regexprep(x, ' ', '')), ...
    yaml_text ...
    );
yaml_text(empty_lines) = [];
clear empty_lines

%% March, Line By Line, Through YAML

% initialize the "last info"
last_col = 0;
curr_var = 'yaml_struct';
yaml_struct = struct;

for i = 1:length(yaml_text)
    % pull this line
    this_line = yaml_text{i};
    % how indented is this line?
    this_col = regexp(this_line, '[^ ]', 'once');
    % trim off the front whitespace
    this_line =  this_line(this_col:end);
    % is there a dash?
    has_dash = ~isempty(regexp(this_line, '^-', 'once'));
    % read the field name
    new_field_name = regexp(this_line, '-* *([a-zA-Z0-9_]+):', 'tokens');
    new_field_name = de_cell(new_field_name);
    % is there a value on this line?
    has_value = ~isempty(regexp(this_line, ['-* *',new_field_name,':.+'], 'once'));
    if has_value
        curr_val = regexp(this_line, ['-* *',new_field_name,':[ ]*(.+)[ ]*'], 'tokens');
        curr_val = de_cell(curr_val);
        switch length(str2num(curr_val)) %#ok<ST2NM>
            case 1
                % leave as is
            otherwise
                curr_val = ['''', curr_val, '''']; %#ok<AGROW>
        end
    end
    
    if this_col==last_col
        % no indent means we are building up an element
        % next steps depend on whether or not there is a dash
        if has_dash
            error('CODE ME')
        else
            % if there is no dash, then add a new field to the variable UP
            % from where we currently are (so that is's at the same level
            % as that last curr_var)
            split = regexp(curr_var, '\.') - 1;
            curr_var = curr_var(1:split(end));
            curr_var = sprintf('%s.%s', curr_var, new_field_name);
            if has_value
                eval(sprintf('%s = %s;', curr_var, curr_val))
            else
                eval(sprintf('%s = [];', curr_var))
            end
        end
        
    elseif this_col<last_col
        % we've "un"dented, which means the field we are looking at should
        % already exist
        % how many have we "un"dented?
        undent = last_col - this_col;
        % every 4 characters means we must go up a struct field
        while undent > 4
            split = regexp(curr_var, '\.') - 1;
            curr_var = curr_var(1:split(end));
            undent = undent - 4;
        end
        if undent==2 && has_dash
            % that means we can add this as a new element to the existing field
            found_it = false;
            while ~found_it
                % go up a variable
                split = regexp(curr_var, '\.') - 1;
                curr_var = curr_var(1:split(end));
                % is the var here?
                eval(sprintf('found_it = isfield(%s, ''%s'');',curr_var,new_field_name))
            end
            % found it!
            % how long is the parent now?
            curr_len = regexp(curr_var, '(([0-9]+)\)$', 'tokens');
            if isempty(curr_len)
                eval(sprintf('curr_len = length(%s);', curr_var))
            else
                curr_len = str2num(de_cell(curr_len)); %#ok<ST2NM>
                split = regexp(curr_var, '\(') - 1;
                curr_var = curr_var(1:split(end));
            end
            % ok, set the length to one more
            curr_len = curr_len + 1;
            curr_var = sprintf('%s(%.0f)', curr_var, curr_len);
            % now we can add the new field to this next element
            curr_var = sprintf('%s.%s', curr_var, new_field_name);
            if has_value
                eval(sprintf('%s = %s;', curr_var, curr_val))
            else
                eval(sprintf('%s = [];', curr_var))
            end
        elseif undent==4 && ~has_dash
            % that means we need to go up a field, and add a new field
            split = regexp(curr_var, '\.') - 1;
            curr_var = curr_var(1:split(end));
            split = regexp(curr_var, '\.') - 1;
            curr_var = curr_var(1:split(end));
            curr_var = sprintf('%s.%s', curr_var, new_field_name);
            if has_value
                eval(sprintf('%s = %s;', curr_var, curr_val))
            else
                eval(sprintf('%s = [];', curr_var))
            end
        else
            error('CODE ME')
        end
        
    elseif this_col>last_col
        % looks like we've indented
        % next steps depend on whether or not there is a dash
        if has_dash
            % if there is a dash, then add a new element to the current
            % field (initialize if element==1, i.e. length==0)
            eval(sprintf('curr_len = length(%s);', curr_var))
            if curr_len == 0
                curr_var = sprintf('%s.%s', curr_var, new_field_name);
                if has_value
                    eval(sprintf('%s = %s;', curr_var, curr_val))
                else
                    eval(sprintf('%s = [];', curr_var))
                end
            else
                error('CODE ME')
            end
        else
            % if there is no dash, then add a new field
            curr_var = sprintf('%s.%s', curr_var, new_field_name);
            if has_value
                eval(sprintf('%s = %s;', curr_var, curr_val))
            else
                eval(sprintf('%s = [];', curr_var))
            end
        end
    end
    
    % all done! save off "this info" as the "last info"
    if has_dash
        % adjust for the "- "
        last_col = this_col + 2;
    else
        % no adjustments needed
        last_col = this_col;
    end
end

end