function [outputVals]=FigConfig(myFig,reqType)
%FigConfig alters the figure dimensions and other useful settings to
%provide a consistent branding.
%
% Figures will be resized according to the reqType listed below:
%  reqType: J21  - 2 column journal, 81mm text width, 1 figure wide
%  reqType: J22  - 2 column journal, 81mm text width, 2 figures wide
%  reqType: P169 - 16x9 PowerPoint presentation
%  reqType: P100 - 100m x 100mm poster sized figure
%  reqType: T11  - 1 column thesis, 140mm text width, 1 figure wide
%  reqType: T12  - 1 column thesis, 140mm text width, 2 figure wide
%
% (c) Graham Hodgson. Loughborough University
% v1.9
% 2017.02.14
%
% v.  1.0 - Genesis.
% v.  1.1 - Apply standardised look to figure.
% v.  1.2 - Apply SAE Color function and rework color setting to use
%           numbers rather than strings
% v   1.3 - remove exists clause when checking for the gridline tag
% v.  1.4 - Addition of morgenstemning colormap
% v.  1.5 - Handle subplots correctly
% v.  1.6 - Create a paper size (P100) suitable for posters 100mm x 100mm
% v.  1.7 - Addition of patch and light into coloring configuration
% v.  1.8 - Addition of T13 paper size for tabulated figures
% v.  1.9 - Bug fixes around objects that don't have axes

verMatlab=ver('MATLAB');

switch reqType
    case 'J21'
        %2 column journal 81mm 1 fig wide
        try
            figPaperSize=[8.1 8.1];
        catch
            warning('Failed setting figPaperSize for reqType=J21');
            outputVals=-1;
        end
        outputVals=1;
    case 'J22'
        %2 column journal 81mm 2 fig wide
        try
            figPaperSize=[3.6 3.6];
        catch
            warning('Failed setting figPaperSize for reqType=J22');
            outputVals=-1;
        end
        outputVals=1;
    case 'P169'
        %16x9 PowerPoint presentation
        try
            figPaperSize=[10.3 13.8];
        catch
            warning('Failed setting figPaperSize for reqType=P169');
            outputVals=-1;
        end
        outputVals=1;
    case 'P100'
        %100mm x 100mm poster sized
        try
            figPaperSize=[10.0 10.0];
        catch
            warning('Failed setting figPaperSize for reqType=P100');
            outputVals=-1;
        end
        outputVals=1;
    case 'T11'
        %1 column thesis, 140mm text width, 1 figure wide
        try
            figPaperSize=[14.0 14.0];
        catch
            warning('Failed setting figPaperSize for reqType=T11');
            outputVals=-1;
        end
        outputVals=1;
    case 'T12'
        %1 column thesis, 140mm text width, 2 figure wide
        try
            figPaperSize=[6.3 6.3];
        catch
            warning('Failed setting figPaperSize for reqType=T12');
            outputVals=-1;
        end
        outputVals=1;
    case 'T13'
        %1 column thesis, 40mm text width, 3 figure wide
        try
            figPaperSize=[4.0 4.0];
        catch
            warning('Failed setting figPaperSize for reqType=T13');
            outputVals=-1;
        end
        outputVals=1;
end


%% Set the colours and marker to required ('r*','b+','g>','mo','cd')
%if exist(myFig.Tag) && (strcmp(myFig.Tag,'SAE'))
if (strcmp(myFig.Tag,'SAE'))
    setSAEColors;
    strLineColor = {[colorSAEBlueLight];[colorSAEBlueDark];[colorSAEGreenLight];[colorSAEGreenDark];[colorSAEOrange];[colorSAEGrayMed]};
else
    %strLineColor  = ['r','b','g','m','c']';
    %strLineColor  = {[0 0 0];[230 159 0];[86 180 233];[0 158 115];[240 228 66];[0 114 178];[213 94 0];[204 121 167]};
    strLineColor  = {[255 0 0];[0 0 255];[0 255 0];[255 0 255];[0 255 255];[255 255 0]};
