function [ successValue ] = doGraphing(myFig,pars)
%DOGRAPHING Control look and feel of graphs, saving if required.
%   [ successValue ] = doGraphing(myFig,pars)
%   Calls the FigConfig function, passing in the myFig variable that is a
%   vector of handles to the figures of interest. pars is a structure
%   containing parameters for controlling the operation of the function.
%   pars.OUTPUTTYPE controls the size of the graph produced:
%       T11 - Thesis, single column format, one graph per column
%       T12 - Thesis, single column format, two graphs per column
%       J21 - Journal, double column format, one graph per column
%       J22 - Journal, double column format, two graphs per column
%       P100- Presentations, 100x100mm
%   pars.PRINTGRAPHS is a binary control over the saving of graphs. The
%   saving of graphs relies on the presence of 4 subdirectories:
%       95 - MATLAB Fig Files
%       96 - Images for Presentations
%       97 - Images for Journals
%       98 - Images for Thesis
%   pars.SAE is a binary control that flags if the graph is for SAE or no
%
% (c) Graham Hodgson
% v1.3
% Loughborough University
% 2017.05.11
%
% v.  1.0 - Genesis.
% v.  1.1 - Addition of saving PNG files for presentations if type = P100
% v.  1.2 - Addition of checks around required PARS parameters & addition of SAE parameter to add relevant tag.
% v.  1.3 - Save the fig file if PRINTGRAPHS == 1, and save as .png if an SAE Journal


%% Check for required PARS parameters by checking length and catching if fails
try
    length(pars.OUTPUTTYPE);
catch
    warning('PARS parameter: OUTPUTTYPE not defined!');
    successValue=-1;
    return
end
try
    length(pars.PRINTGRAPHS);
catch
    warning('PARS parameter: PRINTGRAPHS not defined!');
    successValue=-1;
    return
end


%% Set the SAE Flag if required
try
    if (pars.SAE)
        for iFig=1:length(myFig)
            myFig(iFig).Tag='SAE';
        end
    end
catch
    %Do Nothing if the PARS parameter SAE isn't present
end

    
%% Configure the look and feel of the graphs
try
    for iFig=1:length(myFig)
        FigConfig(myFig(iFig),pars.OUTPUTTYPE);
    end
catch
    warning(['Error setting appearance of graph ',num2str(iFig),' - ',myFig(iFig).Name]);
    successValue=-1;
    return;
end


%% Save, if required the graphs
if (pars.PRINTGRAPHS)
    %Look at the output type and define directory accordingly
    try
        switch pars.OUTPUTTYPE(1)
            case 'J'
                dirSave='97 - Images for Journals\';
            case 'T'
                dirSave='98 - Images for Thesis\';
            case 'P'
                dirSave='96 - Images for Presentations\';
            otherwise %Save in current directory
                dirSave='.';
        end
    catch
        warning(['Error in setting directory for saving of graph ',num2str(iFig),' - ',myFig(iFig).Name]);
        successValue=-1;
        return
    end
    
    % Save the fig file
    for iFig=1:length(myFig)
        savefig(myFig(iFig),['95 - MATLAB Fig Files\',pars.OUTPUTTYPE,'_',myFig(iFig).Name],'compact');
    end
    
    % Save the output file
    try
        switch pars.OUTPUTTYPE(1)
            case 'P'
                %Iterate through all graphs saving to .png format
                for iFig=1:length(myFig)
                    figure(myFig(iFig));
                    print([dirSave,pars.OUTPUTTYPE,'_',myFig(iFig).Name,'.png'],'-dpng','-r300');
                end
            otherwise
                %Iterate through all graphs saving to .eps format
                for iFig=1:length(myFig)
                    figure(myFig(iFig));
                    if strcmpi(myFig(iFig).Tag,'SAE')
                        print([dirSave,pars.OUTPUTTYPE,'_',myFig(iFig).Name,'.png'],'-dpng','-r300');
                    else
                        print([dirSave,pars.OUTPUTTYPE,'_',myFig(iFig).Name,'.eps'],'-depsc2','-r300');
                    end
                end
        end
    catch
        warning(['Error in saving graph ',num2str(iFig),' - ',myFig(iFig).Name]);
        successValue=-1;
        return
    end
end


%% Set the final successValue
%If this point has been reached then everything should have been successful
successValue=1;
end

