function createDemoData(numFrames)
% createDemoData - Create a demo file with a subset of frames.
    if nargin < 1
        numFrames = 1000;
    end

    rootPath = '/Users/eivihe/Data/Nansen Tutorial Data/';
    filepath = fullfile(rootPath, '20220503_17_05_26_m1442-20220503-01_XYT.raw');
    
    numBytes = 512*512*numFrames*2;
    
    filepath_out = strrep(filepath, '.raw', sprintf('_%d.raw', numFrames));
    
    fid = fopen(filepath);
    data = fread(fid, numBytes);
    fclose(fid);

    fid = fopen(filepath_out, 'w');
    fwrite(fid, data);
    fclose(fid);

    % Update inifile...
    iniFilepath = fullfile(rootPath, '20220503_17_05_26_m1442-20220503-01_XYT.ini');
    iniFileStr = fileread(iniFilepath);
    lines = strsplit(iniFileStr, newline);

    lineWithFrames = startsWith(lines, 'no.of.frames.acquired');

    formattedFramesStr = strrep( sprintf('%.12f', numFrames), '.', ',');
    lines{lineWithFrames} = sprintf('no.of.frames.acquired = %s', formattedFramesStr);
    
    ini_filepath_out = strrep(iniFilepath, '.ini', sprintf('_%d.ini', numFrames));

    fid = fopen(ini_filepath_out, 'w');
    fwrite(fid, strjoin(lines, newline));
    fclose(fid);
end
