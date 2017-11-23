function [ Output ] = PrettyLabel( myLabel )
%PrettyLabel returns an output on the success of making a graph's labels 
%look pretty
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
%   1.1  [2016.05.18] Set the Font Weight to Bold based on feedback from
%   PDR on first year report.
%   1.2  [2017.02.13] Set the Font Size to 12.
%

try
    set(myLabel, ...
        'FontSize',     10, ...
        'Color',        [0.3 0.3 0.3], ...
        'FontName',     'Helvetica', ...
        'FontWeight',   'Bold');
    Output=1;
catch
    Output=-1;
end