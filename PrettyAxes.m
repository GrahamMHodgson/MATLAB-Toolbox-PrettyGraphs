function [ Output ] = PrettyAxes( ax )
%PrettyAxes returns an output on the success of making a graph's axes look 
%pretty
%   
% Created:  2016.02.17
% Author:   Graham Hodgson
% Version:  1.2
% 
%  Version History
%   1.0  [2016.02.17] Genesis. Rather than manually entering this
%   information every time a graph is created a function has been created
%   to manage the 'prettification' of graphs to allow for consistent output
%   in all MATLAB graphing for reports.
%   1.1  [2016.09.29] Set the Font Weight to Bold based on feedback from
%   PDR on first year report, and weight on .
%   1.2  [2017.02.13] Increase the Font Size to 12 from 10.
%

try
    set(ax, ...
        'LineWidth',    1, ...
        'Box',          'off', ...
        'FontSize',     10, ...
        'FontWeight',   'bold', ...
        'XColor',        [0.3 0.3 0.3], ...
        'YColor',        [0.3 0.3 0.3], ...
        'TickDir',      'out', ...
        'FontName',     'Helvetica');
    Output=1;
catch
    Output=-1;
end