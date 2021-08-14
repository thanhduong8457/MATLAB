% Load image and bouding box of ...
load Cat_Positive

% Specify folder with nagetive images
negativeFolder = '...';

% Train the detector
NumStage = 5;
FAR = 0.05;

trainCascadeObjectDetector('Cat_Detector.xml',...
    data,negativeFolder,'FalseAlarmRate',FAR,'NumCascadeStages',NumStage);
