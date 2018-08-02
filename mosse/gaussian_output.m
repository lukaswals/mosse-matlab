function val = gaussian_output(sigma, img_size, window)
% ------------------------------------------------------------------------------
%GAUSSIAN_OUTPUT
%   Generates a training output with gaussian shape
%   PARAMETER EXPLANATION COMING SOON
%
%   Lucas Wals
% ------------------------------------------------------------------------------
    % Obtain center of tracking window
    center = [window(2)+window(4)/2 window(1)+window(3)/2];
    % Plot gaussian
    %gsize = size(img_size);
    [x,y] = ndgrid(1:img_size(1), 1:img_size(2));
    
    xc = center(1);
    yc = center(2);
    exponent = ((x-xc).^2 + (y-yc).^2)./(2*sigma);
    val = (exp(-exponent)); 
end