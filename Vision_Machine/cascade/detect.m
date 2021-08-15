vid = VideoReader('test/2.mp4');
detector = vision.CascadeObjectDetector('model2.xml');
while hasFrame(vid)
    vf = readFrame(vid);
    bbox = step(detector,vf);
    detectedImg = insertObjectAnnotation(vf,'rectangle',bbox,'cooker');
    imshow(detectedImg);
end