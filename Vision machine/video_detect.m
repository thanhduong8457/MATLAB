% Run trained detector on video
% Specify xml file
detectorFile = 'haarcascade_frontalface_default.xml';
% Initialize cascade object detector
detector = vision.CascadeObjectDetector(detectorFile);
% Load input video
videoReader = vision.VideoFileReader('test.mkv');

% Setup for output videp
videoWriter = vision.VideoFileWriter('test_outpur.avi');

% Detect object in video
while ~isDone(videoReader)
    I = step(videoReader);
    bbox = step(detector,I);
    J = insertShape(I,'rectangle',bbox);
    step(videoWriter,J);
end

% Clean up
release(videoReader);
release(videoWriter);
release(detector);
