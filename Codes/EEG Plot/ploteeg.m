function h = ploteeg( eegmat, sensornames, offset, hfig )
% USAGE: eegPlot( eegmat, sensornames, offset, hfig )
%
% Can be run without any args in which case a file selector dialog will be
% opened. It will read matlab .mat files or ASCII data files. Both files
% must have the data in timesteps X channels orientation. ASCII files can
% contain header lines, the last of which may be a line of sensor names
% (space separated - see 'help parseChanNamesString.m'). EEG plots are
% offset vertically to space them out in the plot.
%
% ARGS:
% In
%       eegmat - Optional. Averaged EEG matrix from simToEEG.m with an
%                orientation of (timesteps x channels)
%  sensornames - Optional. Cell array of strings giving sensor names. If
%                not supplied the names will be {'E1', 'E2', ... }
%       offset - Optional. Offset to apply to each eeg channel for spacing.
%                If not supplied a default offset will be calculated.
%         hfig - Optional. Handle to an existing figure, which will be
%                cleared before drawing to it.
% OUT:
%       h - handle to the figure created
%
% Plot the eeg channels in the 'columns' style found in Brainstorm.
% Each eeg channel has an offset applied so that they are spaced out
% vertically in the plot.
%
% A default offset will be calculated as abs(max-min) of the first channel.
%
% Requires the following files:
%
%   -  parseChanNamesString.m
%   -  txt2mat.m (in Brainstorm)

if ( isempty(which( 'parseChanNamesString.m')) || ...
      isempty(which( 'txt2mat' )) )
      error( 'parseChanNamesString.m and txt2mat.m required' );
end

chanNames = {};
badfile = 0;

% No args
if nargin < 1
    [filename, pathname, filterindex] = uigetfile( ...
       {'*',      'All Files (*.*)'; ...
        '*.mat',  'MAT-files (*.mat)'}, ...
        'Pick an ASCII EEG file or .mat file');
    if isequal(filename,0) || isequal(pathname,0)
        return;
    else
       eegfname = fullfile(pathname, filename);
    end
    if ( filterindex == 2 || ~isempty(strfind(filename, '.mat' )) )
        filecontent = load( eegfname );
        if isempty(filecontent)
            return;
        end
        structnames = fieldnames(filecontent);
        % Access the first field of the matrix read in;
        eegmat = filecontent.(structnames{1});
    else
        % Assume an ASCII data file was read in. It may have header lines
        % in which case we assume the last one gives channel/sensor names.
        % We use txt2mat.m from Brainstorm to read the ASCII file, getting
        % the header lines and numerical data.
        % nh = num header lines
        % hl = header lines (as one long string)
        [eegmat,ffn,nh,SR,hl,fp] = txt2mat( eegfname );
        if ( isempty(eegmat) )
            badfile = 1;
        end
        
        % Parse the header lines returned. Unfortunately multiple lines are
        % returned as one long string with a '10' newline character
        % separating the strings.
        if ( ~badfile && nh > 0 )
            if (nh == 1)
                line_to_parse = hl;
            else
                indices_of_newlines = find(hl(:)==10);
                % There should be a newline at end of last header line so
                % use the index of the last-but-one newline
                num_newlines = length(indices_of_newlines);
                if (num_newlines > 1 )
                    start_of_last_hl = indices_of_newlines(num_newlines-1)+1;
                else
                    start_of_last_hl = 1; % First char of hl
                end
                line_to_parse = hl(start_of_last_hl:end);
            end
            [chanNames, chanCount] = parseChanNamesString( line_to_parse );
            sensornames = chanNames;
        end
    end
end

numtimesteps = size(eegmat, 1);
numchannels  = size(eegmat, 2);
if (badfile || ndims(eegmat) ~= 2 || numtimesteps == 0 || numchannels == 0 || numtimesteps < numchannels)
    uiwait(errordlg( {'Not a recognised file.', ...
                      'It should be a matlab .mat file or an ASCII', ...
                      'file with optional header lines. If a header', ...
                      'is present the last header line can be used to', ...
                      'specify sensor names.', ...
                      'The data should be arranged as timesteps X sensors.'}, ...
                      'Error reading file', 'modal' ));
    return;
end
if nargin < 2
    sensornames = chanNames;
end
if isempty(sensornames) 
    sensornames = {};
    % Create default sensor names
    for i=1:numchannels
        sensornames{i} = [ 'E' num2str(i) ];
    end
end

if nargin < 3
    % Guess a suitable offset by looking at the min and max value
    % of the first EEG channel. 
    mineegchan1 = min( eegmat(:,1), [], 1);
    maxeegchan1 = max( eegmat(:,1), [], 1);
    offset  = abs(maxeegchan1-mineegchan1)*0.5;
    disp( ['Offset ' num2str(offset) ] );
end

% Ensure we have enough sensor names
if ( length(sensornames) ~= numchannels )
    error( ['Number of sensor names (' num2str(length(sensornames)) ...
        ') must match number of channels (' num2str(numchannels) ')' ] );
end

% Pre-alloc an array to hold the new eeg channels
eegwithoffsets = zeros( size(eegmat) );

% An 'offset' column vector to add to columns of eeg
offsets = repmat( offset, numtimesteps, 1 );

% Offset each eeg channel (add offset column vector to eegmat columns)
for i=1:numchannels
    % We use (numchannels-i+1) as the factor to scale the offset by so that
    % EEG 1 (column 1) gets a larger offset and so is plotted at the top of
    % a graph window.
    eegwithoffsets(:,i) = eegmat( :,i ) + offsets*(numchannels-i+1);
end

% Plot the EEG timeseries
% -----------------------
if nargin == 4 && ishandle(hfig)
    h=figure(hfig);
    clf;
else
    h=figure;
end

plot( eegwithoffsets, 'k' );

axis tight
% Add x axis labels and display entire timeline
x_axis = 0:size(eegmat, 1)-1;
xlabel( 'Time' );
xlim( [0 numtimesteps-1 ] );

% Add axes and y-axis tick labels (sensor names) if the EEG plots have
% been spaced out. If not we'll do a 'butterfly' plot (all EEGs on top of
% each other) in which case you won't be able to read the sensor names.
if offset > 0
    
    % Y-axis tick labels will be placed next to the starting point of each
    % EEG timeseries so get the very first timestep of each EEG series.
    % This is given by first row of the matrix (each column is an EEG).
    eegwithoffsets_tstep1 = eegwithoffsets(1,:);
    
    % Now sort these start values because matlab requires the tick label
    % locations to be in ascending order. We must then sort the tick label
    % strings using the same ordering. Hence use the index vector that the
    % sort function generates.
    [y_axis, sortorder] = sort(eegwithoffsets_tstep1);
    y_labels_sorted = sensornames(sortorder);
    
    set( gca, 'YTick', y_axis, 'YTickLabel', y_labels_sorted);
end
end
