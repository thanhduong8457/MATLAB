% Use the newly trained classifier to detect a stop sign in an image.
detector = vision.CascadeObjectDetector('training_model.xml');   
%
% Read the test image.
img = imread('test/1.jpg'); 
%
% Detect a stop sign.
bbox = step(detector,img);

% Insert bounding boxes and return marked image.
detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'cooker');   

% Display the detected stop sign.
figure;
imshow(detectedImg);

% Remove the image directory from the path.
% rmpath(imDir);