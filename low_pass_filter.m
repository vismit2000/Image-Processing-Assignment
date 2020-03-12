% *************************************
% Name: Vishal Mittal
% ID: 2017A7PS0080P
%  *************************************

clear all;
close all;

% Read input image
image = imread('input.bmp');
image = double(image);
[m, n] = size(image);

D0 = 25;

M = 2 * m;
N = 2 * n;

padded_img = zeros(M, N);
centered_img = zeros(M, N);

%padding zeros
for i = 1:m
    for j = 1:n
        padded_img(i,j) = image(i,j);
    end
end

%center the transform
for i = 1:m
    for j = 1:n
		centered_img(i,j) = padded_img(i,j) * ((-1)^(i+j));
    end
end

%2D fast fourier transform
Fourier_img = fft2(centered_img);

% low-pass filter in Fourier domain
l_filt = zeros(M, N);
l_filt(M/2 - D0 : M/2 + D0, N/2 - D0 : N/2 + D0) = 1;

Inverse_Fourier_img = zeros(M, N);

% Multiplying F(u,v) by the filter function l_filt
for i = 1:M
    for j = 1:N
        Inverse_Fourier_img(i, j) = Fourier_img(i, j) .* l_filt(i, j);
    end
end

%inverse 2D fast fourier transform
ifimg = ifft2(Inverse_Fourier_img);

% Multiply the result by (-1)^(x+y)
for i = 1:M
    for j = 1:N
    	ifimg(i,j) = ifimg(i,j) * ((-1)^(i+j));
    end
end

% Final output image is g
g = zeros(m, n);

% removing the padding
for i = 1:m
    for j = 1:n
		g(i,j) = ifimg(i,j);
    end
end

% retaining the real parts of the matrix
real_g = real(g);

figure;
% imshow(log( fftshift( abs( fft2(g) ) ) ), []);
imshow(real_g, []);
title('Image after Low-pass filtering');