end
strLineMarker = ['*','+','>','o','d','p']';
numSubplots   = length(myFig.Children);
try
    for j=1:numSubplots
        numDataSeries = length(myFig.Children(j).Children);
        for i=numDataSeries:-1:1
            %Check to see if a Tag exists & if it's equal to GridLine
            if (strcmp(myFig.Children(j).Children(i).Tag,'GridLine'))
                % set the gridline up!
                myFig.Children(j).Children(i).LineStyle = '--';
                myFig.Children(j).Children(i).LineWidth = 0.25;
                myFig.Children(j).Children(i).Color     = [128 128 128 80]/255;
                %Opacity?
            else
                if isprop(myFig.Children(j).Children(i),'Marker')
                    myFig.Children(j).Children(i).Marker = strLineMarker(numDataSeries+1-i);
                end
                switch myFig.Children(j).Children(i).Type
                    case 'scatter'
                        myFig.Children(j).Children(i).MarkerEdgeColor = strLineColor{numDataSeries+1-i,:}/255;
                    case 'line'
                        myFig.Children(j).Children(i).Color  = strLineColor{numDataSeries+1-i}/255;
                        if (str2num(verMatlab.Version)>=9.2)
                            %Marker index
                            myFig.Children(j).Children(i).MarkerIndices=1:max(1,floor(length(myFig.Children(j).Children(i).XData)/50)):length(myFig.Children(j).Children(i).XData);
                        end
                    case 'surface'
                        colormap(myFig,morgenstemning);
                    case 'contour'
                        %Load the colormap...
                        colormap(myFig,morgenstemning);
                    case 'image'
                        %Load the colormap...
                        %colormap(myFig,morgenstemning);
                    case 'patch'
                        %Do something standard here?
                        %Only change if Tag field is empty
                        if (isempty(myFig.Children(j).Children(i).Tag))
                            %
                        end
                    case 'light'
                        %Set the lighting up
                        %Only change if Tag field is empty
                        if (isempty(myFig.Children(j).Children(i).Tag))
                            myFig.Children(j).Children(i).Color=[1 1 1];
                        end
                    otherwise
                        myFig.Children(j).Children(i).Color  = strLineColor{numDataSeries+1-i}/255;
                end
            end
        end
    end
catch ME
    ME
    warning(['Failed setting the color and marker scheme for ',myFig.Name,'. Check that a Tag has been set.']);
end


%% Prettify the labels
%X-Label
for i=1:numSubplots
    try
        %Only make pretty if it's visible
        if strcmpi(myFig.Children(i).Type,'axes')
            myFig.Children(i).XMinorTick = 'on';
            PrettyLabel(myFig.Children(i).XLabel);
        end
%         if (myFig.Children(i).XLabel.Visible)
%             PrettyLabel(myFig.Children(i).XLabel);
%             Add the minorticks to anything other than a colorbar
%             if (~strcmpi(myFig.Children(i).Type,'colorbar') || ~strcmpi(myFig.Children(i).Type,'legend'))
%                 myFig.Children(i).XMinorTick = 'on';
%             end
%         end
    catch
        warning(['Failed setting xlabel properties for Figure: ',myFig.Name,' - Object:',myFig.Children(i).Type]);
        outputVals=-1;
    end
end
%Y-Label
for i=1:numSubplots
    try
        %Only make pretty if it's visible
        if strcmpi(myFig.Children(i).Type,'axes')
            myFig.Children(i).YMinorTick = 'on';
            PrettyLabel(myFig.Children(i).YLabel);
        end
%         if (myFig.Children(i).YLabel.Visible)
%             PrettyLabel(myFig.Children(i).YLabel);
%             %Add the minorticks to anything other than a colorbar
%             if ~strcmpi(myFig.Children(i).Type,'colorbar')
%                 myFig.Children(i).YMinorTick = 'on';
%             end
%         end
    catch
        warning(['Failed setting ylabel properties for Figure: ',myFig.Name,' - Object:',myFig.Children(i).Type]);
        outputVals=-1;
    end
end
%Z-Label
for i=1:numSubplots
    try
        %Only make pretty if it's visible
        if strcmpi(myFig.Children(i).Type,'axes')
            myFig.Children(i).ZMinorTick = 'on';
            PrettyLabel(myFig.Children(i).ZLabel);
        end
%         if (myFig.Children(i).ZLabel.Visible)
%             PrettyLabel(myFig.Children(i).ZLabel);
%             %Add the minorticks to anything other than a colorbar
%             if ~strcmpi(myFig.Children(i).Type,'colorbar')
%                 myFig.Children(i).ZMinorTick = 'on';
%             end
%         end
    catch
        warning(['Failed setting zlabel properties for Figure: ',myFig.Name,' - Object:',myFig.Children(i).Type]);
        outputVals=-1;
    end
end


%% Prettify:
%- the axes
%- the colorbar
%- the legend
numChildren = length(myFig.Children);
for i=1:numChildren
    switch myFig.Children(i).Type
        case 'axes'
            try
                PrettyAxes(myFig.Children(i));
            catch
                warning(['Axes type expected for prettification']);
                outputVals = -1;
            end
        case 'legend'
            try
                PrettyLegend(myFig.Children(i));
            catch
                warning(['Legend type expected for prettification']);
                outputVals = -1;
            end
        case 'colorbar'
            try
                PrettyLabel(myFig.Children(i).Label);
                PrettyColorbar(myFig.Children(i));
            catch
                warning(['Colorbar type expected for prettification']);
                outputVals = -1;
            end
        otherwise
            warning(['Unknown child']);
            outputVals = -1;
    end
end


%% Prettify the figure


%% Set the paper size
try
    %Set the paper sizing to nicely fill a single column
    myFig.PaperUnits    = 'centimeters';
    myFig.PaperSize     = figPaperSize;
    myFig.PaperUnits    = 'normalized';
    switch reqType
        case 'P169'
            myFig.PaperPosition = [0.2 0.2 1 16/9];
        otherwise
            myFig.PaperPosition = [0.2 0.2 1 1];
    end
catch
    warning(['Failed setting dimensions for reqType=',reqType]);
    outputVals=-1;
end


end
