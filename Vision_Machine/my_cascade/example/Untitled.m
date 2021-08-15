I = [0 0 0 0 0 0
     0 1 1 1 0 0
     0 0 0 0 1 0
     0 0 1 1 0 0
     0 1 0 0 1 0
     0 0 0 0 0 0];
 
 J = padarray(I,[1 1]);
 SE = [0 1 1];
 J1 = imdilate(J,SE);
 
 figure;
 imshow(J,'InitialMagnification','fit')
 figure;
 imshow(J1,'InitialMagnification','fit')