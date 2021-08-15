clear all, close all;
I = imread('cameraman.tif');
[H,W] = size(I);
figure, imshow(I);
% Get histogram. hist(i) is the count of pixels with value x(i).
[hist x] = imhist(I);
figure, imhist(I);
% Convert to probability
p = hist/(H*W);
t = 128; % initial guess for threshold
while true
disp(t);
% Group 1 is all pixels with intensity > t 
m1 = (x > t); % create a logical mask; true where x>t
% Compute mean of group 1
u1 = sum( x(m1) .* p(m1) ) / sum(p(m1));
% Group 2 is all pixels with intensity <= t 
m2 = (x <= t); % create a logical mask; true where x<=t
% Compute mean of group 2
u2 = sum( x(m2) .* p(m2) ) / sum(p(m2));
tnew = (u1 + u2)/2;
if t==tnew
break; % Quit if no further changes
else
t = tnew; % Otherwise, this is new threshold
end
end