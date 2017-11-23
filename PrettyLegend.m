function [ Output ] = PrettyLegend( myLegend )
%PrettyLegend returns an output on the success of making a graph's legends
%look pretty
%
% Created:  2016.02.18
% Author:   Graham Hodgson
% Version:  1.3
%
%  Version History
%   1.0  [2016.02.18] Genesis. Rather than manually entering this
%   information every time a graph is created a function has been created
%   to manage the 'prettification' of graphs to allow for consistent output
%   in all MATLAB graphing for reports.
%   1.1  [2016.06.15] Set the Font Weight to Bold, and size to 10 based on
%   feedback from PDR on first year report.
%   1.2  [2016.10.27] Use the BoxFace and BoxEdge hidden features to
%   improve the look - box on, alpha set to 0.4 with a white background,
%   and no edge to the box.
%   1.3  [2017.02.13] Change the Font Size to 12.
%

try
    %If the location has been manually set and the User Data set
    %accordingly then don't set the location systematically
    if strcmpi(myLegend.UserData,'Loc_')
        set(myLegend, ...
            'FontSize',     10, ...
            'FontWeight',   'bold', ...
            'FontName',     'Helvetica');
    else
        set(myLegend, ...
            'FontSize',     10, ...
            'FontWeight',   'bold', ...
            'FontName',     'Helvetica', ...
            'location',     'southeast');
    end
    myLegend.BoxFace.ColorType='truecoloralpha';
    myLegend.BoxFace.ColorData=uint8(255*[1;1;1;0.4]);
    myLegend.BoxEdge.LineStyle='none';
    Output=1;
catch
    Output=-1;
end