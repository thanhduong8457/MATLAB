% Run trained detector on image
% Specify xml file
detectorFile = 'haarcascade_frontalface_default.xml';
% Initialize cascade object detector
detector = vision.CascadeObjectDetector(detectorFile);
% Load test image
I = imread('stop/face.jfif');
% Perform cascade object detection 
bbox = step(detector, I);
% Mark the location on the image using bouding box
J = insertShape(I,'rectangle',bbox);
imshow(J);
% Clean up
release(detector);




% Load test image
%frame = imread('stop/1.jpg');
%figure; imshow(frame);
% Specify xml file
%detectorFile = 'stopSignDetector.xml';
% Initialize cascade object detector
%detector = vision.CascadeObjectDetector(detectorFile);
% Perform cascade object detection 
%bbox = step(detector, frame);
% Overlay results onto image and view
%frame = insertShape(frame,'Rectangle',bbox);
%textLocation = bbox(1:2)+[0 -15];
%frame = insertShape(frame,'FilledRectangle',[textLocation 30 15]);
%TI = vision.TextInserter('Location',textLocation,'Text','Stop');
%frame = step(TI,frame);
%figure; imshow(frame);