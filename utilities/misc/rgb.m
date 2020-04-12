function varargout = rgb(color)
% rgb
% rgb_vec = rgb(color)
%
% DESCRIPTION:
%    This function returns a 3 element RGB vector based on the requested
%    color. If no color is requested, then a figure pops up with all the
%    available choices. The available choices are all 120 colors in the
%    Crayola 120 count Crayon box.
%
% INPUTS:
%    color (STRING) - name of color that you would like an RGB vector for;
%       for a full available list, call the function with no color
%       requested
%
% OUTPUTS:
%    rgb_vec (1x3 NUMBER) - 3 element RGB vector, where each element is a
%       value between 0 and 1
%
% REFERENCES:
%    http://www.jennyscrayoncollection.com/2017/10/complete-list-of-current-crayola-crayon.html

%% Input Validation

assert( nargin<=1, 'This function requires either 0 or 1 inputs.' )
assert( nargout<=1, 'This function does not return more than one output.' )

if nargin == 1
    assert(ischar(color), 'The input ''color'' must be a string.')
    % force easy format
    color = lower(color);
    color = regexprep(color, ' ', '');
    color = regexprep(color, '-', '');
    color = regexprep(color, '_', '');
end

%% === All Colors In Nice Names & 255 RGB Values ===

all_colors = {
    'Tropical Rain Forest', [ 23 128 109];
    'Pine Green',           [ 21 128 120];
    'Pacific Blue',         [ 28 169 201];
    'Blue Green',           [ 25 158 189];
    'Grey',                 [149 145 140];
    'Black',                [ 35  35  35];
    'Outer Space',          [ 64  74  76];
    'Manatee',              [151 154 170];
    'Blue Violet',          [115 102 189];
    'Purple Heart',         [116  66 200];
    'Royal Purple',         [120  81 169];
    
    'Jungle Green',             [ 59 176 143];
    'Caribbean Green',          [ 28 211 162];
    'Robin Egg Blue',           [ 31 206 203];
    'Cerulean',                 [ 29 172 214];
    'Denim',                    [ 43 108 196];
    'Navy Blue',                [ 25 116 210];
    'Midnight Blue',            [ 26  72 118];
    'Indigo',                   [ 93 118 203];
    'Purple Mountains Magesty', [157 129 186];
    'Purple',                   [146 110 174];
    'Eggplant',                 [110  81  96];
    
    'Green',            [ 28 172 120];
    'Shamrock',         [ 69 206 162];
    'Sea Green',        [159 226 191];
    'Turquoise Blue',   [119 221 231];
    'Cornflower',       [154 206 235];
    'Blue',             [ 31 117 254];
    'Wild Blue Wonder', [162 173 208];
    'Blue Bell',        [173 173 214];
    'Wisteria',         [205 164 222];
    'Fuchsia',          [195 100 197];
    'Vivid Violet',     [143  80 157];
    
    'Forest Green',       [109 174 129];
    'Mountain Meadow',    [ 48 186 143];
    'Granny Smith Apple', [168 228 160];
    'Sky Blue',           [128 218 235];
    'Aquamarine',         [120 219 226];
    'Silver',             [205 197 194];
    'Cadet Blue',         [176 183 198];
    'Orchid',             [230 168 215];
    'Shocking Pink',      [251 126 253];
    'Pink Flamingo',      [252 116 253];
    'Plum',               [142  69 133];
    
    'Fern',               [113 188 120];
    'Screamin Green',     [118 255 122];
    'Inch Worm',          [178 236  93];
    'Olive Green',        [186 184 108];
    'Yellow Green',       [197 227 132];
    'Timberwolf',         [219 215 210];
    'Periwinkle',         [197 208 230];
    'Razzle Dazzle Rose', [255  72 208];
    'Hot Magenta',        [255  29 206];
    'Purple Pizzazz',     [255  29 206];
    'Red Violet',         [192  68 143];
    
    'Asparagus',     [135 169 107];
    'Electric Lime', [ 29 249  20];
    'Canary',        [255 255 159];
    'Green Yellow',  [240 232 145];
    'Spring Green',  [236 234 190];
    'White',         [237 237 237];
    'Piggy Pink',    [253 215 228];
    'Lavender',      [252 180 213];
    'Mauvelous',     [239 152 170];
    'Magenta',       [246 100 175];
    'Cerise',        [221  68 146];
    
    'Shadow',          [138 121  93];
    'Laser Lemon',     [253 252 116];
    'Unmellow Yellow', [253 252 116];
    'Yellow',          [252 252 131];
    'Banana Mania',    [250 231 181];
    'Almond',          [239 219 197];
    'Cotton Candy',    [255 188 217];
    'Carnation Pink',  [255 170 204];
    'Tickle Me Pink',  [252 137 172];
    'Wild Strawberry', [255  67 164];
    'Blush',           [222  93 131];
    
    'Beaver',       [159 159 112];
    'Gold',         [231 198 151];
    'Dandelion',    [253 219 109];
    'Goldenrod',    [255 217 117];
    'Apricot',      [253 217 181];
    'Desert Sand',  [239 205 184];
    'Melon',        [253 188 180];
    'Salmon',       [255 255 170];
    'Pink Sherbet', [247 128 161];
    'Violet Red',   [247  83 148];
    'Razzmatazz',   [227  37 107];
        
    'Sepia',               [165 105  79];
    'Tumbleweed',          [222 170 136];
    'Sunglow',             [255 207  72];
    'Yellow Orange',       [255 182  83];
    'Peach',               [255 207 171];
    'Macaroni and Cheese', [255 189 136];
    'Atomic Tangerine',    [255 164 116];
    'Vivid Tangerine',     [255 160 137];
    'Wild Watermelon',     [252 108 133];
    'Red',                 [238  32  77];
    'Jazzberry Jam',       [202  55 103];
    
    'Brown',         [180 103  77];
    'Antique Brass', [205 149 117];
    'Neon Carrot',   [255 163  67];
    'Mango Tango',   [255 130  67];
    'Orange',        [255 117  56];
    'Tan',           [250 167 108];
    'Burnt Sienna',  [234 126  93];
    'Bittersweet',   [253 124 110];
    'Radical Red',   [255  73 107];
    'Scarlet',       [242  40  71];
    'Maroon',        [200  56  90];
    
    'Copper',            [221 148 117];
    'Raw Sienna',        [214 138  89];
    'Burnt Orange',      [255 127  73];
    'Outrageous Orange', [255 110  74];
    'Sunset Orange',     [253  94  83];
    'Red Orange',        [255  83  73];
    'Chesnut',           [188  93  88];
    'Fuzzy Wuzzy Brown', [204 102 102];
    'Mahogany',          [205  74  74];
    'Brick Red',         [203  65  84];
    };

