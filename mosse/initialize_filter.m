function H = initialize_filter(tracking_window, first_image)
% ------------------------------------------------------------------------------
%INITIALIZE_FILTER
%   Initialize MOSSE filter using the first frame and it's correspondent
%   tracking window
%   PARAMETER EXPLANATION COMING SOON
%
%   Lucas Wals
% ------------------------------------------------------------------------------
global debugMode;  % Share DEBUG global variable

%% Function local parameters
doAffineTransformations = false;
numberTransformations = 8;  % How many transformations should we apply to the image
H = 0;  % Initial filter. This variable is the complex conjugate of the filter

%{
if debug_mode
    disp('We are in debug mode')
else
    disp('We are NOT in debug mode')
end
%}

%% Create more training samples with affine transformations
if doAffineTransformations
    disp('Not Available yet');
end

%% Calculate initial filter
% Obtain center of tracking window
center = [tracking_window(2)+tracking_window(4)/2 tracking_window(1)+tracking_window(3)/2];
% Plot gaussian
sigma = 2;
gsize = size(first_image);
[R,C] = ndgrid(1:gsize(1), 1:gsize(2));
gaussPlot = gaussian_output(R,C, sigma, center);

% Crop tracking window and desired output from correspondent images
f = imcrop(first_image, tracking_window);
g = imcrop(gaussPlot, tracking_window);

G = fft2(g);    %% FFT of Desired output
F = fft2(f);    %% FFT of Training sample

Ai = G .* conj(F);
Bi = F .* conj(F);
H = Ai ./ Bi;

if debugMode
    filter = mat2gray( (ifft2(H)) );
    
    subplot(3,2,1), imshow(g), title('Desired Output')
    subplot(3,2,2), imshow(f), title('Tracking Window')
    subplot(3,2,3), imshow(G), title('FFT of Desired Output')
    subplot(3,2,4), imshow(F), title('FFT of Tracking Window')
    subplot(3,2,6), imshow( filter ), title('Initial Filter')
end


end