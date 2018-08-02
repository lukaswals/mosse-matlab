function [H, G] = initialize_filter(tracking_window, first_image)
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
doAffineTransformations = true;
numberTransformations = 8;  % How many transformations should we apply to the image
trainingSet = cell(numberTransformations, 1);
H = 0;  % Initial filter. This variable is the complex conjugate of the filter
sigma = 2;  % Value for computing the Gaussian of the desired output
% Training parameters
Ai = 0;
Bi = 0;

%{
if debug_mode
    disp('We are in debug mode')
else
    disp('We are NOT in debug mode')
end
%}

%% Obtain desired output with Gaussian shape centered
gaussPlot = gaussian_output(sigma, size(first_image), tracking_window);

%% Crop tracking window and desired output from correspondent images
f = imcrop(first_image, tracking_window);
g = imcrop(gaussPlot, tracking_window);

%% Create more training samples with affine transformations
if doAffineTransformations
    fprintf('Calculating %d affine transformations', numberTransformations);
    for t = 1:numberTransformations
        %figure(1) % Used for plots
        % Preprocess the image to reduce edge effects during convolution
        % after applying the transformation
        template = preprocessing( affine_trans(f) );
        %subplot(3,2,5), imshow( template ), title('Transformation')
        trainingSet{t} = template;
        
        % Obtain DFT of the cropped patches
        G = fft2(g);    %% FT of Desired output
        F = fft2(template);    %% FT of Training sample
        
        Ai = Ai + G .* conj(F);
        Bi = Bi + F .* conj(F);
        
        if debugMode
            figure(1) % Used for plots
            %filter = mat2gray( (ifft2(H)) );

            subplot(3,2,1), imshow(g), title('Desired Output')
            subplot(3,2,2), imshow(template), title('Tracking Window')
            subplot(3,2,3), imshow(G), title('FFT of Desired Output')
            subplot(3,2,4), imshow(F), title('FFT of Tracking Window')
            %subplot(3,2,6), imshow( template ), title('Initial Filter')
            disp('Paused, press enter to continue...')
        	pause;
        end
        
    end
end

H = Ai ./ Bi;

%% Calculate filter
%{
% Preprocess the image to reduce edge effects during convolution
%f = preprocessing(f);
%g = preprocessing(g);
% Obtain DFT of the cropped patches
G = fft2(g);    %% FT of Desired output
F = fft2(f);    %% FT of Training sample
% Calculate filter
Ai = G .* conj(F);
Bi = F .* conj(F);
H = Ai ./ Bi;

if debugMode
    figure(1) % Used for plots
    %filter = mat2gray( (ifft2(H)) );
    template = mat2gray( real(ifft2(H)) );
    
    subplot(3,2,1), imshow(g), title('Desired Output')
    subplot(3,2,2), imshow(f), title('Tracking Window')
    subplot(3,2,3), imshow(G), title('FFT of Desired Output')
    subplot(3,2,4), imshow(F), title('FFT of Tracking Window')
    subplot(3,2,6), imshow( template ), title('Initial Filter')
end
%}

end