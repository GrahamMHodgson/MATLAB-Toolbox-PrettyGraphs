function [ Output ] = PrettyColorbar( myColorbar )
%PrettyColorbar returns an output on the success of making a graph's 
% colorbars look pretty
%   
% Created:  2016.02.29
% Author:   Graham Hodgson
% Version:  1.0
% 
%  Version History
%   1.0  [2016.02.29] Genesis. Rather than manually entering this
%   information every time a graph is created a function has been created
%   to manage the 'prettification' of graphs to allow for consistent output
%   in all MATLAB graphing for reports.
%   1.1  [2017.02.13] Change the Font Size to 12
%

try
    set(myColorbar, ...
        'LineWidth',        1, ...
        'Box',              'off', ...
        'FontSize',         10, ...
        'FontName',         'Helvetica',...
        'TickDirection',    'out',...
        'YMinorTick',       'on');
    Output=1;
catch
    Output=-1;
end