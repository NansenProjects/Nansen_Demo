function varargout = downloadDemoData(sessionObject, varargin)
%DOWNLOADDEMODATA Download demo data for selected session
%   Downloads a small (500MB) two-photon sample file for the selected
%   session


% % % % % % % % % % % % CONFIGURATION CODE BLOCK % % % % % % % % % % % % 
    
    % Get struct of parameters from local function
    params = getDefaultParameters();
    
    % Create a cell array with attribute keywords
    ATTRIBUTES = {'serial', 'queueable'};   

    
% % % % % % % % % % % % % DEFAULT CODE BLOCK % % % % % % % % % % % % % % 
    
    % Create a struct with "attributes" using a predefined pattern
    import nansen.session.SessionMethod
    fcnAttributes = SessionMethod.setAttributes(params, ATTRIBUTES{:});
    
    if ~nargin && nargout > 0
        varargout = {fcnAttributes};   return
    end
    
    % Parse name-value pairs from function input and update parameters
    params = utility.parsenvpairs(params, [], varargin);
    
    
% % % % % % % % % % % % % % CUSTOM CODE BLOCK % % % % % % % % % % % % % % 
    
    sessionFolder = sessionObject.getSessionFolder('Rawdata', 'force');
    
    rawDownloadURI = matlab.net.URI("https://www.dropbox.com/scl/fi/6sgxqwzo1d8649m917cif/20220503_17_05_26_m1442-20220503-01_XYT_1000.raw?rlkey=78o94637m39xtnidpze31jpui&st=a7m1sz37&dl=1");
    fileName = rawDownloadURI.Path(end);

    rawSavePath = fullfile(sessionFolder, fileName);
    downloadFile(rawSavePath, rawDownloadURI, "DisplayMode", params.DialogMode)
       
    iniDownloadURI = matlab.net.URI("https://www.dropbox.com/scl/fi/3f90o13sdzn0l4f3v6fjr/20220503_17_05_26_m1442-20220503-01_XYT_1000.ini?rlkey=jzr2ko6b76fdya6gghrspo6gv&st=khdlu761&dl=1");
    fileName = iniDownloadURI.Path(end);

    iniSavePath = fullfile(sessionFolder, fileName);
    downloadFile(iniSavePath, iniDownloadURI)

    filePath = sessionObject.getDataFilePath('TwoPhotonSeries_Original');
    assert(strcmp(filePath, rawSavePath), ...
        'File must be reckognized as TwoPhotonSeries_Original')
    
    % Return session object (please do not remove):
    % if nargout; varargout = {sessionObject}; end
end


function params = getDefaultParameters()
%getDefaultParameters Get the default parameters for this session method
%
%   params = getDefaultParameters() should return a struct, params, which 
%   contains fields and values for parameters of this session method.

    % Add fields to this struct in order to define parameters for this
    % session method:
    params = struct();
    params.DialogMode = 'Dialog Box';
end