% *************************************
% Name: Vishal Mittal
% ID: 2017A7PS0080P

%  Assignment-II
% *************************************

clear all;
close all;

% Read input image
image = imread('cameraman.tif');
image = double(image);

% Display Original image (figure(1))
figure(1);
imshow(image, []);
title('Original Image');

% Dimensions of image
[m, n] = size(image);

% DCT matrix
C = dctmtx(m);

% DCT transformation
Fu = C*image*C';

% Dimension of box is 20 percent of size of image
dim = int16(0.2 * m);

start_box_x = m - dim + 1;
start_box_y = n - dim + 1;

% Drop the values of the trans. matrix to 0 in 20 pc region of 3rd quad
for i = start_box_x : m
    for j = start_box_y : n
	    Fu(i,j) = 0.0;
    end
end

% Reconstructed image
fRec = C'*Fu*C;

% Display Reconstructed image (figure(2))
figure(2);
imshow(fRec, []);
title('Reconstructed Image');

% Absolute value of error
err = abs(image - fRec);

% Display Error (figure(3))
figure(3);
imshow(err, []);
title('Error image');