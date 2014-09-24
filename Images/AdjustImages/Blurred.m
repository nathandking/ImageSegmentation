
I = imread('../ThreeShapes.jpg');
figure; imshow(I);
intImage = integralImage(I);

avgH = integralKernel([1 1 8 8], 1/64);

J = integralFilter(intImage, avgH);
J = uint8(J); % cast the result back to same class as I
figure; imshow(J); 

J = imnoise(J,'gaussian',0,0.008);

imwrite(J,'../BlurredThreeShapes.jpg')