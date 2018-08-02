function img = preprocessing(img)
% ------------------------------------------------------------------------------
%PREPROCESSING
%   Normalize pixel values and apply a Cosine Windows in order to reduce the
%   effect introduced during the convolution of the image
%
%   Lucas Wals
% ------------------------------------------------------------------------------
    % Obtain the cosine window
    [x, y] = size(img);
    win = window2(x, y, @hamming);
    eps = 1e-6;
    % Pixel values transformed to help with low contrast lightning situations
    img = log(double(img)+1);
    % Normalize pixel values to have a zero Mean and a Norm(square sum) of 1.0
    img = ( img - mean(img(:)) ) / ( std(img(:)) + eps );
    % Finally, apply cosine window using element-wise multiplication
    img = img .* win;
end