%-------------------------------------------------------------------------
clear variables;
close all;
clc;
%-------------------------------------------------------------------------
inputImg = double(imread('D:/PAMI/Matlab/Segmentation_Data/Lena.bmp'));
% For grayscale input image(bitmap)
%-------------------------------------------------------------------------
numPixels  = size(inputImg,1); 
scaleFactor = 64/numPixels ;
disp(datetime('now'));
resizedImg = imresize(inputImg, scaleFactor);
outputImg  = zeros(64,64,1);
h = 10; % Bandwidth(hs)
th = 0.1; % Stop Threshold
k = 5; % Max iteration
for i = 1:64
    for j = 1:64
    iter = 0;
    intensity = resizedImg(i,j,1);
    meanVal = [i, j, intensity];
     while(iter<=k)
        numerator = 0;
        denominator = 0;
        for i1 = 1:64
           for j1 = 1:64
               pixInt = resizedImg(i1,j1,1);
               im = meanVal(1);
               jm = meanVal(2);
               intm = meanVal(3);
              weight = exp(-1 * ((im - i1)^2 + (jm - j1)^2 + (intm - pixInt)^2)/(h^2));
              numerator = numerator + weight * [i1, j1, pixInt];
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
    outputImg (i,j) = meanVal(3);
    end
end
colormap('gray');
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