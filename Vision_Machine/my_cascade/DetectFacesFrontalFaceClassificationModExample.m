%% Detect Faces in an Image Using the Frontal Face Classification Model

% Copyright 2015 The MathWorks, Inc.


%% Create a detector object.
    faceDetector = vision.CascadeObjectDetector; 
    
%% Read input image.
    I = imread('visionteam.jpg');
    
%% Detect faces. 
    bboxes = step(faceDetector, I);
    
%% Annotate detected faces.
   IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');   
   figure, imshow(IFaces), title('Detected faces'); 