% Turn the [0,255] RGB vector into [0,1]
all_colors(:,2) = cellfun(@(x) x/255, all_colors(:,2), 'UniformOutput', false);

%% EXAMPLE CHART
% Put the exampe chart here, when the names are still nice

if nargin == 0
    figure('Name', 'Available RGB Vector Choices', 'Position', get(0,'ScreenSize'));
    hold on
    axis off
    grid off
    set(gca, 'OuterPosition', [-0.15,-0.1,1.25,1.15])
    n_colors = length(all_colors(:,1));
    % Evenly divide the colors out into squares
    N = ceil(sqrt(n_colors));
    axis([0,N,0,N])
    ii = 0;
    for x = 1:N
        for y = N:-1:1
            ii = ii + 1;
            if ii <= n_colors
                fill([x-1,x,x,x-1,x-1], [y-1,y-1,y,y,y-1], rgb(all_colors{ii,1}))
                text(x-0.5, y-0.5, all_colors{ii,1}, 'HorizontalAlignment', 'Center')
            end
        end
    end
    return
end

%% Random Color
% If a random color was selected, just give a random color

if strcmp(color,'random')
    varargout{1} = rand(1,3);
    return
end
        
%% All Other Choices

% Make the names all lower case with not spaces, dashes, or underscores.
all_colors(:,1) = cellfun(@(x) lower(x), all_colors(:,1), 'UniformOutput', false);
all_colors(:,1) = cellfun(@(x) regexprep(x,' ',''), all_colors(:,1), 'UniformOutput', false);
all_colors(:,1) = cellfun(@(x) regexprep(x,'-',''), all_colors(:,1), 'UniformOutput', false);
all_colors(:,1) = cellfun(@(x) regexprep(x,'_',''), all_colors(:,1), 'UniformOutput', false);

color_choice = strcmp(all_colors(:,1), color);
color_idx = find(color_choice);

if isempty(color_idx)
    error('The color you have requested was not found!')
elseif length(color_idx) > 1
    error('There seems to be two matches for the color you requested...')
end

rgb_vec = all_colors{color_idx,2};

%% OUTPUT
% Provide an output (since if we've gotten here, a color was requested, and
% not the chart).

varargout{1} = rgb_vec;

end