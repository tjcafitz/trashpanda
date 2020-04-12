function stats = analyze_text( text_file )
% stats = analyze_text( text_file )
%
% DESCRIPTION:
%    This function analyzes a text file. It finds a variety of patterns and
%    statistics, like most used letters, most common words, and average
%    sentence length. The data is presented in a figure, as well as a
%    structure, where each field is a different statistic.
%
% INPUTS:
%    text_file (STRING) - full or relative path to the text file to be
%       analyzed
%
% OUTPUTS:
%    stats (STRUCT) - structure with various fields for the different
%       statistics pulled about the text
%
% EXAMPLE:
%    >> analyze_text( './path/to/file.txt' ) ;

%% Input Validation
assert( nargin==1, 'This function requires exactly one input.' )
assert( nargout<=1, 'This function does not return more than 1 output.' )

% 'text_file' validation occurs in the 'read_text' function
text = read_text( text_file ) ;

%%

% Concatenate the strings into a single string to make it easier to deal with.
text_str = horzcat( text{:} ) ;
% Also get the character numbers
text_chars = which_char( text_str ) ;

% Count up the characters (total and character specific).
stats.number_of_characters = length( text_str ) ;

xout_a_z = which_char('a'):which_char('z') ;
xout_A_Z = which_char('A'):which_char('Z') ;
xout_0_9 = which_char('0'):which_char('9') ;

chars_a_z = text_chars( and(text_chars>=xout_a_z(1),text_chars<=xout_a_z(end)) ) ;
chars_A_Z = text_chars( and(text_chars>=xout_A_Z(1),text_chars<=xout_A_Z(end)) ) ;
chars_0_9 = text_chars( and(text_chars>=xout_0_9(1),text_chars<=xout_0_9(end)) ) ;

n_a_z = hist( chars_a_z, xout_a_z ) ;
n_A_Z = hist( chars_A_Z, xout_A_Z ) ;
n_0_9 = hist( chars_0_9, xout_0_9 ;

stats.character_counts.lower_case_letters = n_a_z ;

end