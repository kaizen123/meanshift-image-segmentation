%-------------------------------------------------------------------------
clear variables;
close all;
clc;
%-------------------------------------------------------------------------
% For RGB input image(bitmap)
%-------------------------------------------------------------------------
inputImg = double(imread('D:/PAMI/Matlab/Segmentation_Data/LenaRGB.bmp'));
numPixels  = size(inputImg,1); 
scaleFactor = 64/numPixels;
disp(datetime('now'));
resizedImg = imresize(inputImg, scaleFactor);
outputImg  = zeros(64,64,3);
h = 10; % Bandwidth
th = 0.1; % Stop Threshold
k = 5; % Max iteration
for i = 1:64
    for j = 1:64
    iter = 0;
    red = resizedImg(i,j,1);
    green = resizedImg(i,j,2);
    blue = resizedImg(i,j,3);
    meanVal = [i, j, red, green, blue];
     while(iter<=k)
        numerator = 0;
        denominator = 0;
        for i1 = 1:64
           for j1 = 1:64
               r = inputImg(i1,j1,1);
               g = inputImg(i1,j1,2);
               b = inputImg(i1,j1,3);
               im = meanVal(1);
               jm = meanVal(2);
               rm = meanVal(3);
               gm = meanVal(4);
               bm = meanVal(5);
              weight = exp(-1 * ((im - i1)^2 + (jm - j1)^2 + (rm - r)^2 + (gm - g)^2 + (bm - b)^2)/(h^2));
              numerator = numerator + weight * [i1, j1, r, g, b];
              denominator = denominator + weight;
           end
        end
        meanNew = numerator / denominator;
        meanShift = meanNew - meanVal;
        norm(meanShift);
        if(norm(meanShift)<th)
           break; 
        end
        meanVal = meanNew;
        iter = iter + 1;
     end
    outputImg (i,j,1:3) = meanVal(3:5);
    end
end
subplot(2,5,1);
imagesc(uint8(resizedImg));
title('Input Image');
subplot(2,5,2);
imagesc(uint8(imcrop(resizedImg, [0 0 32 32])));
subplot(2,5,3);
imagesc(uint8(imcrop(resizedImg, [32 0 32 32])));
subplot(2,5,4);
imagesc(uint8(imcrop(resizedImg, [0 32 32 32])));
subplot(2,5,5);
imagesc(uint8(imcrop(resizedImg, [32 32 32 32])));
subplot(2,5,6);
imagesc(uint8(outputImg ));
title('Output Image');
subplot(2,5,7);
imagesc(uint8(imcrop(outputImg , [0 0 32 32])));
subplot(2,5,8);
imagesc(uint8(imcrop(outputImg , [32 0 32 32])));
subplot(2,5,9);
imagesc(uint8(imcrop(outputImg , [0 32 32 32])));
subplot(2,5,10);
imagesc(uint8(imcrop(outputImg , [32 32 32 32])));
disp(datetime('now'));