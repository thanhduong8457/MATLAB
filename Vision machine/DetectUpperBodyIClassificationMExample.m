%% Detect Upper Body in an Image Using the Upper Body Classification Model.

% Copyright 2015 The MathWorks, Inc.


%% Create a detector object and set properties.
   bodyDetector = vision.CascadeObjectDetector('UpperBody'); 
   bodyDetector.MinSize = [60 60];
   bodyDetector.MergeThreshold = 10;

%% Read input image and detect upper body.
   I2 = imread('visionteam.jpg');
   bboxBody = step(bodyDetector, I2);
   
%% Annotate detected upper bodies.
   IBody = insertObjectAnnotation(I2, 'rectangle',bboxBody,'Upper Body');
   figure, imshow(IBody), title('Detected upper bodies');