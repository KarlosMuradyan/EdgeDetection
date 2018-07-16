%	Edge Detection Program
%	By Thomas Petrossian and Karlos Muradyan
%	Numerical Analysis Project

% Reads the image from the computer as an input image. We use imread function that is one of the most widely used methods of reading image from graphic file. 
input_image = imread('test.jpg');

%We take height and width of the input picture by using size function. In usual, size funtion has three values in x, y and z directions. As our image is 2D, we only can take height and width of the image. For that, we use the second parameter for size() function, specifying the direction of the size value (x, y or z direction). Value 1 is reffered to the height of the image, 2 is reffered to the width, whereas 3 is depth or z axis direction.
height = size(input_image,1);
width = size (input_image, 2);

%here we create 2D-grid coordinates for height and width of the image. meshgrid function can also create 3D-grid coordinates, but 3D is not in our scope of project.
[x,y] = meshgrid ( -floor(width/2):floor((width-1)/2), -floor(height/2):floor((height-1)/2));

%creating rectangle with the same size as input image. After which we create circle with radius 30 that will be used for High-Pass filtering. 
z = sqrt(x.^2 + y.^2);
c = z>30;

%We also use rgb2gray(RGB) function that converts the truecolor image RGB to grayscale image. It does it job by eliminating hue and saturation information of the input image.
inputImage_gray = rgb2gray(input_image);

%medfilt2() function performs median filtering of the image in two dimensions. In the output each pixel contains median value in 3 by 3 neighborhood around the viewed pixel. This is done in order to remove the noise of the image and have as much clear input as possible.
a = medfilt2(inputImage_gray);

%Here we use two Fourier Transform operations. The first one is fft2() that computes the value of the image in frequency domain. It uses FFT (Fast Fourier Transformation) algorithm. After which, the output is passed to fftshift() function which shifts the low frequency values to the center and high frequency to the edges of the spectrum. After this operations we will have image representation in the frequency domain with low frequences in the center.
shiftedImage = fftshift(fft2(a));

%Here we discard the center of the Fourier Transformed image, so that low frequency values of the input image will not be considered afterwards. In other words here we use High-Pass filtering.
HPShiftedImage = shiftedImage.*c;

%Now, we apply the next filter, butterworth filter. The implementation of the filter is defined in other file. We passed constant values to the filter 110 and 3, but they can be changed regarding to the input image.
hb = butter_filter(HPShiftedImage,110,3);

%Here we get the result of the butterworth effect by multiplying the result of the previous step with High-Pass filtered image. This will result getting the final output in frequency domain. For viewing the image we should firstly change it to time domain, so human eye can interprete objects.
butterfly_effected = HPShiftedImage.*hb;

%By ifft2() function we do inverse Fast Fourier Transform and get image in the time domain.
changedImage = ifft2(butterfly_effected);

%But there is still a small step to do. After doing Fourier Transform in the beginning of the file, we also concentrated all low frequences in the center of the image, while high freqeunces close to the edges. Now we should do the reverse step, so the image can be interpreted by human eye. The function ifftget() is also defined and implemented in different file.
k = ifftget(changedImage);

%And finally, we have the final image, so we can show it. The last is done by imshow(I) function that displays the argument I, if it is grayscale, RGB or binary image.
figure, imshow(k);
