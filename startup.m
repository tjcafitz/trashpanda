tic

% Navigate to addpath_recursively
cd /home/tim/git/trashpanda/utilities/directories/

% Update the path to include all of my folders
addpath_recursively('/home/tim/git/trashpanda')
savepath
clc
clear all

% Navigate home
cd /home/tim/git/trashpanda

% Set defaults
format compact
format longg
dbstop if error
set(0, 'DefaultFigurePosition', [100, 50, 1200, 800])
set(0, 'DefaultFigureColor', [1, 1, 1])
set(0, 'DefaultAxesColor', [0.8, 0.8, 0.8])
set(0, 'DefaultAxesXGrid', 'on')
set(0, 'DefaultAxesYGrid', 'on')
set(0, 'DefaultAxesZGrid', 'on')
set(0, 'DefaultLineLineWidth', 2)
set(0,'defaultFigureCreateFcn','addToolbarExplorationButtons(gcf)')
set(0,'defaultAxesCreateFcn','set(get(gca,''Toolbar''),''Visible'',''off'')')
set(0,'defaultLegendAutoUpdate','off');

% Alert user
fprintf('Time To Start MATLAB: %.2f s\n', toc);