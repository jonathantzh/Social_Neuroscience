function [chanNames, chanCount] = parseChanNamesString( headerline )
% parseChanNamesString - extract channel names from header line string
%
% ARGS:
% IN
%       headerline - String giving the line to parse, containing sensor
%                    names (separated by spaces). See below for name
%                    format.
% OUT
%       chanNames  - Cell array of strings giving the channel names
%       chanCount  - Number of channel names in the cell array
%
% All of the channel names are assumed to be in a single-line string
% such as 'FP1-*SD FP2-*SD ...' or 'FP1-F8 FP2-F4 ...' or 'FP1 FP2 ...' for
% example. Only the characters before the '-' in each name are relevant so 
% we strip away the remainder. These are the three formats that have been
% seen in clinical data files so far.
%

    % Init output args
    chanNames = {};     % Cell array of channel/sensor name strings
    chanCount = 0;      % Number of channel/sensor names

    hlen = length(headerline);
    remstr = headerline;        % Remainder string (after token extraction)
    done = 0;
    
    while( ~done )
        % Get each channel name from the second line. Names are of the
        % form XXX-*SD where XXX is a variable length channel name and
        % -*SD are extra characters often appended to the name. We want to
        % strip these extra chars off. Alternatively channel names may be
        % in pairs, such as FP1-F8 in which case we take the first name
        % of the pair.
        [tok, remstr ] = strtok( remstr );
        if ( isempty(tok) || length(tok) == hlen && isempty( remstr ) )
            done = 1;
        else
            chanCount = chanCount+1;
            % disp( ['Token: ' tok] );
            % Look for the first '-' or '/' in the channel name (e.g., FP1-*SD or P8/T8)
            dashInd  = strfind( tok, '-' );
            slashInd = strfind( tok, '/' );
            if ( ~isempty(dashInd) && (dashInd(1) > 1) )
                chanNames{chanCount} = tok(1:dashInd(1)-1);
            elseif ( ~isempty(slashInd) && (slashInd(1) > 1) )
                chanNames{chanCount} = tok(1:slashInd(1)-1);
            else
                chanNames{chanCount} = tok;
            end                
        end
    end
end